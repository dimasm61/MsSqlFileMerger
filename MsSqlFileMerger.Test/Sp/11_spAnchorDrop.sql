USE [VTSDB3]
GO

if exists(select 1 from sys.all_objects where type='P' and name = 'spAnchorDrop' and schema_id in (select schema_id from sys.schemas where name='atm'))
	DROP PROCEDURE [atm].[spAnchorDrop]
GO

/****** Object:  StoredProcedure [atm].[spAnchorDrop]    Script Date: 13.03.2020 14:08:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [atm].[spAnchorDrop]
      @actDate                datetime
    , @actPositionCode        varchar(10)

as
begin
 
    print 1
end

GO
