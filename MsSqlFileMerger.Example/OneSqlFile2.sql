

use VTSDB3_1
go

-- create order 54
if exists(select 1 from sysobjects where id = object_id('nav.PassArchiveSelect')and type in ('P', 'PC'))
    drop procedure nav.PassArchiveSelect
go

-- create order 53
if exists(select 1 from sysobjects where id = object_id('nav.spAfterReceiptRemove')and type in ('P', 'PC'))
    drop procedure nav.spAfterReceiptRemove
go

-- create order 52
if exists(select 1 from sysobjects where id = object_id('nav.spAfterReceiptNew')and type in ('P', 'PC'))
    drop procedure nav.spAfterReceiptNew
go

-- create order 51
if exists(select 1 from sysobjects where id = object_id('nav.spAfterPassSave')and type in ('P', 'PC'))
    drop procedure nav.spAfterPassSave
go

-- create order 50
if exists(select 1 from sysobjects where id = object_id('nav.spAfterPassRemove')and type in ('P', 'PC'))
    drop procedure nav.spAfterPassRemove
go

-- create order 49
if exists(select 1 from sysobjects where id = object_id('nav.spAfterPassClose')and type in ('P', 'PC'))
    drop procedure nav.spAfterPassClose
go

-- create order 48
if exists(select 1 from sysobjects where id = object_id('nav.spAfterPassNew')and type in ('P', 'PC'))
    drop procedure nav.spAfterPassNew
go

-- create order 47
if exists(select 1 from sysobjects where id = object_id('atm.AutoProcessing')and type in ('P', 'PC'))
    drop procedure atm.AutoProcessing
go

-- create order 46
if exists(select 1 from sysobjects where id = object_id('atm.CrossMoveInOut')and type in ('P', 'PC'))
    drop procedure atm.CrossMoveInOut
go

-- create order 45
if exists(select 1 from sysobjects where id = object_id('atm.CrossLineMoorInOut')and type in ('P', 'PC'))
    drop procedure atm.CrossLineMoorInOut
go

-- create order 44
if exists(select 1 from sysobjects where id = object_id('atm.CrossLineBorder')and type in ('P', 'PC'))
    drop procedure atm.CrossLineBorder
go

-- create order 43
if exists(select 1 from sysobjects where id = object_id('atm.CrossEventLine')and type in ('P', 'PC'))
    drop procedure atm.CrossEventLine
go

-- create order 42
if exists(select 1 from sysobjects where id = object_id('atm.AutoLineCross')and type in ('P', 'PC'))
    drop procedure atm.AutoLineCross
go

-- create order 41
if exists(select 1 from sysobjects where id = object_id('nav.fnGetVesselLastPass')and type in ('IF', 'FN', 'TF'))
    drop function nav.fnGetVesselLastPass
go

-- create order 40
if exists(select 1 from sysobjects where id = object_id('nav.fnGetVesselDraft')and type in ('IF', 'FN', 'TF'))
    drop function nav.fnGetVesselDraft
go

-- create order 39
if exists(select 1 from sysobjects where id = object_id('nav.fnGetVesselActivePass')and type in ('IF', 'FN', 'TF'))
    drop function nav.fnGetVesselActivePass
go

-- create order 38
if exists(select 1 from sysobjects where id = object_id('nav.fnGetPrevPassRec')and type in ('IF', 'FN', 'TF'))
    drop function nav.fnGetPrevPassRec
go

-- create order 37
if exists(select 1 from sysobjects where id = object_id('nav.fnGetPrevPass')and type in ('IF', 'FN', 'TF'))
    drop function nav.fnGetPrevPass
go

-- create order 36
if exists(select 1 from sysobjects where id = object_id('nav.fnGetPassRecStartFinish')and type in ('IF', 'FN', 'TF'))
    drop function nav.fnGetPassRecStartFinish
go

-- create order 35
if exists(select 1 from sysobjects where id = object_id('nav.fnPassTypeCode')and type in ('IF', 'FN', 'TF'))
    drop function nav.fnPassTypeCode
go

-- create order 34
if exists(select 1 from sysobjects where id = object_id('nav.fnGetPassTypeCode')and type in ('IF', 'FN', 'TF'))
    drop function nav.fnGetPassTypeCode
go

-- create order 33
if exists(select 1 from sysobjects where id = object_id('nav.fnGetDirectionByInPosTranz')and type in ('IF', 'FN', 'TF'))
    drop function nav.fnGetDirectionByInPosTranz
go

-- create order 32
if exists(select 1 from sysobjects where id = object_id('nav.fnGetDirectionByInPos')and type in ('IF', 'FN', 'TF'))
    drop function nav.fnGetDirectionByInPos
go

-- create order 31
if exists(select 1 from sysobjects where id = object_id('nav.vPassRecStartFinish')and type = 'V')
    drop view nav.vPassRecStartFinish
go

-- create order 30
if exists(select 1 from sysobjects where id = object_id('cnt.vPassContact')and type = 'V')
    drop view cnt.vPassContact
go

-- create order 29
if exists(select 1 from sysobjects where id = object_id('usr.vWatchAll')and type = 'V')
    drop view usr.vWatchAll
go

-- create order 28
if exists(select 1 from sysobjects where id = object_id('usr.vAppUser')and type = 'V')
    drop view usr.vAppUser
go

-- create order 27
if exists(select 1 from sysobjects where id = object_id('snr.vWeather')and type = 'V')
    drop view snr.vWeather
go

-- create order 26
if exists(select 1 from sysobjects where id = object_id('snr.vNavtex')and type = 'V')
    drop view snr.vNavtex
go

-- create order 25
if exists(select 1 from sysobjects where id = object_id('snr.vAis')and type = 'V')
    drop view snr.vAis
go

-- create order 24
if exists(select 1 from sysobjects where id = object_id('scn.vScanZonePass')and type = 'V')
    drop view scn.vScanZonePass
go

-- create order 23
if exists(select 1 from sysobjects where id = object_id('sgn.vNavigationSign')and type = 'V')
    drop view sgn.vNavigationSign
go

-- create order 22
if exists(select 1 from sysobjects where id = object_id('rqt.vWebRequest')and type = 'V')
    drop view rqt.vWebRequest
go

-- create order 21
if exists(select 1 from sysobjects where id = object_id('rqt.vPassRequest')and type = 'V')
    drop view rqt.vPassRequest
go

-- create order 20
if exists(select 1 from sysobjects where id = object_id('rqt.vFax')and type = 'V')
    drop view rqt.vFax
go

-- create order 19
if exists(select 1 from sysobjects where id = object_id('plt.vPilot')and type = 'V')
    drop view plt.vPilot
go

-- create order 18
if exists(select 1 from sysobjects where id = object_id('nav.vReceipt')and type = 'V')
    drop view nav.vReceipt
go

-- create order 17
if exists(select 1 from sysobjects where id = object_id('nav.vPassEvent')and type = 'V')
    drop view nav.vPassEvent
go

-- create order 16
if exists(select 1 from sysobjects where id = object_id('nav.vPass')and type = 'V')
    drop view nav.vPass
go

-- create order 15
if exists(select 1 from sysobjects where id = object_id('nav.vActReceipt')and type = 'V')
    drop view nav.vActReceipt
go

-- create order 14
if exists(select 1 from sysobjects where id = object_id('nav.vActPassVessel')and type = 'V')
    drop view nav.vActPassVessel
go

-- create order 13
if exists(select 1 from sysobjects where id = object_id('nav.vActPass')and type = 'V')
    drop view nav.vActPass
go

-- create order 12
if exists(select 1 from sysobjects where id = object_id('nav.vActCaravanInfo')and type = 'V')
    drop view nav.vActCaravanInfo
go

-- create order 11
if exists(select 1 from sysobjects where id = object_id('nav.vPassActive')and type = 'V')
    drop view nav.vPassActive
go

-- create order 10
if exists(select 1 from sysobjects where id = object_id('pln.vPlanVessel')and type = 'V')
    drop view pln.vPlanVessel
go

-- create order 9
if exists(select 1 from sysobjects where id = object_id('pln.vPlanTransit')and type = 'V')
    drop view pln.vPlanTransit
go

-- create order 8
if exists(select 1 from sysobjects where id = object_id('pln.vPlanTraffic')and type = 'V')
    drop view pln.vPlanTraffic
go

-- create order 7
if exists(select 1 from sysobjects where id = object_id('nsi.vVtsZone')and type = 'V')
    drop view nsi.vVtsZone
go

-- create order 6
if exists(select 1 from sysobjects where id = object_id('nsi.vVessel')and type = 'V')
    drop view nsi.vVessel
go

-- create order 5
if exists(select 1 from sysobjects where id = object_id('nsi.vTown')and type = 'V')
    drop view nsi.vTown
go

-- create order 4
if exists(select 1 from sysobjects where id = object_id('nsi.vPosition')and type = 'V')
    drop view nsi.vPosition
go

-- create order 3
if exists(select 1 from sysobjects where id = object_id('nsi.vPort')and type = 'V')
    drop view nsi.vPort
go

-- create order 2
if exists(select 1 from sysobjects where id = object_id('nsi.vLocation')and type = 'V')
    drop view nsi.vLocation
go

-- create order 1
if exists(select 1 from sysobjects where id = object_id('nsi.vCompany')and type = 'V')
    drop view nsi.vCompany
go

-- create order 0
if exists(select 1 from sysobjects where id = object_id('nsi.vCargoType')and type = 'V')
    drop view nsi.vCargoType
go


/* ================================================================== */


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Nsi\nsi.vCargoType.sql
-- generate order 0
go
create view nsi.vCargoType as
       select
           ct.CargoTypeCode
          ,ct.CargoTypeName
          ,ct.CargoTypeGroupCode
          ,ctg.CargoTypeGroupName
          ,ct.CargoUnitCode
          ,ctu.CargoUnitName
          ,ctu.CargoUnitNameShort
          ,ct.SortOrder
          ,ct.IsDeleted
          ,ct.InsertDate
          ,ct.UpdateDate
          ,ct.RsbmGuid
          ,ct.PlanId
    from nsi.CargoType as ct
    left join nsi.CargoTypeGroup as ctg on ctg.CargoTypeGroupCode = ct.CargoTypeGroupCode
    left join nsi.CargoUnit      as ctu on ctu.CargoUnitCode      = ct.CargoUnitCode

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Nsi\nsi.vCompany.sql
-- generate order 1
go
create view nsi.vCompany as
       select c.CompanyGuid
             ,c.CompanyTypeCode
             ,ct.CompanyTypeName
             ,c.TownCode
             ,t.TownName
             ,c.CountryCode
             ,cn.CountryName
             ,c.VtsZoneCodeList
             ,c.CompanyImoNo
             ,c.CompanyName
             ,c.CompanyNameEn
             ,c.CompanyAddress
             ,c.CompanyTel
             ,c.CompanyFax
             ,c.CompanyWeb
             ,c.CompanyEmail
             ,c.AgentContract
             ,c.AgentCode
             ,c.NhUid
             ,c.IsDeleted
             ,c.InsertDate
             ,c.UpdateDate
             ,c.RsbmGuid
             ,c.PlanId
    from nsi.Company c
    left join nsi.Country     as cn on cn.CountryCode     = c.CountryCode
    left join nsi.Town        as t  on t.TownCode         = c.TownCode
    left join nsi.CompanyType as ct on ct.CompanyTypeCode = c.CompanyTypeCode
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Nsi\nsi.vLocation.sql
-- generate order 2
go
create view  nsi.vLocation
as 
    select c.CountryCode      as LocationCode
         , c.CountryNameShort as LocationName
		 , 'CNT'              as LocationTypeCode
		 , lt.LocationTypeName
		 , l.SortOrder
		 , l.IsDeleted
		 , l.IsVisible
		 , l.InsertDate
		 , l.UpdateDate
      from VTSDB3.nsi.Country c
 left join nsi.Location     l  on l.LocationCode      = c.CountryCode
 left join nsi.LocationType lt on lt.LocationTypeCode = 'CNT'
     where c.IsDeleted = 0
       and exists(select top 1 1 from VTSDB3.nsi.Location where LocationCode = CountryCode and IsVisible = 1)
	   
union all

    select p.PortCode as LocationCode
         , p.PortName as LocationName
		 , 'PRT'      as LocationTypeCode
		 , lt.LocationTypeName
		 , l.SortOrder
		 , l.IsDeleted
		 , l.IsVisible
		 , l.InsertDate
		 , l.UpdateDate
      from VTSDB3.nsi.Port p
 left join nsi.Location     l  on l.LocationCode      = p.PortCode
 left join nsi.LocationType lt on lt.LocationTypeCode = 'PRT'
     where p.IsDeleted = 0
       and exists(select top 1 1 from VTSDB3.nsi.Location where LocationCode = PortCode and IsVisible = 1)

