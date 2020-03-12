

------------------------------------------------------------------------
-- file M:\github_dimasm61\MsSqlFileMerger\\MsSqlFileMerger.Example\Sql\ScriptBefore.sql
-- some script BEFORE
-- line 1
-- line 2
-- line 3
-- line 4
------------------------------------------------------------------------

use TEST_LOG
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


/* ================================================================== */


/* ------------------------------------------------------------------ */

-- source file M:\github_dimasm61\MsSqlFileMerger\\MsSqlFileMerger.Example\Sql\Folder01\01_Proc1.sql
-- generate order 0
go
create procedure dbo.TestProc1
as 
begin
    -- [version], [date]
    select 1;
end
go -- certainly after stored proc

-- some test code
exec dbp.TestProc1
go


/* ------------------------------------------------------------------ */

-- source file M:\github_dimasm61\MsSqlFileMerger\\MsSqlFileMerger.Example\Sql\Folder01\02_View1.sql
-- generate order 1
go
create view dbo.TestView
as
              select 1, newid()
    union all select 2, newid()
    union all select 3, newid()
    union all select 4, newid()
    union all select 5, newid()
go

select * from dbo.TestView
go


/* ------------------------------------------------------------------ */

-- source file M:\github_dimasm61\MsSqlFileMerger\\MsSqlFileMerger.Example\Sql\Folder02\01_Proc2.sql
-- generate order 2
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

------------------------------------------------------------------------
-- file M:\github_dimasm61\MsSqlFileMerger\\MsSqlFileMerger.Example\Sql\ScriptAfter.sql
-- some script AFTER
-- line 1
-- line 2
-- line 3
-- line 4
------------------------------------------------------------------------

