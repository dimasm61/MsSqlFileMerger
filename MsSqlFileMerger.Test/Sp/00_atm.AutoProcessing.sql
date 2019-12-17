use VtsDb3
go

if exists (select 1 from sysobjects where id = object_id('atm.AutoProcessing')and type in ('P','PC'))  drop procedure atm.AutoProcessing


go
create procedure atm.AutoProcessing
 
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


    -- 
    declare @secondDiff    int        
    declare @crossType     nvarchar( 5)
    declare @dspName       nvarchar(20)

    exec atm.AutoLineCross
      @vesselGuid       = @Vessel_GUID            -- uniqueidentif 
    , @position         = @Position               -- uniqueidentif 
    , @crossDate        = @RecordTime             -- datetime      
    , @secondDiff       = @secondDiff       output -- int          
    , @crossType        = @crossType        output -- nvarchar( 5) 
    , @positionCode     = @actPositionCode  output -- nvarchar(10) 
    , @positionTypeCode = @positionTypeCode output -- nvarchar(10) 
    , @dspName          = @dspName          output -- nvarchar(20) 

    -- нет пересечения второй линии, выходим
    if @crossType is null return;

    if @secondDiff < 100 return;

    --------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------

    -- локальная дата время из UTC
    set @actDate = dateadd(hour, datediff(hour, getutcdate(), getdate()), @RecordTime) ;

    -- координаты транзаса переводим в широту/долготу
    set @actLat = case when  ( @GeoCoordinates - floor ( @GeoCoordinates / 4294967296 ) * 4294967296 ) > 2147483648 
            then convert ( float, - ( 4294967296 - ( @GeoCoordinates - floor ( @GeoCoordinates / 4294967296 ) * 4294967296 ) ) ) 
            else convert ( float, ( @GeoCoordinates - floor ( @GeoCoordinates / 4294967296 ) * 4294967296 ) ) 
        end;

    set @actLon = case when floor ( @GeoCoordinates / 4294967296 ) > 2147483648 
            then convert ( float, - ( 4294967296 - floor ( @GeoCoordinates / 4294967296 ) ) ) 
            else convert ( float, floor ( @GeoCoordinates / 4294967296 ) ) 
        end;


    declare @vesselGuid uniqueidentifier

 
    set @vesselGuid = @vessel_Guid;

    --------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------

    declare @newPassGuid uniqueidentifier

    -- произошло пересечение второй линии, то есть счи

	set @actVtsCode   = '';

 
    select @actZoneCode=isNull(p.VtsZoneCode,'')
    from vtsdb.dbo.Positions as tp
    left join vtsdb3.nsi.Position as p on p.PositionCode = tp.ISOBMPositionCode
    where tp.Uid = @Position;

/* 
   
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
	  --and (not p.StartDate is null and abs(Datediff(minute, @actDate,p.StartDate))>30); -- стратовал не более получаса назад (если ранее то считается устаревшим)
 

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
    begin  
        exec atm.CrossEventLine
              @crossType              = @crossType             -- nvarchar( 5) -- in/out
            , @dspName                = @dspName               --
            , @actPositionCode        = @actPositionCode       -- nvarchar(10)
            , @positionTypeCode       = @positionTypeCode    -- nvarchar(10)
    end

    begin 
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