union all

    select s.SeaAreaCode as LocationCode
         , s.SeaAreaName as LocationName
		 , 'SAR'         as LocationTypeCode
		 , lt.LocationTypeName
		 , l.SortOrder
		 , l.IsDeleted
		 , l.IsVisible
		 , l.InsertDate
		 , l.UpdateDate
      from VTSDB3.nsi.SeaArea s
 left join nsi.Location     l  on l.LocationCode      = s.SeaAreaCode
 left join nsi.LocationType lt on lt.LocationTypeCode = 'SAR'
	 where s.IsDeleted = 0
       and exists(select top 1 1 from VTSDB3.nsi.Location where LocationCode = SeaAreaCode and IsVisible = 1)
 

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Nsi\nsi.vPort.sql
-- generate order 3
go
create view [nsi].[vPort] as 
       select
        p.PortCode
      , p.CountryCode
      , c.CountryName
      , c.CountryNameEn
      , p.PortName
      , p.PortNameEn
      , p.SortOrder
      , p.IsDeleted
      , p.InsertDate
      , p.UpdateDate
      , p.RsbmGuid
      , p.PlanId
  from nsi.[Port] as p
  left join nsi.Country as c on c.CountryCode = p.CountryCode
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Nsi\nsi.vPosition.sql
-- generate order 4
go
create view nsi.vPosition as
    select p.PositionCode
          ,p.PositionTypeCode
          ,pt.PositionTypeName
          ,p.VtsZoneCode
          ,vz.VtsZoneName
          ,p.PortCode
          ,pr.PortName
          ,p.PositionName
          ,p.PositionNameShort
          ,p.PositionNote
          ,p.PositionMaxDepth
          ,p.PositionActionList
          ,p.IsSystem
          ,p.SortOrder
          ,p.IsDeleted
          ,p.InsertDate
          ,p.UpdateDate
          ,p.ViewVtsZoneList
          ,p.RsbmGuid
          ,p.PlanId
     FROM VTSDB3.nsi.Position p
     left join nsi.PositionType as pt on pt.PositionTypeCode = p.PositionTypeCode
     left join nsi.VtsZone      as vz on vz.VtsZoneCode      = p.VtsZoneCode
     left join nsi.Port         as pr on pr.PortCode         = p.PortCode
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Nsi\nsi.vTown.sql
-- generate order 5
go
create view nsi.vTown as
       select
            t.TownCode
          , t.CountryCode
          , c.CountryName
          , c.CountryNameEn
          , t.TownName
          , t.TownNameEn
          , t.SortOrder
          , t.IsDeleted
          , t.InsertDate
          , t.UpdateDate
          , t.PlanId
    from nsi.Town as t
    left join nsi.Country as c on c.CountryCode = t.CountryCode

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Nsi\nsi.vVessel.sql
-- generate order 6
go
create view nsi.vVessel as
       select v.VesselGuid
	         ,v.OwnerCompanyGuid
             ,oc.CompanyName as OwnerCompanyName
			 ,v.FlagCode
             ,c.CountryName as FlagName
			 ,v.VesselTypeCode
             ,vt.VesselTypeName
             ,v.VesselName
             ,v.VesselNameEn
             ,v.VesselImo
             ,v.VesselMmsi
             ,v.VesselCallSign
			 ,v.VesselIceClassCode
             ,i.VesselIceClassName
             ,v.VesselBuildYear
             ,ROUND (v.VesselLength,          2) as VesselLength        
             ,ROUND (v.VesselLengthCert,      2) as VesselLengthCert		
             ,ROUND (v.VesselWidth,           2) as VesselWidth			
             ,ROUND (v.VesselWidthCert,       2) as VesselWidthCert		
             ,ROUND (v.VesselHeightBoard,     2) as VesselHeightBoard	
             ,ROUND (v.VesselHeightBoardCert, 2) as VesselHeightBoardCert
             ,ROUND (v.VesselHeightFull,      2) as VesselHeightFull		
			 --,v.VesselLength
             --,v.VesselLengthCert
             --,v.VesselWidth
             --,v.VesselWidthCert
             --,v.VesselHeightBoard
             --,v.VesselHeightBoardCert
             --,v.VesselHeightFull
             ,v.VesselDraught
             ,v.VesselDeadweight
             ,v.VesselGrossTonnage
             ,v.VesselNetTonnage
			 ,v.VesselEngineTypeCode
             ,et.VesselEngineTypeName
             ,v.VesselEnginePower
			 ,v.VesselPropellerCode
             ,p.VesselPropellerName
             ,v.VesselSpeedFull
             ,v.VesselSpeedIce
             ,v.VesselCertTown
             ,v.VesselCertDate
             ,v.VesselNote
             ,v.AutoMarkList
             ,v.IsDeleted
             ,v.InsertDate
             ,v.UpdateDate
    from nsi.Vessel v
    left join nsi.Country          as c  on c.CountryCode           = v.FlagCode
    left join nsi.Company          as oc on oc.CompanyGuid          = v.OwnerCompanyGuid
    left join nsi.VesselType       as vt on vt.VesselTypeCode       = v.VesselTypeCode
    left join nsi.VesselIceClass   as i  on i.VesselIceClassCode    = v.VesselIceClassCode
    left join nsi.VesselEngineType as et on et.VesselEngineTypeCode = v.VesselEngineTypeCode
    left join nsi.VesselPropeller  as p  on p.VesselPropellerCode   = v.VesselPropellerCode
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Nsi\nsi.vVtsZone.sql
-- generate order 7
go
create view nsi.vVtsZone as 
    select
            vz.VtsZoneCode
          , vz.VtsZoneName
         -- , vz.VtsCode
         -- , v.VtsName
          , vz.BorderingVtsZoneCodeList
          , vz.SortOrder
          , vz.IsDeleted
          , vz.InsertDate
          , vz.UpdateDate
          --, vz.VtsZoneGuid
    from nsi.VtsZone as vz
    --left join nsi.Vts as v on v.VtsCode = vz.VtsCode

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Plan\pln.vPlanTraffic.sql
-- generate order 8
go
create view pln.vPlanTraffic as 
  SELECT 
      FORMAT([TrafficPlanDate], N'HH:mm') as [TrafficPlanDate]
      ,t1.[VtsCode] 
      ,[Region]
      ,[VesselName]
      ,[VesselImo]
      ,[VesselLength]
      ,[VesselType]
      ,[VesselOwner]
      ,[VesselFlag]
      ,[VesselDwt]
      ,[VesselDraft]
      ,[VesselCargo]
      ,[VesselSurfaceDimension]
      ,[OperationDate]
      ,[Operation]
      ,[ComissionWork]
      --,[Route]
      ,(case isnull([Route],'') when '' then [Departure] else substring([Route],1,charindex(' - ',[Route])) end) as [Departure]
      ,(case isnull([Route],'') when '' then [Destination] else substring([Route],charindex(' - ',[Route])+3,len([Route])-charindex(' - ',[Route])) end) as [Destination]
      ,[StayPosition]
      ,[Agent]
      ,[PilotSupply]
      ,[Comment]


  FROM [VTSDB3].[pln].[TrafficPlan] t1
  left join [VTSDB3].[pln].[TrafficVessel] t2 on t1.TrafficPlanGuid=t2.TrafficPlanGuid

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Plan\pln.vPlanTransit.sql
-- generate order 9
go
create view pln.vPlanTransit as 
      SELECT 

      FORMAT([TransitPlanDate], N'HH:mm') as [TransitPlanDate]
      ,(case [Fairway] when 'TSP' then '���' else Fairway end)  as Fairway
      ,[VesselName]
      ,[VesselImo]
      ,[VesselLength]
      ,[VesselType]
      ,[VesselOwner]
      ,[VesselFlag]
      ,[VesselDwt]
      ,[VesselDraft]
      ,[VesselCargo]
      ,[VesselBuildYear]
      ,[VesselSurfaceDimension]
      ,[VesselIceClass]
      ,[OperationDate]
      ,[Departure]
      ,[Destination]
      ,[PilotExemption]
      ,[Agent]
      ,[Supply]
      ,[Comment]

  FROM [VTSDB3].[pln].[TransitPlan] t1
  left join [VTSDB3].[pln].[TransitVessel] t2 on t1.TransitPlanGuid=t2.TransitPlanGuid

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Plan\pln.vPlanVessel.sql
-- generate order 10
go
create view pln.vPlanVessel as
    select distinct [VesselImo]
    from   [pln].[TrafficPlan] p
    left join  [pln].[TrafficVessel] v on p.TrafficPlanGuid=v.TrafficPlanGuid
    where convert(date,[TrafficPlanDate]) = convert(date,'2019-11-28') and [VesselImo] is not null and [VesselImo] <> '���'  --getdate()
    union all 
    select distinct [VesselImo]
    from   [pln].[TransitPlan] p
    left join  [pln].[TransitVessel] v on p.TransitPlanGuid=v.TransitPlanGuid
    where convert(date,[TransitPlanDate]) = convert(date,getdate())  and [VesselImo] is not null and [VesselImo] <> '���'


