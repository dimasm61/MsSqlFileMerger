T4_IGNORE

if exists (select 1 from sysobjects where  id = object_id('nav.fnGetPrevPass') and type in ('IF', 'FN', 'TF')) drop function nav.fnGetPrevPass

go
create function nav.fnGetPrevPass (@PassGuid uniqueidentifier, @VtsZoneCode varchar(2) = null)
returns 
@Result table (PassGuid uniqueidentifier, 
               PassNumber nvarchar(10), 
               VesselGuid uniqueidentifier, 
               Startdate datetime,
               FinishDate datetime, 
               VtsZoneCode varchar(2),
               DepartureLocationCode varchar(5),
               DestinationLocationCode varchar(5)
               )
as
begin

    /*   */

    declare  @Startdate datetime, @VesselGuid uniqueidentifier--,@VtsZoneCode varchar(2);

    Select @StartDate=StartDAte, @VesselGuid=VesselGuid from nav.Pass where PassGuid=@PassGuid;

    Insert into @Result (PassGuid, PassNumber, VesselGuid, Startdate,FinishDate, VtsZoneCode,DepartureLocationCode,DestinationLocationCode)
    Select top 1 PassGuid, PassNumber, VesselGuid, Startdate,FinishDate, VtsZoneCode,DepartureLocationCode,DestinationLocationCode
    from nav.Pass
    where VesselGuid=@VesselGuid 
      and VtsZoneCode=isNull(@VtsZoneCode,VtsZoneCode)
      and StartDate<@StartDate
      and IsDeleted=0
    order by StartDate;

    return;
end