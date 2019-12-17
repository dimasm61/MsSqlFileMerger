use VtsDb3
go

if exists (select 1 from  sysobjects where  id = object_id('dbo.TestView') and   type = 'V') drop view dbo.TestView

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