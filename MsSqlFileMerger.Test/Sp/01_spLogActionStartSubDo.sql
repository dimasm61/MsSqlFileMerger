--use DB_LOG
go

if exists (select 1 from sysobjects where  id = object_id('log.spLogActionStartSubDo')and type in ('P','PC'))  drop procedure log.spLogActionStartSubDo 
go 

go
create procedure log.spLogActionStartSubDo
    @logActionId     tinyint                 -- 01
  , @logExecId       tinyint                 -- 02
  , @LogExecParentId tinyint                 -- 03
  , @logOrder        bigint                  -- 04
  , @logLevel        nvarchar( 20)               -- 05
  , @logProcName     nvarchar(100)           -- 08
  , @logMsg          nvarchar(2048)   = null -- 13
  , @logData         nvarchar(2048)   = null -- 14
  , @logDatetime     datetime         = null -- 15
  , @logSpid         int                     -- 17
  , @logNestLevel    int                     -- 18
as
    declare @dtNowUtc datetime = getutcdate()
begin
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
        , null
        , null
        , @logProcName
        , @logLevel
        , null
        , null
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