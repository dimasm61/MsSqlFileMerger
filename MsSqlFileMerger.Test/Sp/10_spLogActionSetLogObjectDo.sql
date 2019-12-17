--use DB_LOG
go

if exists (select 1 from sysobjects where  id = object_id('log.spLogActionSetLogObjectDo')and type in ('P','PC'))  drop procedure log.spLogActionSetLogObjectDo 
go

go
create procedure log.spLogActionSetLogObjectDo 
       @LogActionId    tinyint
     , @logObjectType  nvarchar(10)
     , @logObjectGuid  uniqueidentifier
as
begin

    -- вставляем связку между "бизнес-объектом" и ActionId
    -- может получиться так, что вызов будет не один раз, запоминаем посление данные

    merge log.AppLogCacheObj as target
    using (select @LogActionId, @logObjectType, @logObjectGuid ) 
        as source (LogActionId, LogObjectType, LogObjectGuid )
    on (target.LogActionId = source.LogActionId)
    when matched
        then update set 
            target.LogObjectType = source.LogObjectType
            ,target.LogObjectGuid = source.LogObjectGuid
    when not matched
        then insert values(LogActionId, LogObjectType, LogObjectGuid )
       ;

    -- insert into log.AppLogCacheObj (
    --       LogActionId  
    --     , LogObjectType
    --     , LogObjectGuid )
    -- select
    --       @LogActionId   
    --     , @logObjectType 
    --     , @logObjectGuid 
end
go