go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\PassView\00_nav.vPassActive.sql
-- generate order 11
go
create view nav.vPassActive as
    -- МДО, 13.12.2019 представление для подсистемы CollaborationDesk (CoDesk), изменения должны согласовываться с сервером приложения и UI
    select PassGuid, ReceiptGuid, VtsCode, VtsZoneCode, UpdateDate, PassCaravanStatusGuid, 'active' as RecType
    from nav.PassActive
    union
    select PassGuid, null , VtsCode, VtsZoneCode, UpdateDate, null, 'draft' as RecType
    from nav.PassDraft

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\PassView\nav.vActCaravanInfo.sql
-- generate order 12
go
create view nav.vActCaravanInfo as
    -- МДО, 13.12.2019 представление для подсистемы CollaborationDesk (CoDesk), изменения должны согласовываться с сервером приложения и UI
    select 
          act.PassGuid
        , car.CaravanGuid
        , car.CaravanDirect
        , car.CaravanNumInYear
        , car.StartDate
        , car.FinishDate
        , carPass.InsertDate
        , carPass.NumInCaravan
        , carSt.PassCaravanStatusGuid
        , carSt.CaravanStatusCode
        , carSt.DelayReasonCode
        , carSt.Comment
        , carSt.StatusDate
    from nav.vPassActive as act
         join nav.PassCaravan       as carPass on carPass.PassGuid            = act.PassGuid
         join nav.Caravan           as car     on car.CaravanGuid             = carPass.CaravanGuid
    left join nav.PassCaravanStatus as carSt   on carSt.PassCaravanStatusGuid = act.PassCaravanStatusGuid
    left join nsi.CaravanStatus     as a       on a.CaravanStatusCode         = carSt.CaravanStatusCode
    left join nsi.DelayReason       as b       on b.DelayReasonCode           = carSt.DelayReasonCode

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\PassView\nav.vActPass.sql
-- generate order 13
go
create view nav.vActPass as
    -- МДО, 13.12.2019 представление для подсистемы CollaborationDesk (CoDesk), изменения должны согласовываться с сервером приложения и UI
    select
        p.PassGuid
      , p.PassNumber
      , p.VesselGuid
      , p.CapitanGuid
      , cap.CaptainNameShort
      , p.PilotExemption
      , p.VtsZoneCode
      , zn.VtsZoneName
      , p.VtsCode
      , vts.VtsName
      , p.DepartureLocationCode
      , pt1.LocationName as DepartureLocationName
      , p.DestinationLocationCode
      , pt2.LocationName as  DestinationLocationName
      , p.VoyageTypeCode
      , p.PassTypeCode
      , p.PassFairwayCode
      , p.PassDirectionCode
      , p.OperationCode
      , p.VtsServiceCode
      , p.PassAlertCodeList
      , p.PassComment
      , p.EtaDate
      , p.StartDate
      , p.StartAppUserGuid
      , p.StartInitiatorCode
      , p.FinishDate
      , p.FinishAppUserGuid
      , p.FinishInitiatorCode
      , p.AutoMarkList
      , p.IsDeleted
      , p.InsertServer
      , p.InsertDate
      , p.UpdateDate
      , (select top 1 count(*)  from nav.PassCargo where PassGuid = act.PassGuid) as CargoCount
    from nav.vPassActive as act
         join nav.Pass          as p   on act.PassGuid         = p.PassGuid
    left join plt.Captain       as cap  on cap.CaptainGuid      = p.CapitanGuid
    left join nsi.VtsZone       as zn   on zn.VtsZoneCode       = p.VtsZoneCode
    left join nsi.Vts           as vts  on vts.VtsCode          = p.VtsCode
    left join nsi.vLocation     as pt1  on pt1.LocationCode     = p.DepartureLocationCode
    left join nsi.vLocation     as pt2  on pt2.LocationCode     = p.DestinationLocationCode
    left join nsi.VoyageType    as vtp on vtp.VoyageTypeCode    = p.VoyageTypeCode
    left join nsi.PassType      as ptp on ptp.PassTypeCode      = p.PassTypeCode
    left join nsi.PassFairway   as pfr on pfr.PassFairwayCode   = p.PassFairwayCode
    left join nsi.PassDirection as pdr on pdr.PassDirectionCode = p.PassDirectionCode
    left join nsi.Operation     as pop on pop.OperationCode     = p.OperationCode
    left join nsi.VtsService    as vsr on vsr.VtsServiceCode    = p.VtsServiceCode
    left join usr.AppUser       as us1 on us1.AppUserGuid       = p.StartAppUserGuid
    left join usr.AppUser       as us2 on us2.AppUserGuid       = p.FinishAppUserGuid

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\PassView\nav.vActPassVessel.sql
-- generate order 14
go
create view nav.vActPassVessel as
    -- МДО, 13.12.2019 представление для подсистемы CollaborationDesk (CoDesk), изменения должны согласовываться с сервером приложения и UI
    select
        pv.PassGuid
      , pv.VesselGuid
      , pv.OwnerCompanyGuid
      , cp.CompanyName
      , pv.FlagCode
      , f.CountryAlpha2Code
      , f.CountryAlpha3Code
      , f.CountryName
      , f.CountryNameShort
      , pv.VesselTypeCode
      , vt.VesselTypeName
      , pv.VesselName
      , pv.VesselNameEn
      , pv.VesselImo
      , pv.VesselMmsi
      , pv.VesselCallSign
      , pv.VesselIceClassCode
      , pv.VesselBuildYear
      , pv.VesselLength
      , pv.VesselLengthCert
      , pv.VesselWidth
      , pv.VesselWidthCert
      , pv.VesselHeightBoard
      , pv.VesselHeightBoardCert
      , pv.VesselHeightFull
      , pv.VesselDraught
      , pv.VesselDeadweight
      , pv.VesselGrossTonnage
      , pv.VesselNetTonnage
      , pv.VesselEngineTypeCode
      , pv.VesselEnginePower
      , pv.VesselPropellerCode
      , pv.VesselSpeedFull
      , pv.VesselSpeedIce
      , pv.VesselSertTown
      , pv.VesselSertDate
      , pv.VesselRegPort
      , pv.VesselNote
      , pv.IsDeleted
      , pv.InsertDate
      , pv.UpdateDate
      , cast( case when pl.VesselImo is not null then 1 else 0 end as bit) as IsInPlan
    from nav.vPassActive as pa
    join nav.PassVessel as pv on pv.PassGuid = pa.PassGuid
    left join nsi.Company    as cp on cp.CompanyGuid    = pv.OwnerCompanyGuid
    left join nsi.Country    as f  on f.CountryCode     = pv.FlagCode
    left join nsi.VesselType as vt on vt.VesselTypeCode = pv.VesselTypeCode
    left join pln.vPlanVessel as pl on pl.VesselImo = pv.VesselImo

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\PassView\nav.vActReceipt.sql
-- generate order 15
go
create view nav.vActReceipt as 
    -- МДО, 13.12.2019 представление для подсистемы CollaborationDesk (CoDesk), изменения должны согласовываться с сервером приложения и UI
    select 
          r.ReceiptGuid         
        , r.PassGuid            
        , r.ReceiptNumber       
        , r.ReceiptTypeCode  
        , rt.ReceiptTypeName
        , r.StartPositionCode   
        , p1.PositionName      as StartPositionName
        , p1.PositionNameShort as StartPositionNameShort
        , r.FinishPositionCode  
        , p2.PositionName       as FinishPositionName
        , p2.PositionNameShort  as FinishPositionNameShort
        , r.DelayReasonCodeList 
        , r.StartLat            
        , r.StartLon            
        , r.FinishLat           
        , r.FinishLon           
        , r.StartDate           
        , r.StartAppUserGuid    
        , us1.AppUserName as StartAppUserName
        , r.StartInitiatorCode  
        , r.FinishDate          
        , r.FinishAppUserGuid   
        , us2.AppUserName as FinishAppUserName
        , r.FinishInitiatorCode 
        , r.InsertDate          
        , r.UpdateDate          
    from nav.vPassActive as act
          join nav.Receipt as r   on r.ReceiptGuid   = act.ReceiptGuid
    left join nsi.ReceiptType as rt  on rt.ReceiptTypeCode = r.ReceiptTypeCode
    left join nsi.Position as p1  on p1.PositionCode = r.StartPositionCode
    left join nsi.Position as p2  on p2.PositionCode = r.FinishPositionCode
    left join usr.AppUser  as us1 on us1.AppUserGuid = r.StartAppUserGuid
    left join usr.AppUser  as us2 on us2.AppUserGuid = r.FinishAppUserGuid

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\PassView\nav.vPass.sql
-- generate order 16
go
create view nav.vPass as
    -- МДО, 13.12.2019 представление для подсистемы CollaborationDesk (CoDesk), изменения должны согласовываться с сервером приложения и UI
    select
        p.PassGuid
      , p.PassNumber
      , p.VesselGuid
      , p.CapitanGuid
      , cap.CaptainNameShort
      , p.PilotExemption
      , p.VtsZoneCode
      , zn.VtsZoneName
      , p.VtsCode
      , vts.VtsName
      , p.DepartureLocationCode
      , pt1.LocationName as DepartureLocationName
      , p.DestinationLocationCode
      , pt2.LocationName as  DestinationLocationName
      , p.VoyageTypeCode
      , p.PassTypeCode
      , p.PassFairwayCode
      , p.PassDirectionCode
      , p.OperationCode
      , p.VtsServiceCode
      , p.PassAlertCodeList
      , p.PassComment
      , p.StartDate
      , p.StartAppUserGuid
      , p.StartInitiatorCode
      , p.FinishDate
      , p.FinishAppUserGuid
      , p.FinishInitiatorCode
      , p.AutoMarkList
      , p.IsDeleted
      , p.InsertServer
      , p.InsertDate
      , p.UpdateDate
    from nav.Pass          as p   
    left join plt.Captain       as cap  on cap.CaptainGuid      = p.CapitanGuid
    left join nsi.VtsZone       as zn   on zn.VtsZoneCode       = p.VtsZoneCode
    left join nsi.Vts           as vts  on vts.VtsCode          = p.VtsCode
    left join nsi.vLocation     as pt1  on pt1.LocationCode     = p.DepartureLocationCode
    left join nsi.vLocation     as pt2  on pt2.LocationCode     = p.DestinationLocationCode
    left join nsi.VoyageType    as vtp on vtp.VoyageTypeCode    = p.VoyageTypeCode
    left join nsi.PassType      as ptp on ptp.PassTypeCode      = p.PassTypeCode
    left join nsi.PassFairway   as pfr on pfr.PassFairwayCode   = p.PassFairwayCode
    left join nsi.PassDirection as pdr on pdr.PassDirectionCode = p.PassDirectionCode
    left join nsi.Operation     as pop on pop.OperationCode     = p.OperationCode
    left join nsi.VtsService    as vsr on vsr.VtsServiceCode    = p.VtsServiceCode
    left join usr.AppUser       as us1 on us1.AppUserGuid       = p.StartAppUserGuid
    left join usr.AppUser       as us2 on us2.AppUserGuid       = p.FinishAppUserGuid

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\PassView\nav.vPassEvent.sql
-- generate order 17
go
create view nav.vPassEvent as
    -- МДО, 13.12.2019 представление для подсистемы CollaborationDesk (CoDesk), изменения должны согласовываться с сервером приложения и UI
    select
            pe.PassEventGuid
          , pe.PassEventTypeCode
          , pet.PassEventTypeName
          , pet.PassEventTypeNameShort
          , pe.PassGuid
          , pe.PositionCode
          , pos.PositionName
          , pos.PositionNameShort
          , pe.PositionCrossDirection
          , pe.PassEventLat
          , pe.PassEventLon
          , pe.PassEventDate
          , pe.PassEventMsg
          , pe.PassEventSource
          , pe.InsertDate
          , pe.UpdateDate
    from nav.PassEvent as pe
    left join nsi.PassEventType as pet on pet.PassEventTypeCode = pe.PassEventTypeCode
    left join nsi.Position as pos on pos.PositionCode = pe.PositionCode

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\PassView\nav.vReceipt.sql
-- generate order 18
go
create view nav.vReceipt as 
    -- МДО, 13.12.2019 представление для подсистемы CollaborationDesk (CoDesk), изменения должны согласовываться с сервером приложения и UI
    select -- top 100
          r.ReceiptGuid         
        , r.PassGuid            
        , r.ReceiptNumber       
        , r.ReceiptTypeCode     
        , r.StartPositionCode   
        , p1.PositionName      as StartPositionName
        , p1.PositionNameShort as StartPositionNameShort
        , r.FinishPositionCode  
        , p2.PositionName       as FinishPositionName
        , p2.PositionNameShort  as FinishPositionNameShort
        , r.DelayReasonCodeList 
        , r.StartLat            
        , r.StartLon            
        , r.FinishLat           
        , r.FinishLon           
        , r.StartDate           
        , r.StartAppUserGuid    
        , us1.AppUserName as StartAppUserName
        , r.StartInitiatorCode  
        , r.FinishDate          
        , r.FinishAppUserGuid   
        , us2.AppUserName as FinishAppUserName
        , r.FinishInitiatorCode 
        , r.InsertDate          
        , r.UpdateDate          
    from  nav.Receipt as r  
    left join nsi.ReceiptType as rt  on rt.ReceiptTypeCode = r.ReceiptTypeCode
    left join nsi.Position as p1  on p1.PositionCode = r.StartPositionCode
    left join nsi.Position as p2  on p2.PositionCode = r.FinishPositionCode
    left join usr.AppUser  as us1 on us1.AppUserGuid = r.StartAppUserGuid
    left join usr.AppUser  as us2 on us2.AppUserGuid = r.FinishAppUserGuid

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Pilot\plt.vPilot.sql
-- generate order 19
go
create view plt.vPilot as
       select p.PilotGuid
             ,p.VtsCodeList
             ,p.PilotCompanyGuid
             ,pc.CompanyName as PilotCompanyName
             ,p.PilotTypeCode
             ,pt.PilotTypeName
             ,p.PilotName
             ,p.PilotNameShort
             ,p.PilotTableNumber
             ,p.PilotBrigadeCode
             ,pb.PilotBrigadeName
             ,p.NumInPilotBrigade
             ,p.TownCode
             ,t.TownName
             ,p.Address
             ,p.Phone
             ,p.CallSign
             ,p.IsDeleted
             ,p.InsertDate
             ,p.UpdateDate
             ,p.RsbmGuid
             ,p.PlanId			 
         FROM VTSDB3.plt.Pilot p
    left join nsi.Company      as pc on pc.CompanyGuid      = p.PilotCompanyGuid
    left join plt.PilotType    as pt on pt.PilotTypeCode    = p.PilotTypeCode
    left join plt.PilotBrigade as pb on pb.PilotBrigadeCode = p.PilotBrigadeCode
    left join nsi.Town         as t  on t.TownCode          = p.TownCode
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Request\rqt.vFax.sql
-- generate order 20
go
create view rqt.vFax as
select f.FaxGuid
      ,f.FaxTypeCode
	  ,ft.FaxTypeName
      ,f.FaxRemoteTsi
      ,f.FaxRemoteNumber
      ,f.FaxFilename
      ,f.FaxPageOrientation
      ,f.FaxPageWidth
      ,f.FaxPageHeight
      ,cast(f.FaxPageWidth as nvarchar(10)) + ' �� � ' + cast(f.FaxPageHeight as nvarchar(10)) + ' ��' as FaxPageSize
      ,f.FaxResolutionFine
      ,f.PassRequestGuid
      ,f.VesselGuid
      ,f.AgentCompanyGuid
      ,f.RequestRejected
      ,f.RequestRejectReasonCode
      ,f.RequestComment
      ,f.InsertDate
      ,f.IssDate
      ,f.IssUserGuid
  FROM VTSDB3.rqt.Fax f
  left join rqt.FaxType ft on ft.FaxTypeCode = f.FaxTypeCode
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Request\rqt.vPassRequest.sql
-- generate order 21
go
create view rqt.vPassRequest as
select r.PassRequestGuid
      ,r.PassGuid
      ,r.VesselGuid
      ,r.VesselName
      ,r.VesselImo
      ,r.VesselTypeCode
      ,vt.VesselTypeName
      ,r.FlagCode
      ,c.CountryName        as FlagName
      ,r.VesselLength
      ,r.VesselWidth
      ,r.VesselHeightBoard
	  ,r.VesselLengthCert   
      ,r.VesselWidthCert    
      ,r.VesselHeightBoardCert
      ,r.VesselHeightFull
      ,r.VesselCallSign
      ,r.OwnerCompanyGuid
      ,oc.CompanyName       as OwnerCompanyName
      ,occ.CountryName      as OwnerCompanyCountryName
      ,r.VesselGrossTonnage
      ,r.VesselNetTonnage
      ,r.VesselDeadweight
      ,r.EtaDate
      ,r.AgentCompanyGuid
      ,ac.CompanyName       as AgentCompanyName
      ,r.DepartureLocationCode
      ,dpl.LocationName     as DepartureLocationName
      ,r.StartPositionCode
      ,dpp.PositionName     as StartPositionName
      ,r.DestinationLocationCode
      ,dsl.LocationName     as DestinationLocationName
      ,r.FinishPositionCode
      ,dsp.PositionName     as FinishPositionName
      ,r.VesselDraft
      ,r.VesselDraftHead
      ,r.VesselAirDraft
      ,r.CargoTypeCode
      ,ct.CargoTypeName
      ,r.CargoValue
      ,r.CargoDangerous
      ,r.CargoDeck
      ,r.PassengerValue
      ,r.PilotCompanyGuid
      ,r.VtsServiceCode
      ,r.PilotStartPositionCode
      ,psp.PositionName     as PilotStartPositionName
      ,r.PilotFinishPositionCode
	  ,pfp.PositionName     as PilotFinishPositionName
      ,r.NeedVtsService
      ,r.VtsCode
      ,vts.VtsName
      --,PassDirectionCode
      --,PassDirectionName
      --,PassTypeCode
      ,r.OperationCode
      ,r.PassFairwayCode
      ,r.VoyageTypeCode
      ,vyt.VoyageTypeName
      ,r.RegularTransport
      ,r.PassRequestConfirmed
      ,r.PassRequestIceChiefConfirmed
      ,r.InsertUserGuid
      ,r.UpdateUserGuid
      ,r.InsertDate
      ,r.UpdateDate
  FROM VTSDB3.rqt.PassRequest r
  left join nsi.VesselType vt  on vt.VesselTypeCode  = r.VesselTypeCode
  left join nsi.VoyageType vyt on vyt.VoyageTypeCode = r.VoyageTypeCode
  left join nsi.Country    c   on c.CountryCode      = r.FlagCode
  left join nsi.Company    oc  on oc.CompanyGuid     = r.OwnerCompanyGuid
  left join nsi.Country    occ on occ.CountryCode    = oc.CountryCode
  left join nsi.Company    ac  on ac.CompanyGuid     = r.AgentCompanyGuid
  left join nsi.CargoType  ct  on ct.CargoTypeCode   = r.CargoTypeCode
  left join nsi.Vts        vts on vts.VtsCode        = r.VtsCode						   						    
  left join nsi.Location   dpl on dpl.LocationCode   = r.DepartureLocationCode
  left join nsi.Location   dsl on dsl.LocationCode   = r.DestinationLocationCode
  left join nsi.Position   dpp on dpp.PositionCode   = r.StartPositionCode
  left join nsi.Position   dsp on dsp.PositionCode   = r.FinishPositionCode
  left join nsi.Position   psp on psp.PositionCode   = r.PilotStartPositionCode
  left join nsi.Position   pfp on pfp.PositionCode   = r.PilotFinishPositionCode
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Request\rqt.vWebRequest.sql
-- generate order 22
go
CREATE view rqt.vWebRequest as
select w.WebRequestGuid
      ,w.PassRequestGuid
      ,w.EtaDate
      ,w.DepartureLocationCode	  
      ,dpl.LocationName as DepartureLocationName
      ,w.DestinationLocationCode
      ,dsl.LocationName as DestinationLocationName
      ,w.StartPositionCode
      ,w.FinishPositionCode
      ,w.PassPilot
      ,w.PilotDepartureLocationCode
      ,w.PilotDestinationLocationCode
      ,w.PilotStartPositionCode
      ,w.PilotFinishPositionCode
      ,w.PassFairwayCode
      ,w.VoyageTypeCode
      ,w.OperationCode
      ,op.OperationName
      ,w.CargoTypeCode
      ,w.CargoValue
      ,w.CargoDangerous
      ,w.CargoDeck
      ,w.PassengerValue
      ,w.VesselName
      ,w.VesselTypeCode
      ,vt.VesselTypeName
      ,w.FlagCode
      ,vf.CountryName as FlagName
      ,w.OwnerName    as OwnerCompanyName
      ,w.OwnerCountryCode
	  ,oc.CountryName as OwnerCountryName
      ,w.VesselCallSign
      ,w.VesselImo
      ,w.VesselLengthCert
      ,w.VesselWidthCert
      ,w.VesselHeightBoardCert
      ,w.VesselGrossTonnage
      ,w.VesselNetTonnage
      ,w.VesselDeadweight
      ,w.VesselIceClassCode
      ,w.VesselEnginePower
      ,w.VesselPropellerCode
      ,w.VesselSpeedFull
      ,w.VesselDraft
      ,w.VesselHeightFull
      ,w.VesselAirDraft
      ,w.VesselDangerClassCode
      ,w.PassIce
      ,w.Provision
      ,w.AgentComment
      ,w.AgentCompanyGuid
      ,ag.CompanyName as AgentCompanyName
      ,w.AgentNamePosition
      ,w.RegularTransport
      ,w.FairwayBit
      ,w.PilotCompanyGuid
      ,w.NeedVtsService
      ,w.PaymentDocument
      ,w.PaymentDate
      ,w.PaymentAmount
      ,w.PaymentCurrencyCode
      ,w.RequestRejectReason
      ,w.IsRejected
      ,w.IsConfirmed
      ,w.IsCancelled
      ,w.IsDeleted
      ,w.InsertDate
      ,w.UpdateDate
      ,w.IssDate
      ,w.IssUserGuid
      ,w.IssCancelledDate
      ,w.IssCancelledUserGuid
      ,w.AgentCancelledDate
      ,w.VtsServiceOrg
      ,w.PlanId
      ,w.PlanRemoteIp
      ,w.PlanAgentStaffId
      ,w.PlanAgentCancelledStaffId
  FROM VTSDB3.rqt.WebRequest w
  left join nsi.Location   dpl on dpl.LocationCode  = w.DepartureLocationCode
  left join nsi.Location   dsl on dsl.LocationCode  = w.DestinationLocationCode
  left join nsi.VesselType vt  on vt.VesselTypeCode = w.VesselTypeCode
  left join nsi.Operation  op  on op.OperationCode  = w.OperationCode
  left join nsi.Country    vf  on vf.CountryCode    = w.FlagCode
  left join nsi.Country    oc on oc.CountryCode     = w.OwnerCountryCode
  left join nsi.Company    ag  on ag.CompanyGuid    = w.AgentCompanyGuid
  

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\NavSign\sgn.vNavigationSign.sql
-- generate order 23
go
create view sgn.vNavigationSign as 
  SELECT 
       [NavigationSignName]
      ,[NavigationSignNote]
      , FORMAT([InsertDate], 'dd/MM/yyyy HH:mm') as [InsertDate]
  FROM [VTSDB3].[sgn].[NavigationSign]


go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Scan\scn.vScanZonePass.sql
-- generate order 24
go
create view scn.vScanZonePass as
SELECT t.ScanZonePassGuid, 
	t.VesselGUID, 
	t.ScanZoneCode, 
	t.StartDate, 
	t.FinishDate, 
	t.UpdateDate, 
	t.InsertDate, 
	t.IsDeleted, 
	v.VesselName, 
    CASE WHEN v.VesselNameEn IS NOT NULL THEN v.VesselNameEn ELSE v.VesselName END AS VesselNameEn, 
	v.VesselImo, 
	v.VesselMmsi, 
	v.VesselDraught, 
    v.VesselLength, 
	v.VesselHeightBoard, 
	v.VesselWidth, 
	ltrim(rtrim(isnull(cast(cast(v.VesselLength AS numeric(10, 2)) AS nvarchar(10)), '') 
		+ CASE WHEN v.VesselWidth IS NOT NULL 
               THEN 'x' ELSE '' END 
		+ isnull(cast(cast(v.VesselWidth AS numeric(10, 2)) AS nvarchar(10)), '') 
		+ CASE WHEN v.VesselHeightBoard IS NOT NULL THEN 'x' ELSE '' END 
		+ isnull(cast(cast(v.VesselHeightBoard AS numeric(10, 2)) AS nvarchar(10)), ''))) AS VesselSize, 
	t.Comment, 
	vt.VesselTypeName, 
	f.CountryCode, 
    f.CountryName, 
	row_number() OVER (ORDER BY t.StartDate DESC) AS RowNum
FROM  scn.ScanZonePass AS t 
JOIN nsi.Vessel AS v ON v.VesselGUID = t.VesselGUID 
LEFT JOIN nsi.Country AS f ON f.CountryCode = v.FlagCode 
LEFT JOIN nsi.VesselType AS vt ON v.VesselTypeCode = vt.VesselTypeCode
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Snr\snr.vAis.sql
-- generate order 25
go
create view snr.vAis as 
 SELECT 
       [AisStatus]
      ,FORMAT([AisDate], 'dd/MM/yyyy HH:mm:ss') as [AisDate]
      --,[AisNumber]
      ,[AisAddressFrom]
      ,[AisAddressTo]
      ,[AisMessage]
  FROM [VTSDB3].[snr].[Ais]

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Snr\snr.vNavtex.sql
-- generate order 26
go
create view snr.vNavtex as 
 SELECT 
  
       FORMAT([InsertDate], 'dd/MM/yyyy HH:mm:ss') as [InsertDate]
      ,[NavtexMessageType]
      ,[NavtexMessageText]
  FROM [VTSDB3].[snr].[Navtex]

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Snr\snr.vWeather.sql
-- generate order 27
go
create view snr.vWeather as 

  SELECT TOP (100) 
       FORMAT([RecordTime], 'dd/MM/yyyy HH:mm:ss') as [RecordTime]
      ,round([WindSpeed],2) as [WindSpeed]
      ,round([WindDirection],2) as [WindDirection]
      ,round([AirTemperature],2) as [AirTemperature]
      ,round([AirPressure],2) as [AirPressure]
      ,round([RelativeHumidity],2) as [RelativeHumidity]
  FROM [VTSDB].[dbo].[WeatherLog] order by [InsertUTCDate] desc


