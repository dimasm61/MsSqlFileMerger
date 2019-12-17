--use DB_LOG
go


if exists (select 1 from sysobjects where  id = object_id('log.spLogSimpleDo')and type in ('P','PC'))  
    drop procedure log.spLogSimpleDo 
go   

go
create procedure log.spLogSimpleDo
     @logOrder       bigint
   , @logProcName    nvarchar(255)
   , @logDb          nvarchar(50)
   , @logMsg         nvarchar(255)
   , @logDatetime    datetime
   , @logData        nvarchar(2048) = null
   , @logObjectType  nvarchar(10)     = null
   , @logObjectGuid  uniqueidentifier = null
as
begin
    -- Simple - подразумевает "простой" вызов, то есть по сути замена обычного Print, где не нужно
    -- будет потом понимать к какой ХП это относится
    -- По этому без кэширования сразу вставляем в AppLog

    insert into log.AppLog(
           LogLevel          
         , LogDatetime       
         , LogAppVersion     
         , LogDb
         , LogModule         
         , LogSpid           
         , LogActionId       
         , LogActionOrder
         , LogNestLevel 
         , LogProcName       
         , LogMsg            
         , LogData           
         , LogExecId         
         , LogExecParentId 
         , LogUserLogin   
         , LogObjectType
         , LogObjectGuid     
         , LogOrder
         )
    select
           'trace'        -- LogLevel
         , @logDatetime   -- LogDatetime
         , null           -- LogAppVersion
         , @logDb         -- LogDb
         , '-'            -- LogModule
         , 0              -- LogSpid
         , 0              -- LogActionId
         , 0              -- LogActionOrder
         , 0              -- LogNestLevel
         , @logProcName   -- LogProcName
         , @logMsg        -- LogMsg
         , @logData       -- LogData
         , 0              -- LogExecId
         , 0              -- LogExecParentId
         , null           -- LogUserLogin
         , @logObjectType -- LogObjectType
         , @logObjectGuid -- LogObjectGuid
         , @logOrder      -- LogOrder

   -- print 'exec spLogSimpleDo ' + isnull(cast( @@rowcount as nvarchar(5)),'null');
end
go