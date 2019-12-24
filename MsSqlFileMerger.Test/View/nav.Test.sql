alter view nav.vActPass as
    -- МДО13.12.2019 представлениедляподсистемыCollaborationDesk (CoDesk), изменениядолжнысогласовыватьсяссерверомприложенияиUI
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