go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\User\usr.vAppUser.sql
-- generate order 28
go
create view usr.vAppUser as
     select
   u.AppUserGuid,
   u.AppUserGroupCode,
   g.AppUserGroupName,
   u.AppUserLogin,
   u.AppUserPassMd5,
   u.AppUserName,
   u.AppRoleCodeList,
   u.VtsCodeList,
   u.VtsZoneCodeList,
   u.IsWatchable,
   u.IsDeleted,
   u.InsertDate,
   u.UpdateDate
from
   usr.AppUser as u
    left join usr.AppUserGroup as g on g.AppUserGroupCode = u.AppUserGroupCode

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\User\usr.vWatchAll.sql
-- generate order 29
go
create view usr.vWatchAll
as
    select w.WatchGuid
          ,w.VtsCode
          ,w.VtsZoneCode
          ,w.AppUserGuid
          ,u.AppUserLogin
          ,u.AppUserName
          ,w.VtsClientCode
          ,w.VtsClientOsId
          ,w.VtsClientIp
          ,w.VtsClientNetbiosName
          , cast(1 as bit) IsActive
          ,w.InsertDate
      from usr.WatchActive as w
      join usr.AppUser as u on u.AppUserGuid = w.AppUserGuid
    union all
    select w.WatchGuid
          ,w.VtsCode
          ,w.VtsZoneCode
          ,w.AppUserGuid
          ,u.AppUserLogin
          ,u.AppUserName
          ,w.VtsClientCode
          ,w.VtsClientOsId
          ,w.VtsClientIp
          ,w.VtsClientNetbiosName
          , cast(0 as bit) IsActive
          ,w.InsertDate
      from usr.Watch as w
      join usr.AppUser as u on u.AppUserGuid = w.AppUserGuid

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Contact\cnt.vPassContact.sql
-- generate order 30
go
create view cnt.vPassContact as
-- ������������ ��� ���������� ������
    select
        p.PassGuid
      , p.PassNumber
      , p.VesselGuid
      , p.CapitanGuid
      , cap.CaptainNameShort
      , p.PilotExemption
      , p.VtsZoneCode
      , zn.VtsZoneName
      , p.VtsCode
      , vts.VtsName
      , p.DepartureLocationCode
      , pt1.LocationName as DepartureLocationName
      , p.DestinationLocationCode
      , pt2.LocationName as  DestinationLocationName
      , p.VoyageTypeCode
      , p.PassTypeCode
      , p.PassFairwayCode
      , p.PassDirectionCode
      , p.OperationCode
      , p.VtsServiceCode
      , p.PassAlertCodeList
      , p.PassComment
      , p.EtaDate
      , p.StartDate
      , p.StartAppUserGuid
      , p.StartInitiatorCode
      , p.FinishDate
      , p.FinishAppUserGuid
      , p.FinishInitiatorCode
      , p.AutoMarkList
      , p.IsDeleted
      , p.InsertServer
      , p.InsertDate
      , p.UpdateDate


      , pv.OwnerCompanyGuid
      , cp.CompanyName
      , pv.FlagCode
      , f.CountryAlpha2Code
      , f.CountryAlpha3Code
      , f.CountryName
      , f.CountryNameShort
      , pv.VesselTypeCode
      , vt.VesselTypeName
      , pv.VesselName
      , pv.VesselNameEn
      , pv.VesselImo
      , pv.VesselMmsi
      , pv.VesselCallSign
      , pv.VesselIceClassCode
      , pv.VesselBuildYear
      , pv.VesselLength
      , pv.VesselLengthCert
      , pv.VesselWidth
      , pv.VesselWidthCert
      , pv.VesselHeightBoard
      , pv.VesselHeightBoardCert
      , pv.VesselHeightFull
      , pv.VesselDraught
      , pv.VesselDeadweight
      , pv.VesselGrossTonnage
      , pv.VesselNetTonnage
      , pv.VesselEngineTypeCode
      , pv.VesselEnginePower
      , pv.VesselPropellerCode
      , pv.VesselSpeedFull
      , pv.VesselSpeedIce
      , pv.VesselSertTown
      , pv.VesselSertDate
      , pv.VesselRegPort
      , pv.VesselNote

      , (select top 1 count(*)  from nav.PassCargo where PassGuid = act.PassGuid) as CargoCount
    from nav.vPassActive as act
         join nav.Pass          as p   on act.PassGuid          = p.PassGuid
         join nav.PassVessel    as pv  on act.PassGuid          = pv.PassGuid
          left join nsi.Company    as cp on cp.CompanyGuid    = pv.OwnerCompanyGuid
          left join nsi.Country    as f  on f.CountryCode     = pv.FlagCode
          left join nsi.VesselType as vt on vt.VesselTypeCode = pv.VesselTypeCode


    left join plt.Captain       as cap  on cap.CaptainGuid      = p.CapitanGuid
    left join nsi.VtsZone       as zn   on zn.VtsZoneCode       = p.VtsZoneCode
    left join nsi.Vts           as vts  on vts.VtsCode          = p.VtsCode
    left join nsi.vLocation     as pt1  on pt1.LocationCode     = p.DepartureLocationCode
    left join nsi.vLocation     as pt2  on pt2.LocationCode     = p.DestinationLocationCode
    left join nsi.VoyageType    as vtp on vtp.VoyageTypeCode    = p.VoyageTypeCode
    left join nsi.PassType      as ptp on ptp.PassTypeCode      = p.PassTypeCode
    left join nsi.PassFairway   as pfr on pfr.PassFairwayCode   = p.PassFairwayCode
    left join nsi.PassDirection as pdr on pdr.PassDirectionCode = p.PassDirectionCode
    left join nsi.Operation     as pop on pop.OperationCode     = p.OperationCode
    left join nsi.VtsService    as vsr on vsr.VtsServiceCode    = p.VtsServiceCode
    left join usr.AppUser       as us1 on us1.AppUserGuid       = p.StartAppUserGuid
    left join usr.AppUser       as us2 on us2.AppUserGuid       = p.FinishAppUserGuid

go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Views\nav.vPassRecStartFinish.sql
-- generate order 31
go
create view nav.vPassRecStartFinish
as
    -- �������� �������� ������������ � �� ������� ���������
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


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Func\scalar_atm.fnGetDirectionByInPos.sql
-- generate order 32
go
create function nav.fnGetDirectionByInPos(@InPositionCode varchar(10) ,@crossType nvarchar( 5) ='out')
returns  nvarchar(10)
as
begin
    /*
	   ���: ����������� ����������� "C ������"/"� ���" �� ������� ����� ������ �������� ����
	   ��������: @crossType nvarchar( 5) ='out' ������� �����. �.�. ����
	*/

	/*
	  ������� ��������� �������� ��������� �������

	  ������ � ������ ('FROMNORD') ����:

      '080F4A98-1536-4264-BBB2-0BDD3038A8F1'  VARZOVSKIJ  ���������� ����	���������� ����  
      '0A2CD88C-D98A-454F-B318-AB225EC9A27B'  TEMRJUKMOR  ������ ���� ����	������ ���� ���� 

      ������ � ��� ('FROMSOUTH')����:


      'B8CAF5B3-383F-4B50-A009-80DB0D23C50C' TAMANZAPAD   ������ ����� ����	������ ����� ���� 
      'D39FAD11-6042-46BC-A621-294BDE53C2C6' TAMANJUGXX   ������ �� ����	������ �� ����  
      '263C0C17-9F48-4BE8-95E0-718B30AC663E' UCHASTOK3M   ������� � 3 ���� ����	������� � 3 ���� ���� 
      'ECCE9D06-955B-4EFB-9AF8-ED75C98446EB' TAKILXXXXX   ������ ����	������ ���� 
      '11448FD4-B218-4548-B1B0-6995C1D59E7B' RPRZAPADXX   ��� ����� ����	��� ����� ���� 
    */
	

    Declare @actPassDirectionCode nvarchar(10);
    Declare @NothPositions table (PositionCode varchar(10))
    Insert into @NothPositions (PositionCode)
    Select PositionCode from vtsdb3.nsi.Position
    where PositionCode in ('VARZOVSKIJ','TEMRJUKMOR');

    Declare @SouthPositions table (PositionCode varchar(10))
    Insert into @SouthPositions (PositionCode)
    Select PositionCode from vtsdb3.nsi.Position
    where PositionCode in ('TAMANZAPAD','TAMANJUGXX','UCHASTOK3M','TAKILXXXXX','RPRZAPADXX');

    if (@crossType= 'in') and Exists(Select 1 from @NothPositions where PositionCode=@InPositionCode) 
    begin
        set @actPassDirectionCode = 'FROMNORD';
    end
    else if (@crossType= 'in') and Exists(Select 1 from @NothPositions where PositionCode=@InPositionCode) 
    begin
        set @actPassDirectionCode = 'FROMSOUTH';
    end
    else
       set @actPassDirectionCode = null;

    return @actPassDirectionCode;
end
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Func\scalar_nav.fnGetDirectionByInPosTranz.sql
-- generate order 33
go
create function nav.fnGetDirectionByInPosTranz(@InPositionGuid uniqueidentifier)
returns  nvarchar(10)
as
begin
    /*
	   ���: ����������� ����������� "C ������"/"� ���" �� ������� ����� ������ �������� ����
	*/

	/*
	  ������� ��������� �������� ��������� �������

	  ������ � ������ ('FROMNORD') ����:

      '080F4A98-1536-4264-BBB2-0BDD3038A8F1'  VARZOVSKIJ  ���������� ����	���������� ����  
      '0A2CD88C-D98A-454F-B318-AB225EC9A27B'  TEMRJUKMOR  ������ ���� ����	������ ���� ���� 

      ������ � ��� ('FROMSOUTH')����:


      'B8CAF5B3-383F-4B50-A009-80DB0D23C50C' TAMANZAPAD   ������ ����� ����	������ ����� ���� 
      'D39FAD11-6042-46BC-A621-294BDE53C2C6' TAMANJUGXX   ������ �� ����	������ �� ����  
      '263C0C17-9F48-4BE8-95E0-718B30AC663E' UCHASTOK3M   ������� � 3 ���� ����	������� � 3 ���� ���� 
      'ECCE9D06-955B-4EFB-9AF8-ED75C98446EB' TAKILXXXXX   ������ ����	������ ���� 
      '11448FD4-B218-4548-B1B0-6995C1D59E7B' RPRZAPADXX   ��� ����� ����	��� ����� ���� 
    */
	

    Declare @actPassDirectionCode nvarchar(10);
    Declare @NothPositions table (PositionGuid uniqueidentifier)

	Insert into @NothPositions (PositionGuid)
    Select Uid from vtsdb.dbo.Positions
    where Uid in ('080F4A98-1536-4264-BBB2-0BDD3038A8F1','0A2CD88C-D98A-454F-B318-AB225EC9A27B');


	Declare @SouthPositions table (PositionGuid uniqueidentifier)
    Insert into @SouthPositions (PositionGuid)
    Select Uid from vtsdb.dbo.Positions
    where Uid in ('B8CAF5B3-383F-4B50-A009-80DB0D23C50C','D39FAD11-6042-46BC-A621-294BDE53C2C6','263C0C17-9F48-4BE8-95E0-718B30AC663E','ECCE9D06-955B-4EFB-9AF8-ED75C98446EB','11448FD4-B218-4548-B1B0-6995C1D59E7B')
    order by Name;
    
    if Exists(Select 1 from @NothPositions where PositionGuid=@InPositionGuid) 
    begin
        set @actPassDirectionCode = 'FROMNORD';
    end
    else if Exists(Select 1 from @NothPositions where PositionGuid=@InPositionGuid) 
    begin
        set @actPassDirectionCode = 'FROMSOUTH';
    end
    else
       set @actPassDirectionCode = null;

    return @actPassDirectionCode;
end
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Func\scalar_nav.fnGetPassTypeCode.sql
-- generate order 34
go
create function nav.fnGetPassTypeCode(@PassGuid uniqueidentifier)
   returns varchar(3)
as
begin
     /*
    ���: ��������� ���� ����������� �� ��������� � �������� �������� � ���������� ���������.
	PS. ���������� ������������� [nav].[vPassRecStartFinish]
  */
declare @PassTypeCode varchar(3);

select @PassTypeCode= 
case when StartPositionTypeCode='INOUT'  and FinishPositionTypeCode='INOUT' then 'TRN'
     when StartPositionTypeCode='INOUT'  and (FinishPositionTypeCode='MOORING' or FinishPositionTypeCode='ANCHOR')then 'IN'
	 when (StartPositionTypeCode='MOORING' or StartPositionTypeCode='ANCHOR') and FinishPositionTypeCode='INOUT' then 'OUT'
     when (StartPositionTypeCode='MOORING' or StartPositionTypeCode='ANCHOR') and (FinishPositionTypeCode='MOORING' or FinishPositionTypeCode='ANCHOR') and PassRecCnt>1 then 'RLC'
	 when (StartPositionTypeCode='MOORING' or StartPositionTypeCode='ANCHOR') and (FinishPositionTypeCode='MOORING' or FinishPositionTypeCode='ANCHOR') and PassRecCnt=1 then 'STP'
	 else 'UND'
	 end
	 from nav.vPassRecStartFinish 
	 where PassGuid=@PassGuid;
	 return @PassTypeCode;
end


go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Func\scalar_nav.fnPassTypeCode.sql
-- generate order 35
go
create function nav.fnPassTypeCode (@StartPositionTypeCode varchar(10) , @FinishPositionTypeCode varchar(10), @RecCount int)
   returns varchar(3)
as
begin
  /*
    ���: ��������� ���� ����������� �� ��������� � �������� �������� � ���������� ���������.
	PS. �������� ����� ������������ ��� ������� �� ������������� [nav].[vPassRecStartFinish]
  */
declare @PassTypeCode varchar(3);


select @PassTypeCode=
case when @StartPositionTypeCode='INOUT'  and @FinishPositionTypeCode='INOUT' then 'TRN'
     when @StartPositionTypeCode='INOUT'  and (@FinishPositionTypeCode='MOORING' or @FinishPositionTypeCode='ANCHOR')then 'IN'
	 when (@StartPositionTypeCode='MOORING' or @StartPositionTypeCode='ANCHOR') and @FinishPositionTypeCode='INOUT' then 'OUT'
     when (@StartPositionTypeCode='MOORING' or @StartPositionTypeCode='ANCHOR') and (@FinishPositionTypeCode='MOORING' or @FinishPositionTypeCode='ANCHOR') and @RecCount>1 then 'RLC'
	 when (@StartPositionTypeCode='MOORING' or @StartPositionTypeCode='ANCHOR') and (@FinishPositionTypeCode='MOORING' or @FinishPositionTypeCode='ANCHOR') and @RecCount=1 then 'STP'
	 else 'UND'
	 end;
	 return @PassTypeCode;
end


