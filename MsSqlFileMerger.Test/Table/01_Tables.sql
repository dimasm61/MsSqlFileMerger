--use DB_LOG
go

go
-- drop exists tables, indexes,
---------------------------------------------------------------------------
if exists(select 1 from information_schema.tables where table_name = 'AppLogCacheMsg'  and table_schema = 'log')
    drop table log.AppLogCacheMsg

if exists(select 1 from information_schema.tables where table_name = 'AppLogCacheObj'  and table_schema = 'log')
    drop table log.AppLogCacheObj

if exists(select 1 from information_schema.tables where table_name = 'AppLogMeta'  and table_schema = 'log')
    drop table log.AppLogMeta
---------------------------------------------------------------------------
if exists(select 1 from information_schema.tables where table_name = 'AppLog'  and table_schema = 'log')
begin
    --drop index Idx_AppLogLogOrder on log.AppLog with ( online = off )
    --drop index Idx_Stamp on log.AppLog with ( online = off )
    drop table log.AppLog
end
if exists(select 1 from information_schema.tables where table_name = 'AppLogArchive'  and table_schema = 'log')
begin
    drop index Idx_AppLogArcLogOrder on log.AppLogArchive with ( online = off )
    drop table log.AppLogArchive
end
---------------------------------------------------------------------------
if exists(select 1 from information_schema.tables where table_name = 'AppLogSettings'  and table_schema = 'log')
begin
    drop trigger log.AppLogSettings_ModifyTrigger
    drop table log.AppLogSettings
end
---------------------------------------------------------------------------
go
create table log.AppLogSettings(
    -- name of program module
    LogModule         nvarchar(100)  not null
    -- enable/disable log to DB for LogModule
  , IsEnabledDbLog    bit            not null default 0
    -- enable/disable log message to stdout (print command)
  , IsEnabledPrint    bit            not null default 0
    -- list of enabled log levels, null = ALL
  , IsEnabledLogLevel nvarchar(1024)     null default 'all'
  , UpdateDate        datetime       not null default getdate()
  , constraint [pk_logAppLogSetting] primary key (LogModule asc)
)

go
create trigger log.AppLogSettings_ModifyTrigger on log.AppLogSettings 
after insert, update
as
begin
    update log.AppLogSettings set UpdateDate = getdate() 
    from INSERTED as i where log.AppLogSettings.LogModule = i.LogModule
end 
go
go
create table log.AppLog(
          AppLogGuid     uniqueidentifier rowguidcol  
                                            not null default newid() 
        , LogLevel         nvarchar( 20)    not null -- error, info, debug
        , LogDatetime      datetime         not null -- 
        , LogAppVersion    nvarchar( 24)        null -- версия приложения которое подключилось - SQL и ServerVts
        , LogDb            nvarchar( 50)        null -- база данных из которой пишется лог
        , LogModule        nvarchar(100)        null -- компонент - "область": квитанции, связки, автоматизация, нси
        , LogSpid          int                  null -- ID подключения
                           
        , LogActionId      tinyint              null -- ID вызова, глобальный идентификатор вызова
        , LogActionOrder   smallint             null -- порядок выполнения внутри одного
        , LogNestLevel     smallint             null -- вложенность вызова хранимых процедур
                           
        , LogProcName      nvarchar(255)        null -- название хранимой процедуры
        , LogMsg           nvarchar(max)        null -- сообщение
        , LogData          nvarchar(max)        null -- дополнительные данные
        , LogExecId        tinyint              null -- уникальный номер вызова ХП
        , LogExecParentId  tinyint              null -- ID ХП которая вызвала эту ХП
                           
        , LogUserLogin     nvarchar(100)        null -- логин пользовтеля
        , LogObjectType    nvarchar( 10)        null -- тип бизнес объекта
        , LogObjectGuid    uniqueidentifier     null -- UID бизнес объекта
        
        , LogOrder         bigint               not null -- глобальный порядковый номер
        , constraint [pk_applog] primary key nonclustered (AppLogGuid asc)
    )-- create table
