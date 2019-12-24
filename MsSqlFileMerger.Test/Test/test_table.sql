create table table1(
 col1 int
)
go
-----------------------
USE [VTSDB3]
GO

/****** Object:  Table [nav].[Pass]    Script Date: 24.12.2019 14:31:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [nav].[Pass](
	[PassGuid] [uniqueidentifier] NOT NULL,
	[PassNumber] [nvarchar](10) NOT NULL,
	[VesselGuid] [uniqueidentifier] NULL,
	[CapitanGuid] [uniqueidentifier] NULL,
	[PilotExemption] [bit] NULL,
	[VtsZoneCode] [varchar](2) NULL,
	[VtsCode] [varchar](2) NULL,
	[DepartureLocationCode] [varchar](5) NULL,
	[DestinationLocationCode] [varchar](5) NULL,
	[VoyageTypeCode] [varchar](2) NULL,
	[PassTypeCode] [varchar](3) NULL,
	[PassFairwayCode] [varchar](3) NULL,
	[PassDirectionCode] [varchar](10) NULL,
	[OperationCode] [varchar](5) NULL,
	[VtsServiceCode] [varchar](5) NULL,
	[PassAlertCodeList] [nvarchar](100) NULL,
	[PassComment] [nvarchar](200) NULL,
	[StartDate] [datetime] NULL,
	[StartAppUserGuid] [uniqueidentifier] NULL,
	[StartInitiatorCode] [varchar](7) NULL,
	[FinishDate] [datetime] NULL,
	[FinishAppUserGuid] [uniqueidentifier] NULL,
	[FinishInitiatorCode] [varchar](7) NULL,
	[AutoMarkList] [nvarchar](255) NULL,
	[IsDeleted] [bit] NULL,
	[InsertServer] [nvarchar](10) NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[EtaDate] [datetime] NULL,
	[VtsZoneSubCodeList] [nvarchar](100) NULL,
 CONSTRAINT [PK_PASS] PRIMARY KEY CLUSTERED 
(
	[PassGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [nav].[Pass]  WITH CHECK ADD  CONSTRAINT [FK_PASS_REFERENCE_APPUSER1] FOREIGN KEY([FinishAppUserGuid])
REFERENCES [usr].[AppUser] ([AppUserGuid])
GO

ALTER TABLE [nav].[Pass] CHECK CONSTRAINT [FK_PASS_REFERENCE_APPUSER1]
GO

ALTER TABLE [nav].[Pass]  WITH CHECK ADD  CONSTRAINT [FK_PASS_REFERENCE_APPUSER2] FOREIGN KEY([StartAppUserGuid])
REFERENCES [usr].[AppUser] ([AppUserGuid])
GO

ALTER TABLE [nav].[Pass] CHECK CONSTRAINT [FK_PASS_REFERENCE_APPUSER2]
GO

ALTER TABLE [nav].[Pass]  WITH CHECK ADD  CONSTRAINT [FK_PASS_REFERENCE_CAPTAIN] FOREIGN KEY([CapitanGuid])
REFERENCES [plt].[Captain] ([CaptainGuid])
GO

ALTER TABLE [nav].[Pass] CHECK CONSTRAINT [FK_PASS_REFERENCE_CAPTAIN]
GO

ALTER TABLE [nav].[Pass]  WITH CHECK ADD  CONSTRAINT [FK_PASS_REFERENCE_INITIATO1] FOREIGN KEY([StartInitiatorCode])
REFERENCES [nsi].[Initiator] ([InitiatorCode])
GO

ALTER TABLE [nav].[Pass] CHECK CONSTRAINT [FK_PASS_REFERENCE_INITIATO1]
GO

ALTER TABLE [nav].[Pass]  WITH CHECK ADD  CONSTRAINT [FK_PASS_REFERENCE_INITIATO2] FOREIGN KEY([FinishInitiatorCode])
REFERENCES [nsi].[Initiator] ([InitiatorCode])
GO

ALTER TABLE [nav].[Pass] CHECK CONSTRAINT [FK_PASS_REFERENCE_INITIATO2]
GO

ALTER TABLE [nav].[Pass]  WITH CHECK ADD  CONSTRAINT [FK_PASS_REFERENCE_LOCATION1] FOREIGN KEY([DepartureLocationCode])
REFERENCES [nsi].[Location] ([LocationCode])
GO

ALTER TABLE [nav].[Pass] CHECK CONSTRAINT [FK_PASS_REFERENCE_LOCATION1]
GO

ALTER TABLE [nav].[Pass]  WITH CHECK ADD  CONSTRAINT [FK_PASS_REFERENCE_LOCATION2] FOREIGN KEY([DestinationLocationCode])
REFERENCES [nsi].[Location] ([LocationCode])
GO

ALTER TABLE [nav].[Pass] CHECK CONSTRAINT [FK_PASS_REFERENCE_LOCATION2]
GO

ALTER TABLE [nav].[Pass]  WITH CHECK ADD  CONSTRAINT [FK_PASS_REFERENCE_OPERATIO] FOREIGN KEY([OperationCode])
REFERENCES [nsi].[Operation] ([OperationCode])
GO

ALTER TABLE [nav].[Pass] CHECK CONSTRAINT [FK_PASS_REFERENCE_OPERATIO]
GO

ALTER TABLE [nav].[Pass]  WITH CHECK ADD  CONSTRAINT [FK_PASS_REFERENCE_PASSDIRE] FOREIGN KEY([PassDirectionCode])
REFERENCES [nsi].[PassDirection] ([PassDirectionCode])
GO

ALTER TABLE [nav].[Pass] CHECK CONSTRAINT [FK_PASS_REFERENCE_PASSDIRE]
GO

ALTER TABLE [nav].[Pass]  WITH CHECK ADD  CONSTRAINT [FK_PASS_REFERENCE_PASSFAIR] FOREIGN KEY([PassFairwayCode])
REFERENCES [nsi].[PassFairway] ([PassFairwayCode])
GO

ALTER TABLE [nav].[Pass] CHECK CONSTRAINT [FK_PASS_REFERENCE_PASSFAIR]
GO

ALTER TABLE [nav].[Pass]  WITH CHECK ADD  CONSTRAINT [FK_PASS_REFERENCE_PASSTYPE] FOREIGN KEY([PassTypeCode])
REFERENCES [nsi].[PassType] ([PassTypeCode])
GO

ALTER TABLE [nav].[Pass] CHECK CONSTRAINT [FK_PASS_REFERENCE_PASSTYPE]
GO

ALTER TABLE [nav].[Pass]  WITH CHECK ADD  CONSTRAINT [FK_PASS_REFERENCE_VESSEL] FOREIGN KEY([VesselGuid])
REFERENCES [nsi].[Vessel] ([VesselGuid])
GO

ALTER TABLE [nav].[Pass] CHECK CONSTRAINT [FK_PASS_REFERENCE_VESSEL]
GO

ALTER TABLE [nav].[Pass]  WITH CHECK ADD  CONSTRAINT [FK_PASS_REFERENCE_VOYAGETY] FOREIGN KEY([VoyageTypeCode])
REFERENCES [nsi].[VoyageType] ([VoyageTypeCode])
GO

ALTER TABLE [nav].[Pass] CHECK CONSTRAINT [FK_PASS_REFERENCE_VOYAGETY]
GO

ALTER TABLE [nav].[Pass]  WITH CHECK ADD  CONSTRAINT [FK_PASS_REFERENCE_VTS] FOREIGN KEY([VtsCode])
REFERENCES [nsi].[Vts] ([VtsCode])
GO

ALTER TABLE [nav].[Pass] CHECK CONSTRAINT [FK_PASS_REFERENCE_VTS]
GO

ALTER TABLE [nav].[Pass]  WITH CHECK ADD  CONSTRAINT [FK_PASS_REFERENCE_VTSSERVI] FOREIGN KEY([VtsServiceCode])
REFERENCES [nsi].[VtsService] ([VtsServiceCode])
GO

ALTER TABLE [nav].[Pass] CHECK CONSTRAINT [FK_PASS_REFERENCE_VTSSERVI]
GO

ALTER TABLE [nav].[Pass]  WITH CHECK ADD  CONSTRAINT [FK_PASS_REFERENCE_VTSZONE] FOREIGN KEY([VtsZoneCode])
REFERENCES [nsi].[VtsZone] ([VtsZoneCode])
GO

ALTER TABLE [nav].[Pass] CHECK CONSTRAINT [FK_PASS_REFERENCE_VTSZONE]
GO
---------------------------------------------

