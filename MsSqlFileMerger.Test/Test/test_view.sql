go
alter view db.view01
as
    select 1
------------------
go
create view [dbo].view02  as /* */
select 1
------------------
go
create view dbo.[view03] -- dbo.View3  
as
select
1
go
------------------
go
create view [dbo].[view04] /**/  as select 1
go
------------------
go
create /**/
 view dbo.view05
 as
        select
          1 as b
go
select * from view05
------------------
go
/* create 
  view 
    dbo.view06  
    as
select 1
*/
create 
  view 
    dbo.view06  
    as
select 1
