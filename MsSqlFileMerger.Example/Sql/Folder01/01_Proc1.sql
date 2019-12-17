if exists (select 1 from sysobjects where  id = object_id('dbo.TestProc1')and type in ('P','PC'))  drop procedure dbo.TestProc1 
go

go
create procedure dbo.TestProc1
as 
begin
    select 1;
end
go -- certainly after stored proc

-- some test code
exec dbp.TestProc1