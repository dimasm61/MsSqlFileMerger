

-- time 25.12.2019 10:59

use TEST_LOG;
go;

if exists(select 1 from sysobjects where id = object_id('dbo.TestView')and type = 'V')
    drop view dbo.TestView
go

if exists(select 1 from sysobjects where id = object_id('dbo.TestProc1')and type in ('P', 'PC'))
    drop procedure dbo.TestProc1
go

if exists(select 1 from sysobjects where id = object_id('dbo.TestView')and type = 'V')
    drop view dbo.TestView
go

if exists(select 1 from sysobjects where id = object_id('dbo.TestProc1')and type in ('P', 'PC'))
    drop procedure dbo.TestProc1
go


-- ∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
go
create procedure dbo.TestProc1
as 
begin
    -- ver:0.0.1.9, date:25.12.2019
    select 1;
end
go

-- ∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
go
create view dbo.TestView
as
              select 1, newid()
    union all select 2, newid()
    union all select 3, newid()
    union all select 4, newid()
    union all select 5, newid()
go

-- ∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
go
create procedure dbo.TestProc1
as 
begin
    select 1;
end
go

-- ∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
go
create view dbo.TestView
as
              select 1, newid()
    union all select 2, newid()
    union all select 3, newid()
    union all select 4, newid()
    union all select 5, newid()
go

