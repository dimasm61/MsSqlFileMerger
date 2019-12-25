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
    -- 2019/11/14 ���
    -- ������� ����� ����������� �����
    -- In (Inner - ���������� �����) = �����, ��� Out (Outer) ������� ����� = ����
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

	--------- �����---------------
    if @crossType = 'in' 
    begin -- ��������� �����, �� ���� �����
	    -- ������ ��������� �������� ���������� � ������ ����
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
        begin--  ���� ���� �������� ���������� ����� ��� �������

            insert into atm.AutomationCommand
            select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'ClosePass'           -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @prevPassGuid         -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����

        end
    end else
	----- ���� --------------------
    if @crossType = 'out' 
	begin -- ������� �����, �� ���� ����
	     -- ������ ��������� ���������� � ������ ���� (�������� ��� ��������)
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
        begin -- ���� �������� ���������� ���� ��������� ��� ������������, ��������� �� ������ ��� ������ (�������� ����� ������� �������������)
		    -- ���� ��������� ������������ �����: (���� ��� ��������!!!) 
		    -- ���� ��������� ���� ����������� ������ ������� ����� ��� �� 30 �����
	        -- ��� ���� ��������� ���� �� ������� �� ��������� ���� �������� ������ ������� ����� ��� �� 60 �����
            if (not @prevStartDate is null and abs(Datediff(minute, @actDate,@prevStartDate))>30) or (@prevStartDate is null and abs(Datediff(minute, @actDate,@prevEtaDate))>30) -- ������
		    begin -- ���� ���������� ������ �� ���� ��� ������� � ������� �����
                insert into atm.AutomationCommand
                select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'ClosePass'           -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @prevPassGuid         -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����

				  -- ������� ������ ����� ������� ���������� � ������ �������

				  -- �� �������, ���� ������� ��������� ������ ������ �����- "� ������"/"� ���"
		          Set @actPassDirectionCode =atm.fnGetDirectionByInPos(@actPositionCode,@crossType);

				  set @newPassGuid=newid();
          
                  insert into atm.AutomationCommand
                  select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'CreatePass'          -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @newPassGuid          -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����

		    end
		    else
		    begin
		        -- ���� ��� ������������ ���������� �������� ���������� 
	            -- ��������� ������ ��� �����
  		        set @newPassGuid=@prevPassGuid;        
			    -- ����� ������ ������ �� ���� 
            end
       end
	   else
	   if not @prevPassGuid is null and @prevIsDraft=1
	   begin -- ��� ��������� ���������, �� ���� ��������
	      -- ���� ������� �������� ��������
		  -- �� �������, ���� ������� ��������� ������ ������ �����- "� ������"/"� ���"
		  Set @actPassDirectionCode =atm.fnGetDirectionByInPos(@actPositionCode,@crossType);
	      set @newPassGuid=@prevPassGuid;        
          insert into atm.AutomationCommand
            select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'CreatePassFromDraft'          -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @newPassGuid          -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����
	   end
	   else
	   begin
	       -- ��� �� ��������� ����������� �� ���������
	       -- ����� ������� ���������� � ������ �������
		   -- �� �������, ���� ������� ��������� ������ ������ �����- "� ������"/"� ���"
		    Set @actPassDirectionCode =atm.fnGetDirectionByInPos(@actPositionCode,@crossType);
		    set @newPassGuid=newid();
            insert into atm.AutomationCommand
            select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'CreatePass'          -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @newPassGuid          -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����
	   end
    end
end