go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Func\table_nav.fnGetPassRecStartFinish.sql
-- generate order 36
go
create function nav.fnGetPassRecStartFinish 
    (@PassGuid uniqueidentifier)
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
     ���: ��������� ������ �� ������ � ��������� �����������
   */

    --Declare @PassGuid uniqueidentifier = 'F6CF49DF-C7E5-4436-8B21-0000C02FCBE9'�

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
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Func\table_nav.fnGetPrevPass.sql
-- generate order 37
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

    /* ���: ��������� ����������� �� StartDate ��� ���������� ����������� ��� ��������� ���� (���� ���� �� ������� �� �� ���� �����) */

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
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Func\table_nav.fnGetPrevPassRec.sql
-- generate order 38
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

    /* ���: ��������� ����������� �� StartDate ��� ���������� ����������� � ��� ������� ���������*/

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
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Func\table_nav.fnGetVesselActivePass.sql
-- generate order 39
go
create function nav.fnGetVesselActivePass (@VesselGuid uniqueidentifier, @VtsZoneCode varchar(2) = null)
returns 
@Result table (PassGuid uniqueidentifier 
               ,PassNumber nvarchar(10) 
               ,VesselGuid uniqueidentifier 
               ,PassStartdate datetime
               ,PassFinishDate datetime 
               ,VtsCode            nvarchar( 2)
               ,VtsZoneCode        nvarchar( 2)
               ,DepartureLocationCode varchar(5)
               ,DestinationLocationCode varchar(5)
               ,PassDirectionCode  nvarchar(10)
               ,PassTypeCode varchar(3)
               ,RecStartDate datetime
               ,RecFinishDate datetime
               ,RecsiptGuid uniqueidentifier
               ,ReceiptTypeCode    nvarchar(5)
               ,StartPositionCode  nvarchar(10)
               ,FinishPositionCode nvarchar(10)
               ,EtaDate datetime
               )
as
begin

   /* 
     ���: ��������� ���������� ��������� (��������) ����������� � ��������� �� ����� ��� ��������� ���� (���� ���� �� ������� �� �� ���� �����)
     PS. ���� � PassActive �������� ��������� �����, �� �������� ��������� �� StartDate �����������
   */

    Insert into @Result (PassGuid 
               ,PassNumber
               ,VesselGuid
               ,PassStartdate
               ,PassFinishDate
               ,VtsCode
               ,VtsZoneCode
               ,DepartureLocationCode
               ,DestinationLocationCode
               ,PassDirectionCode
               ,PassTypeCode
               ,RecsiptGuid
               ,RecStartDate
               ,RecFinishDate
               ,ReceiptTypeCode
               ,StartPositionCode
               ,FinishPositionCode
               ,EtaDate)
    Select top 1
               p.PassGuid
              ,p.PassNumber
              ,p.VesselGuid
              ,p.StartDate
              ,p.FinishDate
              ,p.VtsCode
              ,p.VtsZoneCode
              ,p.DepartureLocationCode
              ,p.DestinationLocationCode
              ,p.PassDirectionCode
              ,P.PassTypeCode
              ,pa.ReceiptGuid
              ,r.StartDate
              ,r.FinishDate
              ,r.ReceiptTypeCode
              ,r.StartPositionCode
              ,r.FinishPositionCode
              ,p.EtaDate
    from nav.PassActive as pa
    join      nav.Pass    as p on p.PassGuid = pa.PassGuid
    left join nav.Receipt as r on r.ReceiptGuid = pa.ReceiptGuid
    Where p.VesselGuid=@vesselGuid
      and p.VtsZoneCode=isNull(@VtsZoneCode,p.VtsZoneCode)
    Order by p.StartDate desc;

    return;

end
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Func\table_nav.fnGetVesselDraft.sql
-- generate order 40
go
create function nav.fnGetVesselDraft (@VesselGuid uniqueidentifier, @VtsZoneCode varchar(2) = null, @MaxTimeDiff_Min int = 180)
returns 
@Result table (PassGuid uniqueidentifier 
               ,PassNumber nvarchar(10) 
               ,VesselGuid uniqueidentifier 
               ,PassStartdate datetime
               ,PassFinishDate datetime 
               ,VtsCode            nvarchar( 2)
               ,VtsZoneCode        nvarchar( 2)
               ,DepartureLocationCode varchar(5)
               ,DestinationLocationCode varchar(5)
               ,PassDirectionCode  nvarchar(10)
               ,PassTypeCode varchar(3)
               ,EtaDate datetime
               )
as
begin

   /* 
     ���: ��������� ����������(��������) ��������� ����������� �� ����� ��� ��������� ���� (���� ���� �� ������� �� �� ���� �����)
     PS. ���� � PassDraft �������� ��������� �����, �� �������� ��������� � ����������� ����������� �� EtaDate � �������� ���������� ��������� @MaxTimeDiff_Min �����
   */
    Declare @CurDateTime datetime = getdate()

    Insert into @Result (PassGuid 
               ,PassNumber
               ,VesselGuid
               ,PassStartdate
               ,PassFinishDate
               ,VtsCode
               ,VtsZoneCode
               ,DepartureLocationCode
               ,DestinationLocationCode
               ,PassDirectionCode
               ,PassTypeCode
               ,EtaDate)
    Select top 1 
               npd.PassGuid
              ,npd.PassNumber
              ,npd.VesselGuid
              ,npd.StartDate
              ,npd.FinishDate
              ,npd.VtsCode
              ,npd.VtsZoneCode
              ,npd.DepartureLocationCode
              ,npd.DestinationLocationCode
              ,npd.PassDirectionCode
              ,npd.PassTypeCode
              ,npd.EtaDate
       from
         (Select 
               p.PassGuid
              ,p.PassNumber
              ,p.VesselGuid
              ,p.StartDate
              ,p.FinishDate
              ,p.VtsCode
              ,p.VtsZoneCode
              ,p.DepartureLocationCode
              ,p.DestinationLocationCode
              ,p.PassDirectionCode
              ,P.PassTypeCode
              ,p.EtaDate
              ,row_number() over(order by abs(DateDiff(minute,isnull(p.EtaDate,p.StartDate),@CurDateTime))) time_diff_rank -- 
    from nav.PassDraft as pd
    join nav.Pass as p on p.PassGuid = pd.PassGuid
    Where p.VesselGuid=@vesselGuid
      and p.VtsZoneCode=isNull(@VtsZoneCode,p.VtsZoneCode)
      and p.IsDeleted=0
      and abs(DateDiff(minute,isnull(p.EtaDate,p.StartDate),@CurDateTime))<@MaxTimeDiff_Min -- ���������� ����������� ���� ������ ���������� �� ����� ���������� ���������� �����
      ) npd
    where npd.time_diff_rank=1
    

    return;

end
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Func\table_nav.fnGetVesselLastPass.sql
-- generate order 41
go
create function nav.fnGetVesselLastPass (@VesselGuid uniqueidentifier, @VtsZoneCode varchar(2) = null)
returns 
@Result table (PassGuid uniqueidentifier 
               ,PassNumber nvarchar(10) 
               ,VesselGuid uniqueidentifier 
               ,PassStartDate datetime
               ,PassFinishDate datetime 
               ,VtsCode            nvarchar( 2)
               ,VtsZoneCode        nvarchar( 2)
               ,DepartureLocationCode varchar(5)
               ,DestinationLocationCode varchar(5)
               ,PassDirectionCode  nvarchar(10)
               ,PassTypeCode varchar(3)
               ,RecStartDate datetime
               ,RecFinishDate datetime
               ,RecsiptGuid uniqueidentifier
               ,ReceiptTypeCode    nvarchar(5)
               ,StartPositionCode  nvarchar(10)
               ,FinishPositionCode nvarchar(10)
               ,EtaDate datetime
               ,isActive bit	-- ��������
               ,isDraft bit     -- ��������
               )
as
begin

   /* 
     ���: ��������� ���������� ����������� (������, ���������/�� ���������/���������) � ��������� �� �����  ��� ��������� ���� (���� ���� �� ������� �� �� ���� �����)
   */

    Insert into @Result (PassGuid 
               ,PassNumber
               ,VesselGuid
               ,PassStartDate
               ,PassFinishDate
               ,VtsCode
               ,VtsZoneCode
               ,DepartureLocationCode
               ,DestinationLocationCode
               ,PassDirectionCode
               ,PassTypeCode
               ,RecsiptGuid
               ,RecStartDate
               ,RecFinishDate
               ,ReceiptTypeCode
               ,StartPositionCode
               ,FinishPositionCode
               ,EtaDate
               ,isActive
               ,isDraft)
    Select   top 1
               p.PassGuid
              ,p.PassNumber
              ,p.VesselGuid
              ,p.StartDate
              ,p.FinishDate
              ,p.VtsCode
              ,p.VtsZoneCode
              ,p.DepartureLocationCode
              ,p.DestinationLocationCode
              ,p.PassDirectionCode
              ,P.PassTypeCode
              ,pa.ReceiptGuid
              ,r.StartDate
              ,r.FinishDate
              ,r.ReceiptTypeCode
              ,r.StartPositionCode
              ,r.FinishPositionCode
              ,p.EtaDate
              ,case when not PA.PassGuid is null then 1 else 0 end isActive
              ,case when not PD.PassGuid is null then 1 else 0 end isDraft
    from nav.Pass p
    left join nav.PassDraft PD on PD.PassGuid=P.PassGuid
    left join nav.PassActive PA on pa.PassGuid=p.PassGuid
    left join nav.Receipt as r on r.ReceiptGuid = pa.ReceiptGuid
    Where p.VesselGuid=@vesselGuid
      and p.VtsZoneCode=isNull(@VtsZoneCode,p.VtsZoneCode)
    Order by P.StartDate desc;

    return;

end
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Sp\01_atm.AutoLineCross.sql
-- generate order 42
go
create procedure atm.AutoLineCross
      @vesselGuid    uniqueidentifier    -- ��� �����
    , @position      uniqueidentifier    -- ��� ������� �������� (dbo.Postion.Uid)    
    , @crossDate     datetime            -- ����/����� �����������
    , @secondDiff    int          output -- ���� ���� ������ ����������� - ����� � ���
    , @crossType     nvarchar(5)  output -- ���� ���� ������ ����������� - ��� ��� in/out
    , @positionCode  nvarchar(10) output -- ���������� ��� ����� �������
    , @positionTypeCode nvarchar(19) output -- ���������� ��� �������
    , @dspName          nvarchar(20) output -- ��� ������� 2
as
begin
    -- ����� ����������� ����������� ������ �����.
    
    -- ���� ������������ ������ ������ �����, �� �������� � ����������� �� DspName
    -- �������� ���� � ���� CrossInDate or CrossOutDate
    -- ���� ��� ���� ������� � ����������� ����� �����
    -- � ������������ ������ - ������� ������ ����
    -- ���� ����� ������ ���������� ��������� ��������, �� ����������� ���� �������� � ��� �����������

    -- ���� �������������� ���� �������
    select 
          @positionCode     = p.PositionCode
        , @dspName          = tp.DSP_Name
        , @positionTypeCode = p.PositionTypeCode 
    from vtsdb..Positions as tp
    join nsi.Position     as p on p.RsbmGuid = tp.Position_GUID
    where tp.Uid = @position

    -- ������ � ����� �������� ���, �������
    if @positionCode is null
    begin        
        set @secondDiff = null
        set @crossType  = null
        return;
    end

    declare @posCrossGuid uniqueidentifier
    declare @crossInDate  datetime
    declare @crossOutDate datetime 

    -- ������� ���� �� �����������
    select 
          @posCrossGuid = PositionCrossGuid
        , @crossInDate = CrossInDate
        , @crossOutDate = CrossOutDate
    from atm.PositionCross 
    where VesselGuid = @vesselGuid 
    and PositionCode = @positionCode 
    
    if @posCrossGuid is not null
    begin
        -- ���� ������ ����
        if @dspName like 'In%'
        begin
            -- ���� � In ��� �������� ����
            if @crossInDate is not null
            begin
                -- ��������� ������, ������ ������� � �������
                set @secondDiff = null
                set @crossType  = null
                return;
            end

            -- ���� � In ��� ��� ����
            if @crossInDate is null
            begin
                update atm.PositionCross set CrossInDate = @crossDate , UpdateDate = getdate()
                where PositionCrossGuid = @posCrossGuid
                set @crossInDate = @crossDate
            end

        end -- in

        if @dspName like 'Out%'
        begin
            if @crossOutDate is not null
            begin
                set @secondDiff = null
                set @crossType  = null
                return;
            end

            if @crossOutDate is  null
            begin
                update atm.PositionCross set CrossOutDate = @crossDate, UpdateDate = getdate()
                where  PositionCrossGuid = @posCrossGuid
                set @crossOutDate = @crossDate
            end        
        end -- out
    end else begin

        -- ���� ������ ��� - �������
        insert into atm.PositionCross (
              PositionCrossGuid
            , VesselGuid
            , PositionCode
            , CrossInDate
            , CrossOutDate
            , InsertDate
            , UpdateDate )
        select
              newid() --PositionCrossGuid
            , @vesselGuid
            , @positionCode
            , case when  @dspName like 'In%' then @crossDate else null end
            , case when  @dspName like 'Out%' then @crossDate else null end
            , getdate()
            , getdate() 
    end

    -- ���� �����-��  �� ��� NULL - �� �������
    if @crossInDate = null or @crossOutDate = null
    begin
        set @secondDiff = null
        set @crossType  = null
        return;
    end

    if @crossInDate > @crossOutDate
    begin
        set @secondDiff = datediff(second,@crossOutDate,@crossInDate)
        set @crossType  = 'out'
        return;
    end

    if @crossInDate < @crossOutDate
    begin
        set @secondDiff = datediff(second,@crossInDate, @crossOutDate)
        set @crossType  = 'in'
        return;
    end
end
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Sp\05_arm.CrossEventLine.sql
-- generate order 43
go
create procedure atm.CrossEventLine
      @vesselGuid             uniqueidentifier
    , @crossType              nvarchar( 5) -- in/out
    , @dspName                nvarchar(20)
    , @actDate                datetime
    , @actPositionCode        nvarchar(10)
    , @actPositionTypeCode    nvarchar(10)
    , @actVtsCode             nvarchar( 2)
    , @actZoneCode            nvarchar( 2)     
    , @actLat                 float            = null
    , @actLon                 float            = null
    , @actUserOnWatch         nvarchar(512)    = null
    , @prevPassGuid           uniqueidentifier = null
    , @prevReceiptTypeCode    nvarchar( 5)     = null
    , @prevVtsCode            nvarchar( 2)     = null
    , @prevVtsZoneCode        nvarchar( 2)     = null
    , @prevPassDirectionCode  nvarchar(10)     = null
    , @prevStartPositionCode  nvarchar(10)     = null
    , @prevFinishPositionCode nvarchar(10)     = null
    , @newPassGuid            uniqueidentifier output
as
begin
    if @dspName in ('CP')
    begin
        print 1
    end else
    if @dspName in ('Pilot')
    begin
        print 2
    end 
end
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Sp\05_atm.CrossLineBorder.sql
-- generate order 44
go
create procedure atm.CrossLineBorder
      @vesselGuid             uniqueidentifier
    , @crossType              nvarchar( 5) -- in/out
    , @dspName                nvarchar(20)
    , @actDate                datetime
    , @actPositionCode        nvarchar(10)
    , @actPositionTypeCode    nvarchar(10)
    , @actVtsCode             nvarchar( 2)
    , @actZoneCode            nvarchar( 2)     
    , @actLat                 float            = null
    , @actLon                 float            = null
    , @actUserOnWatch         nvarchar(512)    = null
    , @newPassGuid            uniqueidentifier output
