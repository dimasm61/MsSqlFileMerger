T4_IGNORE

if exists (select 1 from sysobjects where  id = object_id('nav.fnGetPrevPassRec') and type in ('IF', 'FN', 'TF')) drop function nav.fnGetPrevPassRec

go
create function nav.fnGetPrevPassRec (@PassGuid uniqueidentifier)
returns 
@Result table (PassGuid uniqueidentifier 
               ,PassNumber nvarchar(10) 
               ,VesselGuid uniqueidentifier 
               ,IsActive bit
               ,PassStartdate datetime
               ,PassFinishDate datetime 
               ,VtsZoneCode varchar(2)
               ,DepartureLocationCode varchar(5)
               ,DestinationLocationCode varchar(5)
               ,ReceiptStartDate datetime
               ,ReceiptFinishDate datetime
               ,StartPostionCode varchar(10)
               ,FinishPostionCode varchar(10)
               ,StartReceiptGuid uniqueidentifier  
               ,FinishReceiptGuid uniqueidentifier  
               )
as
begin

    /*  */

    declare  @Startdate datetime, @VesselGuid uniqueidentifier,@VtsZoneCode varchar(2);

    Select @StartDate=StartDAte, @VesselGuid=VesselGuid from nav.Pass where PassGuid=@PassGuid;

    Insert into @Result (PassGuid, PassNumber, VesselGuid, IsActive, PassStartdate,PassFinishDate, VtsZoneCode,DepartureLocationCode,DestinationLocationCode
                         ,ReceiptStartDate,ReceiptFinishDate,StartPostionCode,FinishPostionCode,StartReceiptGuid,FinishReceiptGuid
    )
    Select top 1 
            P.PassGuid, P.PassNumber, P.VesselGuid, PRSF.isActive, P.Startdate,P.FinishDate, P.VtsZoneCode,P.DepartureLocationCode,P.DestinationLocationCode
            ,PRSF.ReceiptStartDate,PRSF.ReceiptFinishDate,PRSF.StartPositionCode,PRSF.FinishPositionCode,PRSF.StartReceiptGuid,PRSF.FinishReceiptGuid
    from nav.Pass P
    join nav.vPassRecStartFinish PRSF on PRSF.PassGuid=P.PassGuid
    where P.VesselGuid=@VesselGuid 
      and P.StartDate<@StartDate
      and P.IsDeleted=0
    order by P.StartDate;

    return;
end
