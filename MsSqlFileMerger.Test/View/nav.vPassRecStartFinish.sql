use VtsDb3
go

if exists (select 1 from  sysobjects where  id = object_id('nav.vPassRecStartFinish') and   type = 'V') drop view nav.vPassRecStartFinish

go
create view nav.vPassRecStartFinish
as
 
    select P.PassGuid
        , P.PassNumber
        , P.InsertDate
        , p.VesselGuid
        , P.DepartureLocationCode
        , P.DestinationLocationCode
        , P.StartDate
        , P.FinishDate
        , P.PassTypeCode
        , P.VtsCode
        , P.VtsZoneCode
        , P.EtaDate
        , case when not PA.PassGuid is null then 1 else 0 end isActive
        , case when not PD.PassGuid is null then 1 else 0 end isDraft
        , R.rec_cnt PassRecCnt
        , SR.StartDate ReceiptStartDate
        , SR.StartPositionCode
        , SP.PositionTypeCode StartPositionTypeCode
        , FR.FinishDate ReceiptFinishDate
        , FR.FinishPositionCode
        , FP.PositionTypeCode FinishPositionTypeCode
        , SR.ReceiptNumber StartReceiptNumber
        , SR.ReceiptTypeCode StartReceiptTypeCode
        , FR.ReceiptNumber FinishReceiptNumber
        , FR.ReceiptTypeCode FinishReceiptTypeCode
        , SR.ReceiptGuid StartReceiptGuid
        , FR.ReceiptGuid FinishReceiptGuid
        , SR.InsertDate StartReceiptInsertDate
        , FR.InsertDate FinishReceiptInsertDate
    from nav.Pass P
        join (Select PassGuid,row_number() over (partition by PassGuid order by Startdate) rec_num, StartDate,StartPositionCode,ReceiptNumber,ReceiptTypeCode,ReceiptGuid,InsertDate from nav.Receipt) SR on SR.PassGuid=P.PassGuid and SR.rec_num=1
        join (Select PassGuid,row_number() over (partition by PassGuid order by FinishDate desc) rec_num, FinishDate,FinishPositionCode,ReceiptNumber,ReceiptTypeCode,ReceiptGuid,Insertdate from nav.Receipt) FR on FR.PassGuid=P.PassGuid and FR.rec_num=1
        join (Select count(1)rec_cnt, PassGuid from nav.Receipt group by PassGuid) R on R.PassGuid=P.PassGuid
        left join nav.PassActive PA on PA.PassGuid=P.PassGuid
        left join nav.PassDraft PD on PD.PassGuid=P.PassGuid
        left join nsi.Position SP on Sp.PositionCode=SR.StartPositionCode
        left join nsi.Position FP on Fp.PositionCode=FR.FinishPositionCode
go