as
begin
    -- ��������� ����������� ����� ���������� ��� ������� ����
	declare @prevPassGuid           uniqueidentifier
    declare @prevReceiptTypeCode    nvarchar( 5)
    declare @prevVtsCode            nvarchar( 2)
    declare @prevVtsZoneCode        nvarchar( 2)
    declare @prevPassDirectionCode  nvarchar(10)
    declare @prevStartPositionCode  nvarchar(10)
    declare @prevFinishPositionCode nvarchar(10)
	declare @prevStartDate          datetime
	declare @prevEtaDate            datetime
	declare @prevIsActive           bit
	declare @prevIsDraft            bit

	declare @actPassDirectionCode nvarchar(10)

	-- ���� �������� ���������� �� ���� ����� ����� �������
	Select   
	          @prevPassGuid           = PassGuid
            , @prevReceiptTypeCode    = ReceiptTypeCode
            , @prevVtsCode            = VtsCode
            , @prevVtsZoneCode        = VtsZoneCode
            , @prevPassDirectionCode  = PassDirectionCode
            , @prevStartPositionCode  = StartPositionCode
            , @prevFinishPositionCode = FinishPositionCode
		    , @prevStartDate          = PassStartDate
		    , @prevEtaDate            = EtaDate
	 from atm.fnGetVesselLastPass(@vesselGuid,null)
	 where isActive=1
	   and VtsZoneCode<>@actZoneCode;

    if @crossType = 'out' 
	begin -- ������� ����� ������ ���� � ����
        if not @prevPassGuid is null
 	    begin -- ���� ����������
		  -- ���� ������� ������ ����������
		  
            insert into atm.AutomationCommand
            select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'ClosePass'           -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @prevPassGuid         -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @prevVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @prevVtsZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @prevPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����

				  -- ������� ������ ����� ������� ���������� � ������ �������

				 
		          Set @actPassDirectionCode = @prevPassDirectionCode ---atm.fnGetDirectionByInPos(@actPositionCode,@crossType);  -- �� �������, ���� ������� ��������� ������ ������ �����- "� ������"/"� ���"

         -- ���� �������� ���������� ��� �������� � ������� ����
	     Select   
	          @prevPassGuid           = PassGuid
            , @prevReceiptTypeCode    = ReceiptTypeCode
            , @prevVtsCode            = VtsCode
            , @prevVtsZoneCode        = VtsZoneCode
            , @prevPassDirectionCode  = PassDirectionCode
            , @prevStartPositionCode  = StartPositionCode
            , @prevFinishPositionCode = FinishPositionCode
		    , @prevStartDate          = PassStartDate
		    , @prevEtaDate            = EtaDate
	     from atm.fnGetVesselLastPass(@vesselGuid,@actZoneCode)
	     where isActive=1 or isDraft=1;
	      
		 if not @prevPassGuid is null and @prevIsActive=1
         begin -- ���� �������� ���������� ���� ��������� ��� ������������, ��������� �� ������ ��� ������ (�������� ����� ������� �������������)
		    -- ���� ��������� ������������ �����: (���� ��� ��������!!!) 
		    -- ���� ��������� ���� ����������� ������ ������� ����� ��� �� 30 �����
	        -- ��� ���� ��������� ���� �� ������� �� ��������� ���� �������� ������ ������� ����� ��� �� 60 �����
            if (not @prevStartDate is null and abs(Datediff(minute, @actDate,@prevStartDate))>30) or (@prevStartDate is null and abs(Datediff(minute, @actDate,@prevEtaDate))>30) -- ������
		    begin -- ���� ���������� ������ �� ���� ��� ������� � ������� �����
                insert into atm.AutomationCommand
                select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'ClosePass'           -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @prevPassGuid         -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����

				  -- ������� ������ ����� ������� ���������� � ������ �������

				  -- �� �������, ���� ������� ��������� ������ ������ �����- "� ������"/"� ���"
		          Set @actPassDirectionCode =atm.fnGetDirectionByInPos(@actPositionCode,@crossType);

				  set @newPassGuid=newid();
          
                  insert into atm.AutomationCommand
                  select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'CreatePass'          -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @newPassGuid          -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����

		    end
		    else
		    begin
		        -- ���� ��� ������������ ���������� �������� ���������� 
	            -- ��������� ������ ��� �����
  		        set @newPassGuid=@prevPassGuid;        
			    -- ����� ������ ������ �� ���� 
            end
       end
	   else
	   if not @prevPassGuid is null and @prevIsDraft=1
	   begin -- ��� ��������� ���������, �� ���� ��������
	      -- ���� ������� �������� ��������
		  -- �� �������, ���� ������� ��������� ������ ������ �����- "� ������"/"� ���"
		  Set @actPassDirectionCode =atm.fnGetDirectionByInPos(@actPositionCode,@crossType);
	      set @newPassGuid=@prevPassGuid;        
          insert into atm.AutomationCommand
            select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'CreatePassFromDraft'          -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @newPassGuid          -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����
	   end
	   else
	   begin
	       -- ��� �� ��������� ����������� �� ���������
	       -- ����� ������� ���������� � ������ �������
		   -- �� �������, ���� ������� ��������� ������ ������ �����- "� ������"/"� ���"
		    Set @actPassDirectionCode =atm.fnGetDirectionByInPos(@actPositionCode,@crossType);
		    set @newPassGuid=newid();
            insert into atm.AutomationCommand
            select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'CreatePass'          -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @newPassGuid          -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����
       end
	   end
    end
end
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Sp\05_atm.CrossLineMoorInOut.sql
-- generate order 45
go
create procedure atm.CrossLineMoorInOut
      @vesselGuid             uniqueidentifier
    , @crossType              nvarchar( 5) -- in/out
    , @dspName                nvarchar(20)
    , @actDate                datetime
    , @actPositionCode        nvarchar(10)
    , @actPositionTypeCode    nvarchar(10)
    , @actVtsCode             nvarchar( 2)
    , @actZoneCode            nvarchar( 2)     
    , @actLat                 float            = null
    , @actLon                 float            = null
    , @actUserOnWatch         nvarchar(512)    = null
    , @newPassGuid            uniqueidentifier output
as
begin
    -- ��������� ����������� ����� ����� ������� (����� ���������� � �������/������ � �������)
    -- ������� ����� ����������� �����
    -- In (Inner - ���������� �����) = �����, ��� Out (Outer) ������� ����� = ����

	declare @prevPassGuid           uniqueidentifier
    declare @prevReceiptTypeCode    nvarchar( 5)
    declare @prevVtsCode            nvarchar( 2)
    declare @prevVtsZoneCode        nvarchar( 2)
    declare @prevPassDirectionCode  nvarchar(10)
    declare @prevStartPositionCode  nvarchar(10)
    declare @prevFinishPositionCode nvarchar(10)
	declare @prevStartDate          datetime
	declare @prevEtaDate            datetime
	declare @prevIsActive           bit
	declare @prevIsDraft            bit
	declare @actPassDirectionCode nvarchar(10)
	--------- �����---------------
    if @crossType = 'in' 
    begin -- ��������� �����, �� ���� ����������
	    -- ������ ��������� �������� ���������� � ������ ����
		Select   
	          @prevPassGuid           = PassGuid
            , @prevReceiptTypeCode    = ReceiptTypeCode
            , @prevVtsCode            = VtsCode
            , @prevVtsZoneCode        = VtsZoneCode
            , @prevPassDirectionCode  = PassDirectionCode
            , @prevStartPositionCode  = StartPositionCode
            , @prevFinishPositionCode = FinishPositionCode
		    , @prevStartDate          = PassStartDate
		    , @prevEtaDate            = EtaDate
	    from atm.fnGetVesselLastPass(@vesselGuid,@actZoneCode)
	    where isActive=1;

		if not @prevPassGuid is null
		begin -- ���� ����������
		  -- ���� ������� ������� ���������
		  insert into atm.AutomationCommand
                  select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'CreateReceipt'          -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @newPassGuid          -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @prevPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����
		end
		else
		begin
		  -- ��������� ����������� ���! �������� �� ��� ������?
		  Print '��������� ����������� ���!'
		end
	end	
	else 
	if  @crossType = 'out'
	begin -- ������� �����, �� ���� ���������
	    Select   
	          @prevPassGuid           = PassGuid
            , @prevReceiptTypeCode    = ReceiptTypeCode
            , @prevVtsCode            = VtsCode
            , @prevVtsZoneCode        = VtsZoneCode
            , @prevPassDirectionCode  = PassDirectionCode
            , @prevStartPositionCode  = StartPositionCode
            , @prevFinishPositionCode = FinishPositionCode
		    , @prevStartDate          = PassStartDate
		    , @prevEtaDate            = EtaDate
	    from atm.fnGetVesselLastPass(@vesselGuid,@actZoneCode)
	    where isActive=1;

		if @prevPassGuid is not null
		begin -- ���� ����������
		   Declare @NoAutoPassMoorClose bit = 0;

		   Select @NoAutoPassMoorClose=case when CHARINDEX('NoAutoPassMoorClose', AutoMarkList)>0 then 1 else 0 end 
		    from nsi.Vessel
		   where VesselGuid=@vesselGuid;
            --  ��� ������������� CONTAINS(AutoMarkList,'NoAutoPassMoorClose')  ��������� ������ �������

		   if @NoAutoPassMoorClose=1 -- ������� "�� ����� ���������� � �������"
		   begin
		      -- ���� ������ ���������� ��������� � �������� �����������
			  insert into atm.AutomationCommand
                  select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'CreateReceipt'          -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @prevPassGuid          -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'moor'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @prevPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����
		   end
		   else
		   begin -- ��� �������� "�� ����� ���������� � �������"

		      insert into atm.AutomationCommand
                select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'ClosePass'           -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @prevPassGuid         -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @prevPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����

				  -- ������� ������ ����� ������� ���������� � ������ �������

				  -- �� �������, ���� ������� ��������� ������ ������ �����- "� ������"/"� ���"
		          Set @actPassDirectionCode =atm.fnGetDirectionByInPos(@actPositionCode,@crossType);

				  set @newPassGuid=newid();
          
                  insert into atm.AutomationCommand
                  select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'CreatePass'          -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @newPassGuid          -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����

		   end
		end
		else
		begin
		  --  ��� �����������
		  Print 1
		end
	end
    print 1
end
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Sp\05_atm.CrossMoveInOut.sql
-- generate order 46
go
create procedure atm.CrossMoveInOut
      @vesselGuid             uniqueidentifier
    , @crossType              nvarchar( 5) -- in/out
    , @dspName                nvarchar(20)
    , @actDate                datetime
    , @actPositionCode        nvarchar(10)
    , @actPositionTypeCode    nvarchar(10)
    , @actVtsCode             nvarchar( 2)
    , @actZoneCode            nvarchar( 2)     
    , @actLat                 float            = null
    , @actLon                 float            = null
    , @actUserOnWatch         nvarchar(512)    = null
    , @newPassGuid            uniqueidentifier output
as
    declare @actPassDirectionCode nvarchar(10)
begin
    -- 2019/11/14 ���
    -- ������� ����� ����������� �����
    -- In (Inner - ���������� �����) = �����, ��� Out (Outer) ������� ����� = ����
    set @newPassGuid = null
   
    declare @prevPassGuid           uniqueidentifier
    declare @prevReceiptTypeCode    nvarchar( 5)
    declare @prevVtsCode            nvarchar( 2)
    declare @prevVtsZoneCode        nvarchar( 2)
    declare @prevPassDirectionCode  nvarchar(10)
    declare @prevStartPositionCode  nvarchar(10)
    declare @prevFinishPositionCode nvarchar(10)
	declare @prevStartDate          datetime
	declare @prevEtaDate            datetime
	declare @prevIsActive           bit
	declare @prevIsDraft            bit

	--------- �����---------------
    if @crossType = 'in' 
    begin -- ��������� �����, �� ���� �����
	    -- ������ ��������� �������� ���������� � ������ ����
		Select   
	          @prevPassGuid           = PassGuid
            , @prevReceiptTypeCode    = ReceiptTypeCode
            , @prevVtsCode            = VtsCode
            , @prevVtsZoneCode        = VtsZoneCode
            , @prevPassDirectionCode  = PassDirectionCode
            , @prevStartPositionCode  = StartPositionCode
            , @prevFinishPositionCode = FinishPositionCode
		    , @prevStartDate          = PassStartDate
		    , @prevEtaDate            = EtaDate
	    from atm.fnGetVesselLastPass(@vesselGuid,@actZoneCode)
	    where isActive=1;

		if @prevPassGuid is not null
        begin--  ���� ���� �������� ���������� ����� ��� �������

            insert into atm.AutomationCommand
            select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'ClosePass'           -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @prevPassGuid         -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����

        end
    end else
	----- ���� --------------------
    if @crossType = 'out' 
	begin -- ������� �����, �� ���� ����
	     -- ������ ��������� ���������� � ������ ���� (�������� ��� ��������)
		Select   
	          @prevPassGuid           = PassGuid
            , @prevReceiptTypeCode    = ReceiptTypeCode
            , @prevVtsCode            = VtsCode
            , @prevVtsZoneCode        = VtsZoneCode
            , @prevPassDirectionCode  = PassDirectionCode
            , @prevStartPositionCode  = StartPositionCode
            , @prevFinishPositionCode = FinishPositionCode
		    , @prevStartDate          = PassStartDate
		    , @prevEtaDate            = EtaDate
			, @prevIsActive           = isActive
			, @prevIsDraft            = isDraft
	    from atm.fnGetVesselLastPass(@vesselGuid,@actZoneCode)
	    where isActive=1 or isDraft=1;


	    if not @prevPassGuid is null and @prevIsActive=1
        begin -- ���� �������� ���������� ���� ��������� ��� ������������, ��������� �� ������ ��� ������ (�������� ����� ������� �������������)
		    -- ���� ��������� ������������ �����: (���� ��� ��������!!!) 
		    -- ���� ��������� ���� ����������� ������ ������� ����� ��� �� 30 �����
	        -- ��� ���� ��������� ���� �� ������� �� ��������� ���� �������� ������ ������� ����� ��� �� 60 �����
            if (not @prevStartDate is null and abs(Datediff(minute, @actDate,@prevStartDate))>30) or (@prevStartDate is null and abs(Datediff(minute, @actDate,@prevEtaDate))>30) -- ������
		    begin -- ���� ���������� ������ �� ���� ��� ������� � ������� �����
                insert into atm.AutomationCommand
                select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'ClosePass'           -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @prevPassGuid         -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����

				  -- ������� ������ ����� ������� ���������� � ������ �������

				  -- �� �������, ���� ������� ��������� ������ ������ �����- "� ������"/"� ���"
		          Set @actPassDirectionCode =atm.fnGetDirectionByInPos(@actPositionCode,@crossType);

				  set @newPassGuid=newid();
          
                  insert into atm.AutomationCommand
                  select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'CreatePass'          -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @newPassGuid          -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����

		    end
		    else
		    begin
		        -- ���� ��� ������������ ���������� �������� ���������� 
	            -- ��������� ������ ��� �����
  		        set @newPassGuid=@prevPassGuid;        
			    -- ����� ������ ������ �� ���� 
            end
       end
	   else
	   if not @prevPassGuid is null and @prevIsDraft=1
	   begin -- ��� ��������� ���������, �� ���� ��������
	      -- ���� ������� �������� ��������
		  -- �� �������, ���� ������� ��������� ������ ������ �����- "� ������"/"� ���"
		  Set @actPassDirectionCode =atm.fnGetDirectionByInPos(@actPositionCode,@crossType);
	      set @newPassGuid=@prevPassGuid;        
          insert into atm.AutomationCommand
            select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'CreatePassFromDraft'          -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @newPassGuid          -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����
	   end
	   else
	   begin
	       -- ��� �� ��������� ����������� �� ���������
	       -- ����� ������� ���������� � ������ �������
		   -- �� �������, ���� ������� ��������� ������ ������ �����- "� ������"/"� ���"
		    Set @actPassDirectionCode =atm.fnGetDirectionByInPos(@actPositionCode,@crossType);
		    set @newPassGuid=newid();
            insert into atm.AutomationCommand
            select
                    newid()               -- AutomationCommandGuid   uniqueidentifier rowguidcol not null
                  , 'CreatePass'          -- AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
                  , 'TRANSAS'             -- InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
                  , @newPassGuid          -- ActPassGuid             uniqueidentifier null -- ��� �����������
                  , @vesselGuid           -- ActVesselGuid           uniqueidentifier not null -- ��� �����
                  , 'move'                -- ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
                  , @actPositionCode      -- ActPositionCode         nvarchar(10)     null -- ��� �������
                  , @actVtsCode           -- ActVtsCode              nvarchar( 2)     null -- ��� ����
                  , @actZoneCode          -- ActZoneCode             nvarchar( 2)     null -- ��� ����
                  , @actPassDirectionCode -- ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
                  , @actLat               -- ActLat                  float            null -- ���������� �������
                  , @actLon               -- ActLon                  float            null -- ���������� �������
                  , @actDate              -- ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)
                  , @actUserOnWatch       -- AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������
                  , getdate()             -- InsertDate              datetime      not null -- ����/����� ������� � �������
                  , null                  -- LoadedDate              datetime          null -- ����/����� ��������� ��������
                  , null                  -- StartProcessingDate     datetime          null -- ����/����� ������ ���������
                  , null                  -- ComplitedDate           datetime          null -- ����/����� ���������� ���������
                  , null                  -- ComplitedMsg            nvarchar(255)     null -- ��������� ����������
                  , null                  -- LogActionId             tinyint           null -- ���������� ������������� "������ ��������", ������ ��������� � ��� ��� ������� � ����
	   end
    end
