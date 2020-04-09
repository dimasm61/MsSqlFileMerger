go
alter procedure db.proc01

as
begin
    return 1
end
------------------
go
create procedure dbo.proc02 
as
begin
    return 1
end
------------------
go
create procedure dbo.proc03  as
begin
    return 1
end
------------------
go
create procedure dbo.proc04  as begin return 1 end
------------------
go
create 
 procedure dbo.proc05

as
begin  return 1 end
------------------
go
create 
  procedure 
    dbo.proc06 
as begin
    return 1
end
------------------
go
create 
  procedure 
    dbo.proc07 
as begin
    return 1
end
------------------
go
alter procedure dbo.proc08

as
    return( select '' as a)
--------------

use db1
go

go
alter procedure db.proc09 --

as
begin
    return 1
end
------------------
go
create procedure dbo.proc10 /*  */ 
as
begin
    return 1
end
------------------
go
create procedure dbo.proc11 /*


*/  as
begin
    return 1
end
------------------
go
/*

*/ 
create procedure dbo.proc12 
/*

*/ 
 /*  */ as
/*

*/ 
begin
    return 1
end
------------------
go
create procedure dbo.proc13  as /*  */ begin return 1 end
------------------
go
create /*   */
 procedure dbo.proc14

as /*  */
begin  return 1 end
------------------
go
create  --
  procedure 
  /*  
  */
    dbo.proc15 
as begin
    return 1
end


go
------------------
go
create 
  procedure /*  
  
  
  */ dbo.proc16 
as begin
    return 1
end
------------------
go
alter procedure dbo.proc17

as /* 


*/
    return( select '' as a)

go
-------------------------
go
alter procedure dbo.proc18

as /* 

create 
  procedure /*  
  
  
  */ dbo.proc1 returns 
    int
    ---
as begin
    return 1
end
*/  return( select '' as  a)
go

CREATE PROCEDURE dbo.proc19 AS SELECT 1, 10
go