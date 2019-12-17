T4_IGNORE

if exists (select 1 from sysobjects where  id = object_id('dbo.TestFunc2') and type in ('IF', 'FN', 'TF')) drop function dbo.TestFunc2

go
create function dbo.TestFunc2 (@g uniqueidentifier)
returns int
as
begin
    return 100;
end