end
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Sp\09_atm.AutoProcessing.sql
-- generate order 47
go
create procedure atm.AutoProcessing
    -- ����� ���������� �� �������� �������������
      @RecordTime     datetime
    , @RecordType     uniqueidentifier
    , @ControlCentre  uniqueidentifier
    , @Vessel_GUID    uniqueidentifier
    , @Operator       uniqueidentifier
    , @OperatorName   varchar(500)
    , @OS             varchar(100)
    , @Position       uniqueidentifier
    , @GeoCoordinates decimal(21,0)
    , @ImoNumber      int
    , @MMSI           int
    , @System         bit
    , @ETANextPort    datetime
    , @Speed          float
    , @Course         float
    , @Pilot          uniqueidentifier
    , @Vessel_Name    nvarchar(100)
    , @TypeName       nvarchar(100)
    , @Callsign       nvarchar( 10)
    , @FlagName       nvarchar(100)
    , @Length         float
    , @Beam           float
    , @Draught        float
    , @Destination    nvarchar(100)
    , @RecordText     nvarchar(500)
as
begin
    -- ��� 20191108
    -- �� ������� ������ ���������� �� �������� ������������� (�������� ����������)
    -- ����� ������ ���������������:
    --   - ����� ������� (�������)
    --   - ������� �����������
    --   - ���������� �������
    --   - ������������ �� ����� � ���� (�������������)

    -- ����� ���� �������� ������� � ������� cmd.AutomationCommand
    -- ����
    --        AutomationCommandGuid   uniqueidentifier rowguidcol not null
    --      , AutomationCommandCode   nvarchar(100) not null -- ��� - CreateReceipt, CreatePass, ClosePass
    --      , InsertInitiatorCode     nvarchar(100) not null -- ��� ��������� (��� ��� ������) - TRANSAS, SYNCHRO, USER. ������� [nsi].[Initiator]
    
    
    --      , ActPassGuid             uniqueidentifier null -- ��� �����������
    --      , ActVesselGuid           uniqueidentifier not null -- ��� �����
    --      , ActReceiptTypeCode      nvarchar(10)     null -- ��� ���� ���������
    --      , ActPositionCode         nvarchar(10)     null -- ��� �������
    --      , ActVtsCode              nvarchar( 2)     null -- ��� ����
    --      , ActZoneCode             nvarchar( 2)     null -- ��� ����
    --      , ActPassDirectionCode    nvarchar(10)     null -- ����������� ��������
    --      , ActLat                  float            null -- ���������� �������
    --      , ActLon                  float            null -- ���������� �������
    --      , ActDate                 datetime         null -- ����� ������� ������������� (����� ������ ������)

    --      , AppUserLoginOnWatchList nvarchar(2048)   null -- ������ ���������� ������� �� ����� � ������ ������

    -- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    declare @positionTypeCode nvarchar(10)
    
    declare @actPassGuid           uniqueidentifier
    declare @actVesselGuid         uniqueidentifier
    declare @actReceiptTypeCode    nvarchar(5)
    declare @actPositionCode       nvarchar(10)
    declare @actVtsCode            nvarchar(2)
    declare @actZoneCode           nvarchar(2)
    declare @actPassDirectionCode  nvarchar(10)
    declare @actLat                float
    declare @actLon                float
    declare @actDate               datetime


    -- ���������� ���� �� ����������� ������ �����
    declare @secondDiff    int        
    declare @crossType     nvarchar( 5)
    declare @dspName       nvarchar(20)

    exec atm.AutoLineCross
      @vesselGuid       = @Vessel_GUID            -- uniqueidentifier -- ��� �����
    , @position         = @Position               -- uniqueidentifier -- ��� ������� �������� (dbo.Postion.Uid)    
    , @crossDate        = @RecordTime             -- datetime         -- ����/����� �����������
    , @secondDiff       = @secondDiff       output -- int          ���� ���� ������ ����������� - ����� � ���
    , @crossType        = @crossType        output -- nvarchar( 5) ���� ���� ������ ����������� - ��� ��� in/out
    , @positionCode     = @actPositionCode  output -- nvarchar(10) ��� ������� �� ���� VtsDb3
    , @positionTypeCode = @positionTypeCode output -- nvarchar(10) ��� �������
    , @dspName          = @dspName          output -- nvarchar(20) ��� ������� �� ������� ��������

    -- ��� ����������� ������ �����, �������
    if @crossType is null return;

    if @secondDiff < 100 return;

    --------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------

    -- ��������� ���� ����� �� UTC
    set @actDate = dateadd(hour, datediff(hour, getutcdate(), getdate()), @RecordTime) ;

    -- ���������� �������� ��������� � ������/�������
    set @actLat = case when  ( @GeoCoordinates - floor ( @GeoCoordinates / 4294967296 ) * 4294967296 ) > 2147483648 
            then convert ( float, - ( 4294967296 - ( @GeoCoordinates - floor ( @GeoCoordinates / 4294967296 ) * 4294967296 ) ) ) 
            else convert ( float, ( @GeoCoordinates - floor ( @GeoCoordinates / 4294967296 ) * 4294967296 ) ) 
        end;

    set @actLon = case when floor ( @GeoCoordinates / 4294967296 ) > 2147483648 
            then convert ( float, - ( 4294967296 - floor ( @GeoCoordinates / 4294967296 ) ) ) 
            else convert ( float, floor ( @GeoCoordinates / 4294967296 ) ) 
        end;


    declare @vesselGuid uniqueidentifier

    -- �������� ����� ������ �����������, � �� ����������� ����� Vessel_Guid ����� ��������� �� ���� VtsDb2, �� �������
    -- �������� �������, � ����� ������ ���� ��� ������� ����������� ��� � Guid ������� nsi.Vessel ���� VtsDb3
    set @vesselGuid = @vessel_Guid;

    --------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------

    declare @newPassGuid uniqueidentifier

    -- ��������� ����������� ������ �����, �� ���� ���

	set @actVtsCode   = '';

	-- �� ������� ��������� ���� � ������� ��������� �������
    select @actZoneCode=isNull(p.VtsZoneCode,'')
    from vtsdb.dbo.Positions as tp
    left join vtsdb3.nsi.Position as p on p.PositionCode = tp.ISOBMPositionCode
    where tp.Uid = @Position;

/*
    -- ������� �� ��� ���� �� �����, ���� �� �������� ���������� � ������ ����
   
    declare @prevPassGuid           uniqueidentifier
    declare @prevReceiptTypeCode    nvarchar( 5)
    declare @prevVtsCode            nvarchar( 2)
    declare @prevVtsZoneCode        nvarchar( 2)
    declare @prevPassDirectionCode  nvarchar(10)
    declare @prevStartPositionCode  nvarchar(10)
    declare @prevFinishPositionCode nvarchar(10)
	declare @prevStartDate          datetime
	declare @prevEtaDate             datetime

    select
          @prevPassGuid           = p.PassGuid
        , @prevReceiptTypeCode    = r.ReceiptTypeCode
        , @prevVtsCode            = p.VtsCode
        , @prevVtsZoneCode        = p.VtsZoneCode
        , @prevPassDirectionCode  = p.PassDirectionCode
        , @prevStartPositionCode  = r.StartPositionCode
        , @prevFinishPositionCode = r.FinishPositionCode
		, @prevStartDate          = p.StartDate
		, @prevEtaDate            = p.EtaDate
    from atm.PassActive as pa
    join      atm.Pass    as p on p.PassGuid = pa.PassGuid
    left join atm.Receipt as r on r.ReceiptGuid = pa.ReceiptGuid
	where p.VesselGuid=@Vessel_GUID
	  and p.VtsZoneCode=@actZoneCode
	  and p.FinishDate is null;
	  --and (not p.StartDate is null and abs(Datediff(minute, @actDate,p.StartDate))>30); -- ��������� �� ����� �������� ����� (���� ����� �� ��������� ����������)

    -- ���� ��������� ���� ����������� ������ ������� ����� ��� �� 30 �����
	-- ��� ���� ��������� ���� �� ������� �� ��������� ���� �������� ������ ������� ����� ��� �� 60 �����
    --if (not @prevStartDate is null and abs(Datediff(minute, @actDate,@prevStartDate))>30) or (@prevStartDate is null and abs(Datediff(minute, @actDate,@prevEtaDate))>30) -- ������


	Select   
	      @prevPassGuid           = PassGuid
        , @prevReceiptTypeCode    = ReceiptTypeCode
        , @prevVtsCode            = VtsCode
        , @prevVtsZoneCode        = VtsZoneCode
        , @prevPassDirectionCode  = PassDirectionCode
        , @prevStartPositionCode  = StartPositionCode
        , @prevFinishPositionCode = FinishPositionCode
		, @prevStartDate          = PassStartDate
		, @prevEtaDate            = EtaDate
	from atm.fnGetVesselLastPass(@Vessel_GUID,@actZoneCode)
	where isActive=1 or isDraft=1;
*/
    begin -- ���� � ������� ����������� ����� ������� ����� �����������
        exec atm.CrossEventLine
              @crossType              = @crossType             -- nvarchar( 5) -- in/out
            , @dspName                = @dspName               --
            , @actPositionCode        = @actPositionCode       -- nvarchar(10)
            , @positionTypeCode       = @positionTypeCode    -- nvarchar(10)
    end

    begin 
        -- � ����������� �� dspName �������� ��������� ��
        if @dspName in ('In', 'Out')
        begin
            exec atm.CrossMoveInOut
                  @vesselGuid             = @vesselGuid
                , @crossType              = @crossType               -- nvarchar( 5) -- in/out
                , @dspName                = @dspName                 --
                , @actDate                = @actDate
                , @actPositionCode        = @actPositionCode         -- nvarchar(10)
                , @positionTypeCode       = @positionTypeCode        -- nvarchar(10)
                , @actVtsCode             = @actVtsCode 
                , @actZoneCode            = @actZoneCode
                , @actLat                 = @actLat
                , @actLon                 = @actLon
                , @actUserOnWatch         = @OperatorName
                , @newPassGuid            = @newPassGuid output

        end else
        if @dspName = 'Moor Out'
        begin
            exec atm.CrossLineMoorInOut
                  @vesselGuid             = @vesselGuid
                , @crossType              = @crossType               -- nvarchar( 5) -- in/out
                , @dspName                = @dspName                 --
                , @actDate                = @actDate
                , @actPositionCode        = @actPositionCode         -- nvarchar(10)
                , @positionTypeCode       = @positionTypeCode        -- nvarchar(10)
                , @actVtsCode             = @actVtsCode 
                , @actZoneCode            = @actZoneCode
                , @actLat                 = @actLat
                , @actLon                 = @actLon
                , @actUserOnWatch         = @OperatorName
                , @newPassGuid            = @newPassGuid output
        end else
        if @dspName = 'Removal'
        begin
            exec atm.CrossLineBorder
                  @vesselGuid             = @vesselGuid
                , @crossType              = @crossType               -- nvarchar( 5) -- in/out
                , @dspName                = @dspName                 --
                , @actDate                = @actDate
                , @actPositionCode        = @actPositionCode         -- nvarchar(10)
                , @positionTypeCode       = @positionTypeCode        -- nvarchar(10)
                , @actVtsCode             = @actVtsCode 
                , @actZoneCode            = @actZoneCode
                , @actLat                 = @actLat
                , @actLon                 = @actLon
                , @actUserOnWatch         = @OperatorName
                , @newPassGuid            = @newPassGuid output
        end 

    end



    print '---'
end
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Sp\10_nav.spAfterPassNew.sql
-- generate order 48
go
create procedure nav.spAfterPassNew @PassGuid uniqueidentifier
as 
begin
    -- �� ���������� ����� �������� ������ �����������
    -- ��� 2019.11.11 - ��������
    
    print '---'
end
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Sp\11_nav.spAfterPassClose.sql
-- generate order 49
go
create procedure nav.spAfterPassClose @PassGuid uniqueidentifier
as
begin
    
    -- �� ���������� ����� �������� ������ �����������
    -- ��� 2019.11.11 - ��������
   -- ���������� ��� �����������    
    Declare --@PassGuid uniqueidentifier = 'F6CF49DF-C7E5-4436-8B21-0000C02FCBE9',
           @StartPositionTypeCode varchar(10) = Null,
           @FinishPositionTypeCode varchar(10) = Null,
           @RecCount int = 0 

    Select @StartPositionTypeCode=P.PositionTypeCode
     from
    (Select PassGuid,row_number() over (partition by PassGuid order by Startdate) rec_num,StartPositionCode
    from nav.Receipt
    where PassGuid=@PassGuid) FR 
    join nsi.Position P on P.PositionCode=FR.StartPositionCode
    where FR.Rec_num=1
    
    Select @FinishPositionTypeCode=P.PositionTypeCode
      from
     (Select PassGuid,row_number() over (partition by PassGuid order by FinishDate desc) rec_num, FinishPositionCode
     from nav.Receipt
     where PassGuid=@PassGuid) LR
     join nsi.Position P on P.PositionCode=LR.FinishPositionCode
      where Rec_num=1
    
    Select @RecCount=count(1) from nav.Receipt where PassGuid=@PassGuid group by PassGuid 

    Update nav.Pass Set PassTypeCode=nav.[fnPassTypeCode](@StartPositionTypeCode, @FinishPositionTypeCode, @RecCount) 
    where PassGuid=@PassGuid
    
    print '---'
end
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Sp\12_nav.spAfterPassRemove.sql
-- generate order 50
go
create procedure nav.spAfterPassRemove @PassGuid uniqueidentifier
as
begin
    
    -- �� ���������� ����� �������� �����������
    -- ��� 2019.11.11 - ��������
    
    print '---'
end
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Sp\13_nav.spAfterPassSave.sql
-- generate order 51
go
create procedure nav.spAfterPassSave @PassGuid uniqueidentifier
as
begin
    
    -- �� ���������� ����� ���������� �����������
    -- ��� 2019.11.11 - ��������

	-- ��� ���������� ��� �����������    
	Declare --@PassGuid uniqueidentifier = 'F6CF49DF-C7E5-4436-8B21-0000C02FCBE9',
           @StartPositionTypeCode varchar(10) = Null,
		   @FinishPositionTypeCode varchar(10) = Null,
		   @RecCount int = 0 

	Select @StartPositionTypeCode=P.PositionTypeCode
	  from
	      (Select PassGuid,row_number() over (partition by PassGuid order by Startdate) rec_num,StartPositionCode
           from nav.Receipt
	       where PassGuid=@PassGuid
		   ) FR 
	  join nsi.Position P on P.PositionCode=FR.StartPositionCode
      where FR.Rec_num=1
	
    Select @FinishPositionTypeCode=P.PositionTypeCode
	  from
          (Select PassGuid,row_number() over (partition by PassGuid order by FinishDate desc) rec_num, FinishPositionCode
	         from nav.Receipt
	        where PassGuid=@PassGuid
	   	  ) LR
	  join nsi.Position P on P.PositionCode=LR.FinishPositionCode
	  where Rec_num=1
	
    Select @RecCount=count(1) from nav.Receipt where PassGuid=@PassGuid group by PassGuid 

    Update nav.Pass Set PassTypeCode=nav.fnPassTypeCode(@StartPositionTypeCode, @FinishPositionTypeCode, @RecCount) 
	where PassGuid=@PassGuid

    print '---'
