go
alter function db.func01()
returns int
as
begin
    return 1
end
------------------
go
create function dbo.func02() returns int
as
begin
    return 1
end
------------------
go
create function dbo.func03() returns int as
begin
    return 1
end
------------------
go
create function dbo.func04() returns int as begin return 1 end
------------------
go
create 
 function dbo.func05()
returns int
as
begin  return 1 end
------------------
go
create 
  function 
    dbo.func06() returns 
    int
as begin
    return 1
end
------------------
go
create 
  function 
    dbo.func07() returns 
    int
as begin
    return 1
end
------------------
go
alter function dbo.func08()
returns table
as
    return( select '' as a)
--------------



go
alter function db.func09() --
returns int
as
begin
    return 1
end
------------------
go
create function dbo.func10() /*  */ returns int
as
begin
    return 1
end
------------------
go
create function dbo.func11() /*


*/ returns int as
begin
    return 1
end
------------------
go
/*

*/ 
create function dbo.func12() 
/*

*/ 
returns int /*  */ as
/*

*/ 
begin
    return 1
end
------------------
go
create function dbo.func13() returns int as /*  */ begin return 1 end
------------------
go
create /*   */
 function dbo.func14()
returns int
as /*  */
begin  return 1 end
------------------
go
create  --
  function 
  /*  
  */
    dbo.func15() returns 
    int
as begin
    return 1
end
------------------
go
create 
  function /*  
  
  
  */ dbo.func16() returns 
    int
as begin
    return 1
end
------------------
go
alter function dbo.func17()
returns table
as /* 


*/
    return( select '' as a)

go
-------------------------
go
alter function db.func18()
returns table
as /* 

create 
  function /*  
  
  
  */ dbo.func1() returns 
    int
    ---
as begin
    return 1
end
*/  return( select '' as  a)