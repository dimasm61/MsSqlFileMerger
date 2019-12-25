if exists (select 1 from  sysobjects where  id = object_id('nsi.vPort') and   type = 'V') drop view nsi.vPort


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