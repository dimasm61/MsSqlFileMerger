if exists (select 1 from sysobjects where  id = object_id('nav.fnGetPassRecStartFinish') and type in ('IF', 'FN', 'TF')) drop function nav.fnGetPassRecStartFinish

go
create function nav.fnGetPassRecStartFinish(@PassGuid uniqueidentifier)
returns 
@Result table (PassGuid uniqueidentifier 
               ,PassNumber nvarchar(10) 
			   ,PassInsertdate datetime
			   ,VesselGuid uniqueidentifier 
			   ,PassStartdate datetime
			   ,PassFinishDate datetime 
			   ,VtsCode            nvarchar( 2)
               ,VtsZoneCode        nvarchar( 2)
			   ,DepartureLocationCode varchar(5)
			   ,DestinationLocationCode varchar(5)
			   ,PassDirectionCode  nvarchar(10)
			   ,PassTypeCode varchar(3)
			   ,isActive bit
			   ,PassRecCnt int

			   ,ReceiptStartDate datetime
			   ,StartPositionCode  nvarchar(10)
			   ,StartPositionTypeCode nvarchar(10)

			   ,ReceiptFinishDate datetime
			   ,FinishPositionCode nvarchar(10)
			   ,FinishPositionTypeCode nvarchar(10)

			   ,StartReceiptNumber int
               ,StartReceiptTypeCode nvarchar(10)

               ,FinishReceiptNumber int
               ,FinishReceiptTypeCode nvarchar(10)

			   ,StartReceiptGuid uniqueidentifier
			   ,FinishReceiptGuid uniqueidentifier


               ,StartReceiptInsertDate datetime
               ,FinishReceiptInsertDate datetime
               
			   )
as
begin

   /* 
    
   */

    --Declare @PassGuid uniqueidentifier = 'F6CF49DF-C7E5-4436-8B21-0000C02FCBE9'æ

    Insert into @Result (PassGuid 
               ,PassNumber
			   ,PassInsertDate
			   ,VesselGuid
			   ,PassStartdate
			   ,PassFinishDate
			   ,VtsCode
               ,VtsZoneCode
			   ,DepartureLocationCode
			   ,DestinationLocationCode
			   ,PassDirectionCode
			   ,PassTypeCode
			   ,isActive
			   ,PassRecCnt

			   ,ReceiptStartDate
               ,StartPositionCode
               ,StartPositionTypeCode

               ,ReceiptFinishDate
               ,FinishPositionCode
               ,FinishPositionTypeCode

               ,StartReceiptNumber
               ,StartReceiptTypeCode

               ,FinishReceiptNumber
               ,FinishReceiptTypeCode

               ,StartReceiptGuid
               ,FinishReceiptGuid

               ,StartReceiptInsertDate
               ,FinishReceiptInsertDate
			   )
    select P.PassGuid
          ,P.PassNumber
          ,P.InsertDate
          ,p.VesselGuid
          ,P.StartDate
          ,P.FinishDate
          ,P.VtsCode
          ,P.VtsZoneCode
          ,P.DepartureLocationCode
          ,P.DestinationLocationCode
          ,P.PassDirectionCode
          ,P.PassTypeCode
          ,case when not PA.PassGuid is null then 1 else 0 end isActive
          ,R.rec_cnt PassRecCnt

          ,SR.StartDate ReceiptStartDate
          ,SR.StartPositionCode
          ,SP.PositionTypeCode StartPositionTypeCode
 
          ,FR.FinishDate ReceiptFinishDate
          ,FR.FinishPositionCode
          ,FP.PositionTypeCode FinishPositionTypeCode
  
          ,SR.ReceiptNumber StartReceiptNumber
          ,SR.ReceiptTypeCode StartReceiptTypeCode
   
          ,FR.ReceiptNumber FinishReceiptNumber
          ,FR.ReceiptTypeCode FinishReceiptTypeCode

          ,SR.ReceiptGuid StartReceiptGuid
          ,FR.ReceiptGuid FinishReceiptGuid

          ,SR.InsertDate StartReceiptInsertDate
          ,FR.InsertDate FinishReceiptInsertDate
    from nav.Pass P
    join (Select PassGuid,row_number() over (partition by PassGuid order by Startdate) rec_num, StartDate,StartPositionCode,ReceiptNumber,ReceiptTypeCode,ReceiptGuid,InsertDate
          from nav.Receipt
	      where PassGuid=@PassGuid
	     ) SR on SR.PassGuid=P.PassGuid and SR.rec_num=1
    join (Select PassGuid,row_number() over (partition by PassGuid order by FinishDate desc) rec_num, FinishDate,FinishPositionCode,ReceiptNumber,ReceiptTypeCode,ReceiptGuid,Insertdate
          from nav.Receipt
     	  where PassGuid=@PassGuid
	     ) FR on FR.PassGuid=P.PassGuid and FR.rec_num=1
    join (Select count(1)rec_cnt, PassGuid from nav.Receipt
          where PassGuid=@PassGuid
          group by PassGuid) R on R.PassGuid=P.PassGuid
    left join nav.PassActive PA on PA.PassGuid=P.PassGuid
    left join nsi.Position SP on Sp.PositionCode=SR.StartPositionCode
    left join nsi.Position FP on Fp.PositionCode=FR.FinishPositionCode
    Where P.PassGuid=@PassGuid;

   return 
end
