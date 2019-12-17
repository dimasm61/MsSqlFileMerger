-- use DB_LOG
go

if exists (select 1 from sysobjects where  id = object_id('log.spLogActionFinishDo')and type in ('P','PC'))  drop procedure log.spLogActionFinishDo 
go 

go
create procedure log.spLogActionFinishDo
     @LogExecId    tinyint
   , @logOrder     bigint
   , @logLevel     nvarchar( 20)  = null 
   , @logDatetime  datetime       = null
   , @logMsg       nvarchar(2000) = null
   , @logData      nvarchar(2000) = null
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
        , 1                   -- IsFinishMsg   
    
    -- если это сообщение об окончании всего Action
    if exists(select 1 from log.AppLogMeta where LogExecId = LogActionId and LogExecId = @logExecId)
    begin

        raiserror('@ start delay convertsation', 10,1) with log
        declare @conversationHandle uniqueidentifier
        -- запустим обработку с задержкой
        begin dialog conversation @conversationHandle from service AsyncLogDelayTimerService to service 'AsyncLogDelayService';
        begin conversation timer (@conversationHandle) timeout = 5;

        declare @msg nvarchar(100) = cast(@conversationHandle as nvarchar(100))
        raiserror(@msg, 10,1) with log
        -- set @conversationHandle = newid();
        -- пометим номер диалога, чтоб в обработчике знать сообщения какого ActionId перекидывать из кэша в лог
        update log.AppLogMeta set ConversationHandle = @conversationHandle
        where LogExecId = LogActionId and LogExecId = @logExecId
    end
end
go