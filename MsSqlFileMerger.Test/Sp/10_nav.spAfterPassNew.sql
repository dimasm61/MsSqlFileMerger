if exists (select 1 from sysobjects where id = object_id('nav.spAfterPassNew')and type in ('P','PC'))  drop procedure nav.spAfterPassNew

go
create procedure nav.spAfterPassNew @PassGuid uniqueidentifier
as 
begin

    
    print '---'
end
go