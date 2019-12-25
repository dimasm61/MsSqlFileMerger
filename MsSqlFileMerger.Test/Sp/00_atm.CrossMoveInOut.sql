if exists (select 1 from sysobjects where id = object_id('atm.CrossMoveInOut'    )and type in ('P','PC'))  drop procedure atm.CrossMoveInOut

go
create procedure [atm].[CrossMoveInOut]
      @vesselGuid             uniqueidentifier
    , @crossType              nvarchar( 5) -- in/out
    , @dspName                nvarchar(20)
    , @actDate                datetime
    , @actPositionCode        nvarchar(10)
    , @actPositionTypeCode    nvarchar(10)
    , @actVtsCode             nvarchar( 2)
    , @actZoneCode            nvarchar( 2)     
    , @actLat                 float            = null
    , @actLon                 float            = null
    , @actUserOnWatch         nvarchar(512)    = null
    , @newPassGuid            uniqueidentifier output
as
    declare @actPassDirectionCode nvarchar(10)
begin
    -- 2019/11/14 МДО
    -- смотрим какое пересечение линии
    -- In (Inner - внутренняя линия) = ВЫХОД, или Out (Outer) внешняя линия = ВХОД
    set @newPassGuid = null
   
    declare @prevPassGuid           uniqueidentifier
    declare @prevReceiptTypeCode    nvarchar( 5)
    declare @prevVtsCode            nvarchar( 2)
    declare @prevVtsZoneCode        nvarchar( 2)
    declare @prevPassDirectionCode  nvarchar(10)
    declare @prevStartPositionCode  nvarchar(10)
    declare @prevFinishPositionCode nvarchar(10)
	declare @prevStartDate          datetime
	declare @prevEtaDate            datetime
	declare @prevIsActive           bit
	declare @prevIsDraft            bit

	--------- ВЫХОД---------------
    if @crossType = 'in' 
    begin -- внутрення линия, то есть ВЫХОД
	    -- найдем последний активный судопроход в данной зоне
		Select   
	          @prevPassGuid           = PassGuid
            , @prevReceiptTypeCode    = ReceiptTypeCode
            , @prevVtsCode            = VtsCode
            , @prevVtsZoneCode        = VtsZoneCode
            , @prevPassDirectionCode  = PassDirectionCode
            , @prevStartPositionCode  = StartPositionCode
            , @prevFinishPositionCode = FinishPositionCode
		    , @prevStartDate          = PassStartDate
		    , @prevEtaDate            = EtaDate
	    from atm.fnGetVesselLastPass(@vesselGuid,@actZoneCode)
	    where isActive=1;

		if @prevPassGuid is not null
        begin--  если есть активный судопроход нужно его закрыть

            insert into atm.AutomationCommand
            select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'ClosePass'           -- AutomationCommandCode   nvarchar(100) not null -- код - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- код источника (кто это сделал) - TRANSAS, SYNCHRO, USER. Таблица [nsi].[Initiator]
                  , @prevPassGuid         -- ActPassGuid             uniqueidentifier null -- код судопрохода
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- код судна
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- код типа квитанции
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- код позиции
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- код СУДС
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- код зоны
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- направление движения
                  , @actLat               -- ActLat                  float            null -- координаты события
                  , @actLon               -- ActLon                  float            null -- координаты события
                  , @actDate              -- ActDate                 datetime         null -- время события автоматизации (когда пришел сигнал)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- логины операторов стоящих на вахте в данный момент
                  , getdate()             -- InsertDate              datetime      not null -- дата/время вставки в таблицу
                  , null                  -- LoadedDate              datetime          null -- дата/время прочтения сервером
                  , null                  -- StartProcessingDate     datetime          null -- дата/время начала обработки
                  , null                  -- ComplitedDate           datetime          null -- дата/время завершения обработки
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- результат выполнения
                  , null                  -- LogActionId             tinyint           null -- уникальный идентификатор "бизнес действия", должен совпадать с тем что попадет в логи

        end
    end else
	----- ВХОД --------------------
    if @crossType = 'out' 
	begin -- внешняя линия, то есть ВХОД
	     -- найдем последний судопроход в данной зоне (активный или черновик)
		Select   
	          @prevPassGuid           = PassGuid
            , @prevReceiptTypeCode    = ReceiptTypeCode
            , @prevVtsCode            = VtsCode
            , @prevVtsZoneCode        = VtsZoneCode
            , @prevPassDirectionCode  = PassDirectionCode
            , @prevStartPositionCode  = StartPositionCode
            , @prevFinishPositionCode = FinishPositionCode
		    , @prevStartDate          = PassStartDate
		    , @prevEtaDate            = EtaDate
			, @prevIsActive           = isActive
			, @prevIsDraft            = isDraft
	    from atm.fnGetVesselLastPass(@vesselGuid,@actZoneCode)
	    where isActive=1 or isDraft=1;


	    if not @prevPassGuid is null and @prevIsActive=1
        begin -- есть активный судопроход надо проверить его актуальность, возможено он только что создан (например дурги центром автоматизации)
		    -- пока критерирй актуальности такой: (надо его обсудить!!!) 
		    -- если начальная дата судопрохода раньше текущей более чем на 30 минут
	        -- или если начальная дата на указана то ожидаемая дата прибытия раньше текущей более чем на 60 минут
            if (not @prevStartDate is null and abs(Datediff(minute, @actDate,@prevStartDate))>30) or (@prevStartDate is null and abs(Datediff(minute, @actDate,@prevEtaDate))>30) -- старый
		    begin -- если судопроход старый то надо его закрыть и открыть новый
                insert into atm.AutomationCommand
                select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'ClosePass'           -- AutomationCommandCode   nvarchar(100) not null -- код - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- код источника (кто это сделал) - TRANSAS, SYNCHRO, USER. Таблица [nsi].[Initiator]
                  , @prevPassGuid         -- ActPassGuid             uniqueidentifier null -- код судопрохода
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- код судна
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- код типа квитанции
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- код позиции
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- код СУДС
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- код зоны
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- направление движения
                  , @actLat               -- ActLat                  float            null -- координаты события
                  , @actLon               -- ActLon                  float            null -- координаты события
                  , @actDate              -- ActDate                 datetime         null -- время события автоматизации (когда пришел сигнал)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- логины операторов стоящих на вахте в данный момент
                  , getdate()             -- InsertDate              datetime      not null -- дата/время вставки в таблицу
                  , null                  -- LoadedDate              datetime          null -- дата/время прочтения сервером
                  , null                  -- StartProcessingDate     datetime          null -- дата/время начала обработки
                  , null                  -- ComplitedDate           datetime          null -- дата/время завершения обработки
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- результат выполнения
                  , null                  -- LogActionId             tinyint           null -- уникальный идентификатор "бизнес действия", должен совпадать с тем что попадет в логи

				  -- закрыли старый нужно создать судопроход в данной позиции

				  -- по позиции, типу позиции вычисляем откуда пришло судно- "с севера"/"с юга"
		          Set @actPassDirectionCode =atm.fnGetDirectionByInPos(@actPositionCode,@crossType);

				  set @newPassGuid=newid();
          
                  insert into atm.AutomationCommand
                  select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'CreatePass'          -- AutomationCommandCode   nvarchar(100) not null -- код - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- код источника (кто это сделал) - TRANSAS, SYNCHRO, USER. Таблица [nsi].[Initiator]
                  , @newPassGuid          -- ActPassGuid             uniqueidentifier null -- код судопрохода
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- код судна
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- код типа квитанции
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- код позиции
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- код СУДС
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- код зоны
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- направление движения
                  , @actLat               -- ActLat                  float            null -- координаты события
                  , @actLon               -- ActLon                  float            null -- координаты события
                  , @actDate              -- ActDate                 datetime         null -- время события автоматизации (когда пришел сигнал)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- логины операторов стоящих на вахте в данный момент
                  , getdate()             -- InsertDate              datetime      not null -- дата/время вставки в таблицу
                  , null                  -- LoadedDate              datetime          null -- дата/время прочтения сервером
                  , null                  -- StartProcessingDate     datetime          null -- дата/время начала обработки
                  , null                  -- ComplitedDate           datetime          null -- дата/время завершения обработки
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- результат выполнения
                  , null                  -- LogActionId             tinyint           null -- уникальный идентификатор "бизнес действия", должен совпадать с тем что попадет в логи

		    end
		    else
		    begin
		        -- если уже существующий судопроход является актуальным 
	            -- указываем старый как новый
  		        set @newPassGuid=@prevPassGuid;        
			    -- более ничего делать не надо 
            end
       end
	   else
	   if not @prevPassGuid is null and @prevIsDraft=1
	   begin -- нет активного судопрода, но есть черновик
	      -- надо сделать черновик активным
		  -- по позиции, типу позиции вычисляем откуда пришло судно- "с севера"/"с юга"
		  Set @actPassDirectionCode =atm.fnGetDirectionByInPos(@actPositionCode,@crossType);
	      set @newPassGuid=@prevPassGuid;        
          insert into atm.AutomationCommand
            select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'CreatePassFromDraft'          -- AutomationCommandCode   nvarchar(100) not null -- код - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- код источника (кто это сделал) - TRANSAS, SYNCHRO, USER. Таблица [nsi].[Initiator]
                  , @newPassGuid          -- ActPassGuid             uniqueidentifier null -- код судопрохода
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- код судна
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- код типа квитанции
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- код позиции
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- код СУДС
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- код зоны
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- направление движения
                  , @actLat               -- ActLat                  float            null -- координаты события
                  , @actLon               -- ActLon                  float            null -- координаты события
                  , @actDate              -- ActDate                 datetime         null -- время события автоматизации (когда пришел сигнал)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- логины операторов стоящих на вахте в данный момент
                  , getdate()             -- InsertDate              datetime      not null -- дата/время вставки в таблицу
                  , null                  -- LoadedDate              datetime          null -- дата/время прочтения сервером
                  , null                  -- StartProcessingDate     datetime          null -- дата/время начала обработки
                  , null                  -- ComplitedDate           datetime          null -- дата/время завершения обработки
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- результат выполнения
                  , null                  -- LogActionId             tinyint           null -- уникальный идентификатор "бизнес действия", должен совпадать с тем что попадет в логи
	   end
	   else
	   begin
	       -- нет ни активного судопрохода ни черновика
	       -- нужно создать судопроход в данной позиции
		   -- по позиции, типу позиции вычисляем откуда пришло судно- "с севера"/"с юга"
		    Set @actPassDirectionCode =atm.fnGetDirectionByInPos(@actPositionCode,@crossType);
		    set @newPassGuid=newid();
            insert into atm.AutomationCommand
            select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'CreatePass'          -- AutomationCommandCode   nvarchar(100) not null -- код - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- код источника (кто это сделал) - TRANSAS, SYNCHRO, USER. Таблица [nsi].[Initiator]
                  , @newPassGuid          -- ActPassGuid             uniqueidentifier null -- код судопрохода
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- код судна
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- код типа квитанции
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- код позиции
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- код СУДС
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- код зоны
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- направление движения
                  , @actLat               -- ActLat                  float            null -- координаты события
                  , @actLon               -- ActLon                  float            null -- координаты события
                  , @actDate              -- ActDate                 datetime         null -- время события автоматизации (когда пришел сигнал)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- логины операторов стоящих на вахте в данный момент
                  , getdate()             -- InsertDate              datetime      not null -- дата/время вставки в таблицу
                  , null                  -- LoadedDate              datetime          null -- дата/время прочтения сервером
                  , null                  -- StartProcessingDate     datetime          null -- дата/время начала обработки
                  , null                  -- ComplitedDate           datetime          null -- дата/время завершения обработки
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- результат выполнения
                  , null                  -- LogActionId             tinyint           null -- уникальный идентификатор "бизнес действия", должен совпадать с тем что попадет в логи
	   end
    end
end
