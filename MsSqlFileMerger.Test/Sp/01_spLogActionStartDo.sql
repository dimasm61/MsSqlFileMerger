-- use DB_LOG
go

if exists (select 1 from sysobjects where  id = object_id('log.spLogActionStartDo')and type in ('P','PC'))  drop procedure log.spLogActionStartDo 
go 

go
create procedure log.spLogActionStartDo
    @logActionId     tinyint                     -- 01
  , @logExecId       tinyint                     -- 02
  , @LogExecParentId tinyint                     -- 03
  , @logOrder        bigint                      -- 04
  , @logLevel        nvarchar( 20)               -- 05
  , @logDb           nvarchar( 20)               -- 06
  , @logModule       nvarchar(100)               -- 07
  , @logProcName     nvarchar(100)               -- 08
  , @logUserLogin    nvarchar(100)               -- 09
  , @appVersion      nvarchar( 20)               -- 10
  , @logObjectType   nvarchar( 10)               -- 11
  , @logObjectGuid   uniqueidentifier = null     -- 12
  , @logMsg          nvarchar(2048)   = null     -- 13
  , @logData         nvarchar(2048)   = null     -- 14
  , @logDatetime     datetime         = null     -- 15
  , @logSpid         int                         -- 17
  , @logNestLevel    int                         -- 18
as
    declare @isEnabledDbLog    bit
    declare @isEnabledPrint    bit
    declare @isEnabledLogLevel nvarchar(1024)

    declare @dtNowUtc        datetime= getutcdate();
begin

    -- дек 2018 МДО
    -- выполняется уже асинхронно брокером

    -- настроки "модуля", включен или нет
    select top 1
         @isEnabledDbLog    = IsEnabledDbLog   
       , @isEnabledPrint    = IsEnabledPrint   
       , @isEnabledLogLevel = IsEnabledLogLevel
    from log.AppLogSettings 
    where lower(LogModule) = lower(@logModule)

    -- если записи в настройках нет - включаем по дефолту
    if @isEnabledDbLog is null
    begin
        set @isEnabledDbLog    = 1
        set @isEnabledPrint    = 0
        set @isEnabledLogLevel = 'all'
        insert into log.AppLogSettings(LogModule, IsEnabledDbLog, IsEnabledPrint, IsEnabledLogLevel)
        select @logModule,@isEnabledDbLog,@isEnabledPrint,@isEnabledLogLevel
    end

    if @isEnabledDbLog = 0 return;

    ----------------------------------------------------------------------------------

    -- запомним метаданные этой ХП 
    insert into log.AppLogMeta(
          LogActionId
        , LogExecId
        , LogExecParentId
        , LogSpid
        , LogModule
        , LogDb
        , LogProcName
        , LogLevel
        , LogAppVersion
        , LogUserLogin
        , InsertUtcDate
        , UpdateUtcDate
        )
    select 
          @LogActionId 
        , @LogExecId
        , @LogExecParentId
        , @logSpid
        , @logModule
        , @logDb
        , @logProcName
        , @logLevel
        , @appVersion
        , @logUserLogin
        , @dtNowUtc
        , @dtNowUtc

    if @logMsg  is not null set @logMsg = 'Start: ' + @logMsg else set @logMsg = 'Start'
    if @logData is     null set @logData = '----------------------------------------'

    -- поместим запись в кэш
    insert into log.AppLogCacheMsg(
          LogActionId
        , LogExecId          -- tinyint          not null
        , LogOrder           -- bigint           not null
        , LogLevel           -- nvarchar( 20)    not null
        , LogDatetime        -- datetime             null
        , LogMsg             -- nvarchar(max)        null
        , LogData            -- nvarchar(max)        null 
        , LogNestLevel       -- int                  null
        , IsFinishMsg        -- bit             default 0
        )
    select
          @LogActionId        -- LogActionId
        , @LogExecId          -- LogExecId     
        , @logOrder           -- LogOrder      
        , @logLevel           -- LogLevel      
        , @logDatetime        -- LogDatetime   
        , @logMsg             -- LogMsg        
        , @logData            -- LogData        
        , @logNestLevel       -- LogNestLevel  
        , 0                   -- IsFinishMsg   

end
go