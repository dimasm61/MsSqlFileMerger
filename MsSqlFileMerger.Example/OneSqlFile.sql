

-- create order 3
if exists(select 1 from sysobjects where id = object_id('dbo.TestView')and type = 'V')
    drop view dbo.TestView
go

-- create order 2
if exists(select 1 from sysobjects where id = object_id('dbo.TestProc1')and type in ('P', 'PC'))
    drop procedure dbo.TestProc1
go

-- create order 1
if exists(select 1 from sysobjects where id = object_id('dbo.TestView')and type = 'V')
    drop view dbo.TestView
go

-- create order 0
if exists(select 1 from sysobjects where id = object_id('dbo.TestProc1')and type in ('P', 'PC'))
    drop procedure dbo.TestProc1
go

--------------------------------------------------------
-- source file M:\github_dimasm61\MsSqlFileMerger\\MsSqlFileMerger.Example\Sql\Folder01\01_Proc1.sql
-- create order 0
go
create procedure dbo.TestProc1
as 
begin
    select 1;
end
go -- certainly after stored proc

-- some test code
exec dbp.TestProc1
go

-- source file M:\github_dimasm61\MsSqlFileMerger\\MsSqlFileMerger.Example\Sql\Folder01\02_View1.sql
-- create order 1
go
create view dbo.TestView
as
              select 1, newid()
    union all select 2, newid()
    union all select 3, newid()
    union all select 4, newid()
    union all select 5, newid()
go

-- source file M:\github_dimasm61\MsSqlFileMerger\\MsSqlFileMerger.Example\Sql\Folder02\01_Proc2.sql
-- create order 2
go
create procedure dbo.TestProc1
as 
begin
    select 1;
end
go -- certainly after stored proc

-- some test code
exec dbp.TestProc1
go

-- source file M:\github_dimasm61\MsSqlFileMerger\\MsSqlFileMerger.Example\Sql\Folder02\02_View2.sql
-- create order 3
go
create view dbo.TestView
as
              select 1, newid()
    union all select 2, newid()
    union all select 3, newid()
    union all select 4, newid()
    union all select 5, newid()
go