go
create clustered index [Idx_AppLogLogOrder] on log.AppLog
    (
        LogOrder asc
    )with (pad_index = off, statistics_norecompute = off, sort_in_tempdb = off, drop_existing = off, online = off, allow_row_locks = on, allow_page_locks = on) on [primary]
go

if exists(select 1 from sys.sequences where name = 'LogOrderSeq')
    alter sequence log.LogOrderSeq restart with -9223372036854775808 ; 
go
---------------------------------------------------------------------------
create table log.AppLogArchive(
          AppLogGuid     uniqueidentifier rowguidcol  
                                            not null default newid() 
        , LogLevel         nvarchar( 20)    not null -- error, info, debug
        , LogDatetime      datetime         not null -- 
        , LogAppVersion    nvarchar( 24)        null -- версия приложения которое подключилось - SQL и ServerVts
        , LogDb            nvarchar( 50)        null -- база данных из которой пишется лог
        , LogModule        nvarchar(100)        null -- компонент - "область": квитанции, связки, автоматизация, нси
        , LogSpid          int                  null -- ID подключения
                           
        , LogActionId      tinyint              null -- ID вызова, глобальный идентификатор вызова
        , LogActionOrder   smallint             null -- порядок выполнения внутри одного
        , LogNestLevel     smallint             null -- вложенность вызова хранимых процедур
                           
        , LogProcName      nvarchar(255)        null -- название хранимой процедуры
        , LogMsg           nvarchar(max)        null -- сообщение
        , LogData          nvarchar(max)        null -- дополнительные данные
        , LogExecId        tinyint              null -- уникальный номер вызова ХП
        , LogExecParentId  tinyint              null -- ID ХП которая вызвала эту ХП
                           
        , LogUserLogin     nvarchar(100)        null -- логин пользовтеля
        , LogObjectType    nvarchar( 10)        null -- тип бизнес объекта
        , LogObjectGuid    uniqueidentifier     null -- UID бизнес объекта
        
        , LogOrder         bigint               not null -- глобальный порядковый номер
        , constraint [pk_applogarchive] primary key nonclustered (AppLogGuid asc)
    )-- create table
go
create clustered index Idx_AppLogArcLogOrder on log.AppLogArchive
    (
        LogOrder asc
    )with (pad_index = off, statistics_norecompute = off, sort_in_tempdb = off, drop_existing = off, online = off, allow_row_locks = on, allow_page_locks = on) on [primary]
go
---------------------------------------------------------------------------------

-- таблица для запоминания данных при вызове "старт"
create table log.AppLogMeta(
          LogActionId        tinyint          not null
        , LogExecId          tinyint          not null
        , LogExecParentId    tinyint          not null
        , LogSpid            int              not null
        , LogModule          nvarchar(100)        null
        , LogDb              nvarchar( 50)        null
        , LogProcName        nvarchar(100)    not null
        , LogLevel           nvarchar( 20)        null
        , LogAppVersion      nvarchar( 24)        null
        , LogUserLogin       nvarchar(100)        null
        , InsertUtcDate      datetime         not null default getutcdate()
        , UpdateUtcDate      datetime         not null default getutcdate()
        , ConversationHandle uniqueidentifier     null
    )-- create table
go


------------------------------------------------------------------
go
-- таблица для запоминания записей которые приходят до finish, 
create table log.AppLogCacheMsg(
          LogActionId        tinyint              null
        , LogExecId          tinyint          not null
        , LogOrder           bigint           not null
        , LogLevel           nvarchar( 20)    not null
        , LogDatetime        datetime             null
        , LogMsg             nvarchar(max)        null
        , LogData            nvarchar(max)        null 
        , LogNestLevel       int                  null
        , IsFinishMsg        bit             default 0
    )-- create table
go
------------------------------------------------------------------
go
-- таблица для запоминания указаний бизнес-объекта
-- на случай если этот евент придет раньше чем start
create table log.AppLogCacheObj(
          LogActionId    tinyint
        , LogObjectType  nvarchar(10)
        , LogObjectGuid  uniqueidentifier
    )-- create table
go