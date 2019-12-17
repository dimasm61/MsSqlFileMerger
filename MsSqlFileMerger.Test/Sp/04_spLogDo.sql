-- use DB_LOG
go

if exists (select 1 from sysobjects where  id = object_id('log.spLogDo')and type in ('P','PC'))  drop procedure log.spLogDo 
go   

go
create procedure log.spLogDo
      @LogExecId    tinyint
    , @logOrder     bigint
    , @logLevel     nvarchar( 20)
    , @logMsg       nvarchar(max)
    , @logData      nvarchar(max) = null
    , @logDatetime  datetime      = null
    , @logNestLevel int
as
begin

    if @logDatetime is null set @logDatetime = getdate();

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
          null                -- LogActionId
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