end
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Sp\14_nav.spAfterReceiptNew.sql
-- generate order 52
go
create procedure nav.spAfterReceiptNew @PassGuid uniqueidentifier
as
begin
    
    -- �� ���������� ����� �������� ����� ���������
    -- ��� 2019.11.11 - ��������
    
    print '---'
end
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\Automation\Sp\15_nav.spAfterReceiptRemove.sql
-- generate order 53
go
create procedure nav.spAfterReceiptRemove @PassGuid uniqueidentifier
as
begin
    
    -- �� ���������� ����� �������� ���������
    -- ��� 2019.11.11 - ��������
    
    print '---'
end
go


/* ------------------------------------------------------------------ */

-- source file M:\mcs_2019\trunk\02_Sql\VtsDb3\PassSp\nav.PassArchiveSelect.sql
-- generate order 54
go
create proc nav.PassArchiveSelect
        @skip        int
      , @take        int
      , @dateFrom    datetime         = null
      , @dateTo      datetime         = null
      , @txtFilter   nvarchar(100)    = null
      , @vtsCode         nvarchar(5)  = null
      , @vtsZoneCode     nvarchar(5)  = null
      , @passFairwayCode nvarchar(10) = null
      , @passDirection   nvarchar(10) = null
      , @vesselGuid      uniqueidentifier = null
      , @countAll   int output
as
begin
    -- МДО, 13.12.2019  хранимка для формы "журнал проводок", изменения должны согласовываться с сервером приложения и UI
    -- declare @dateFrom datetime = '01.04.2019'
    -- declare @dateTo datetime   = '01.11.2019'
    
    if @dateFrom is null
    begin
        set @dateFrom = (select min(StartDate) from nav.Pass);
        set @dateTo = (select max(StartDate) from nav.Pass);
        set @dateTo = dateadd(month, 1, @dateTo);
    end

    declare @passList table (passGuid uniqueidentifier,rowNum bigint)

    if @vesselGuid is null and (@txtFilter is null or len(@txtFilter) = 0)
    begin
        -- фильтров нет, вставляем все данные за временной диапазон
        ;with ps as(
            select PassGuid , row_number() over (order by StartDate desc) AS RowNum
            from nav.Pass 
            where ( 
                (StartDate  between @dateFrom and @dateTo)
             or (FinishDate between @dateFrom and @dateTo and FinishDate is not null)
            ) 
            and (VtsCode           = @vtsCode         or @vtsCode         is null)
            and (VtsZoneCode       = @vtsZoneCode     or @vtsZoneCode     is null)
            and (PassFairwayCode   = @passFairwayCode or @passFairwayCode is null)
            and (PassDirectionCode = @passDirection   or @passDirection   is null)

        )
        insert into @passList (passGuid,rowNum)
        select PassGuid, RowNum
        from ps
        where RowNum between @skip and @skip + @take

        set @countAll = (
            select cast(count(*) as int) 
                from nav.Pass 
                where  (StartDate  between @dateFrom and @dateTo)
                or     (FinishDate between @dateFrom and @dateTo and FinishDate is not null)
            )
    end
    else if @vesselGuid is not null and (@txtFilter is null or len(@txtFilter) = 0)
    begin
        -- если есть код судна и нет текстового фильтра
        ;with ps as(
            select p.PassGuid , row_number() over (order by p.StartDate desc) AS RowNum
            from nav.Pass as p
            join nav.PassVessel as v on v.PassGuid = p.PassGuid
            where ( 
                (p.StartDate  between @dateFrom and @dateTo)
             or (p.FinishDate between @dateFrom and @dateTo and p.FinishDate is not null)
            ) 
            and (VtsCode           = @vtsCode         or @vtsCode         is null)
            and (VtsZoneCode       = @vtsZoneCode     or @vtsZoneCode     is null)
            and (PassFairwayCode   = @passFairwayCode or @passFairwayCode is null)
            and (PassDirectionCode = @passDirection   or @passDirection   is null)
            and v.VesselGuid = @vesselGuid
        )
        insert into @passList (passGuid,rowNum)
        select PassGuid, RowNum
        from ps
        where RowNum between @skip and @skip + @take

    set @countAll = (
        select cast(count(*) as int) 
            from nav.Pass as p
            join nav.PassVessel as v on v.PassGuid = p.PassGuid
            where  ((StartDate  between @dateFrom and @dateTo)
            or     (FinishDate between @dateFrom and @dateTo and FinishDate is not null))
            and (VtsCode           = @vtsCode         or @vtsCode         is null)
            and (VtsZoneCode       = @vtsZoneCode     or @vtsZoneCode     is null)
            and (PassFairwayCode   = @passFairwayCode or @passFairwayCode is null)
            and (PassDirectionCode = @passDirection   or @passDirection   is null)
            and v.VesselGuid = @vesselGuid
        )
    end
    else if (@txtFilter is not null and len(@txtFilter) > 0)
    begin
        -- если есть строковый фильтр
        ;with ps as(
            select p.PassGuid , row_number() over (order by p.StartDate desc) AS RowNum 
            from nav.Pass as p
            join nav.PassVessel as v on v.PassGuid = p.PassGuid
            left join nsi.vLocation as loc1 on loc1.LocationCode = p.DepartureLocationCode
            left join nsi.vLocation as loc2 on loc2.LocationCode = p.DestinationLocationCode
            where ( 
                (p.StartDate  between @dateFrom and @dateTo)
             or (p.FinishDate between @dateFrom and @dateTo and p.FinishDate is not null)
            ) 
            and (VtsCode           = @vtsCode         or @vtsCode         is null)
            and (VtsZoneCode       = @vtsZoneCode     or @vtsZoneCode     is null)
            and (PassFairwayCode   = @passFairwayCode or @passFairwayCode is null)
            and (PassDirectionCode = @passDirection   or @passDirection   is null)
            and (v.VesselGuid      = @vesselGuid      or @vesselGuid      is null)
            and ( 
                 p.PassNumber        like '%'+@txtFilter+'%'
              or v.VesselName        like '%'+@txtFilter+'%'
              or v.VesselNameEn      like '%'+@txtFilter+'%'
              or v.VesselCallSign    like '%'+@txtFilter+'%'
              or v.VesselImo         like '%'+@txtFilter+'%'
              or cast(v.VesselMmsi 
                 as nvarchar(10))    like '%'+@txtFilter+'%'
              or v.VesselNote        like '%'+@txtFilter+'%'
              or loc1.LocationName   like '%'+@txtFilter+'%'
              or loc2.LocationName   like '%'+@txtFilter+'%'
              or p.PassTypeCode      like '%'+@txtFilter+'%'
              or p.VtsCode           like '%'+@txtFilter+'%'
              or p.VtsZoneCode       like '%'+@txtFilter+'%'
              or p.PassDirectionCode like '%'+@txtFilter+'%'
            )
        )
        insert into @passList (passGuid,rowNum)
        select PassGuid, RowNum
        from ps
        where RowNum between @skip and @skip + @take

        set @countAll = (
            select cast(count(*) as int) 
                from nav.Pass as p
                join nav.PassVessel as v on v.PassGuid = p.PassGuid
                left join nsi.vLocation as loc1 on loc1.LocationCode = p.DepartureLocationCode
                left join nsi.vLocation as loc2 on loc2.LocationCode = p.DestinationLocationCode
                where ( 
                    (p.StartDate  between @dateFrom and @dateTo)
                 or (p.FinishDate between @dateFrom and @dateTo and p.FinishDate is not null)
                ) 
                and (VtsCode           = @vtsCode         or @vtsCode         is null)
                and (VtsZoneCode       = @vtsZoneCode     or @vtsZoneCode     is null)
                and (PassFairwayCode   = @passFairwayCode or @passFairwayCode is null)
                and (PassDirectionCode = @passDirection   or @passDirection   is null)
                and (v.VesselGuid      = @vesselGuid      or @vesselGuid      is null)
                and ( 
                     p.PassNumber        like '%'+@txtFilter+'%'
                  or v.VesselName        like '%'+@txtFilter+'%'
                  or v.VesselNameEn      like '%'+@txtFilter+'%'
                  or v.VesselCallSign    like '%'+@txtFilter+'%'
                  or v.VesselImo         like '%'+@txtFilter+'%'
                  or cast(v.VesselMmsi 
                     as nvarchar(10))    like '%'+@txtFilter+'%'
                  or v.VesselNote        like '%'+@txtFilter+'%'
                  or loc1.LocationName   like '%'+@txtFilter+'%'
                  or loc2.LocationName   like '%'+@txtFilter+'%'
                  or p.PassTypeCode      like '%'+@txtFilter+'%'
                  or p.VtsCode           like '%'+@txtFilter+'%'
                  or p.VtsZoneCode       like '%'+@txtFilter+'%'
                  or p.PassDirectionCode like '%'+@txtFilter+'%'
                )
            )
    end


    
   ;with  receiptList as (
        select p.passGuid, r.ReceiptGuid, r.ReceiptNumber
        , r.StartPositionCode, r.FinishPositionCode
        , p1.PositionName      as StartPositionName
        , p1.PositionNameShort as StartPositionNameShort
        , p2.PositionName      as FinishPositionName
        , p2.PositionNameShort as FinishPositionNameShort
        , r.StartDate
        , r.FinishDate
        from nav.Receipt as r 
        join @passList as p on p.passGuid = r.PassGuid
        left join nsi.Position as p1 on p1.PositionCode = r.StartPositionCode
        left join nsi.Position as p2 on p2.PositionCode = r.FinishPositionCode
    )
    -- первый и послений номер квитанции по PassGuid
    , rDateFirst  as ( select PassGuid, min(StartDate ) as Dt from receiptList group by PassGuid )
    , rDateLast   as ( select PassGuid, max(StartDate ) as Dt from receiptList group by PassGuid )
    --превая и последняя квитанции
    , rFirst      as (select r.passGuid, max(r.ReceiptGuid) as ReceiptGuid from receiptList as r join rDateFirst  as a on a.passGuid = r.passGuid and a.Dt = r.StartDate group by r.passGuid)
    , rLast       as (select r.passGuid, max(r.ReceiptGuid) as ReceiptGuid from receiptList as r join rDateLast   as a on a.passGuid = r.passGuid and a.Dt = r.StartDate group by r.passGuid)
    -- в одну строку
    , rFirstAndLast  as (
            select p.passGuid, t1.ReceiptGuid as FirstReceiptGuid, t2.ReceiptGuid as LastReceiptGuid
            from @passList as p
            join rFirst  as t1 on t1.passGuid = p.passGuid
            join rLast as t2 on t2.passGuid = p.passGuid
     )
    select -- top 100
            cast (pl.RowNum as int) as RowNum
          , p.PassGuid
          , p.PassNumber
          , cap.CaptainNameShort
          , p.PilotExemption
          , zn.VtsZoneName
          , p.VtsCode
          , vts.VtsName
          , pt1.LocationName as DepartureLocationName
          , pt2.LocationName as  DestinationLocationName
          , vtp.VoyageTypeName
          , vtp.VoyageTypeNameShort
          , ptp.PassTypeName
          , p.PassFairwayCode
          , pfr.PassFairwayName
          , pfr.PassFairwayNameShort
          , pdr.PassDirectionName
          , pdr.PassDirectionNameShort
          , pop.OperationName
          , vsr.VtsServiceFeCode
          , vsr.VtsServiceName
          , p.StartDate
          , r1.StartPositionName 
         -- , p.StartAppUserGuid
          , us1.AppUserName as StartAppUserName
          , p.StartInitiatorCode
          , p.FinishDate
          , r2.FinishPositionName
          --, p.FinishAppUserGuid
          , us2.AppUserName as FinishAppUserName
          , p.FinishInitiatorCode
          , p.AutoMarkList
          , p.EtaDate
          , p.IsDeleted
          , p.InsertServer
          , p.InsertDate
          , p.UpdateDate
          , pvs.VesselGuid
          , pvs.VesselName
          , pvs.VesselNameEn
          , pvs.VesselImo
          , pvs.VesselMmsi
          , pvs.VesselCallSign
          , pvf.CountryAlpha3Code  as VesselFlagAlpha3Code
          , pvf.CountryName        as VesselFlagName
          , pvf.CountryNameShort   as VesselFlagNameShort
          , pvt.VesselTypeName
          , pvc.CompanyName as OwnerCompanyName
          , pvs.VesselLength
          , pvs.VesselWidth
          , pvs.VesselHeightFull
          , pvs.VesselDraught
        from      @passList as pl
             join rFirstAndLast  as mm on mm.passGuid = pl.passGuid
        left join receiptList as r1 on r1.passGuid = pl.passGuid and r1.ReceiptGuid = mm.FirstReceiptGuid
        left join receiptList as r2 on r2.passGuid = pl.passGuid and r2.ReceiptGuid = mm.LastReceiptGuid
             join nav.Pass          as p  on p.PassGuid             = pl.passGuid
             join nav.PassVessel    as pvs on pvs.PassGuid          = pl.passGuid
        left join nsi.Country       as pvf on pvf.CountryCode       = pvs.FlagCode
        left join nsi.VesselType    as pvt on pvt.VesselTypeCode    = pvs.VesselTypeCode
        left join nsi.Company       as pvc on pvc.CompanyGuid       = pvs.OwnerCompanyGuid        
        left join plt.Captain       as cap  on cap.CaptainGuid      = p.CapitanGuid
        left join nsi.VtsZone       as zn   on zn.VtsZoneCode       = p.VtsZoneCode
        left join nsi.Vts           as vts  on vts.VtsCode          = p.VtsCode
        left join nsi.vLocation     as pt1  on pt1.LocationCode     = p.DepartureLocationCode
        left join nsi.vLocation     as pt2  on pt2.LocationCode     = p.DestinationLocationCode
        left join nsi.VoyageType    as vtp on vtp.VoyageTypeCode    = p.VoyageTypeCode
        left join nsi.PassType      as ptp on ptp.PassTypeCode      = p.PassTypeCode
        left join nsi.PassFairway   as pfr on pfr.PassFairwayCode   = p.PassFairwayCode
        left join nsi.PassDirection as pdr on pdr.PassDirectionCode = p.PassDirectionCode
        left join nsi.Operation     as pop on pop.OperationCode     = p.OperationCode
        left join nsi.VtsService    as vsr on vsr.VtsServiceCode    = p.VtsServiceCode
        left join usr.AppUser       as us1 on us1.AppUserGuid       = p.StartAppUserGuid
        left join usr.AppUser       as us2 on us2.AppUserGuid       = p.FinishAppUserGuid
    --where pl.RowNum between @skip and @skip + @take
    order by pl.RowNum 

    select
        r.ReceiptGuid
        , r.PassGuid
        , r.ReceiptNumber
        , r.ReceiptTypeCode
        , r.StartDate
        , r.FinishDate
        , r.StartPositionCode
        , r.FinishPositionCode
        , us1.AppUserName as StartAppUserName
        , us2.AppUserName as FinishAppUserName
        , p1.PositionName      as StartPositionName
        , p1.PositionNameShort as StartPositionNameShort
        , p2.PositionName      as FinishPositionName
        , p2.PositionNameShort as FinishPositionNameShort

    from @passList as p 
             join nav.Receipt as r on r.PassGuid = p.passGuid
        left join usr.AppUser       as us1 on us1.AppUserGuid       = r.StartAppUserGuid
        left join usr.AppUser       as us2 on us2.AppUserGuid       = r.FinishAppUserGuid
        left join nsi.Position      as p1 on p1.PositionCode = r.StartPositionCode
        left join nsi.Position      as p2 on p2.PositionCode = r.FinishPositionCode
    
end

go

go

