-----------------------------------------------------------------------------------------------
-- Battery By Model
CREATE VIEW vwBatteryByModel  
AS  
SELECT modelBattery.model_id,   
  STRING_AGG( CAST(charging as NVARCHAR(20)),',') as ChargingSpeeds,  
  STRING_AGG( CAST(wirelessCharging as NVARCHAR(20)),',') as WirelessChargingSpeeds,  
  STRING_AGG( CAST(size as NVARCHAR(20)),',') as Sizes  
FROM modelBattery  
LEFT OUTER JOIN Battery  
ON modelBattery.battery_id = Battery.id  
GROUP BY modelBattery.model_id  

-----------------------------------------------------------------------------------------------
-- Battery By Model
ALTER VIEW vwBodyByModel  
AS  
SELECT modelBody.model_id,   
  dbo.hasFeature(SUM(CAST(Body.keyboard as INT)),'Yes') as Keyboard,  
  STRING_AGG( CONCAT('(',Body.width,'x',Body.height,'x',Body.thickness,')') ,',') as Sizes,  
  STRING_AGG( Body.ipCertificate, ',') as ipCertificates,  
  STRING_AGG( Body.backMaterial, ',' ) as BackMaterials,  
  STRING_AGG( Body.frontMaterial, ',' ) as FrontMaterials  
FROM modelBody  
LEFT OUTER JOIN Body  
ON modelBody.body_id = Body.id  
GROUP BY modelBody.model_id

-----------------------------------------------------------------------------------------------
-- Comms By Model
ALTER VIEW vwCommsByModel  
AS  
SELECT modelComms.model_id,  
  STRING_AGG(Comms.bluetooth, ',') as Bluetooth,  
  STRING_AGG(Comms.WLAN, ',') as WLAN,  
  dbo.hasFeature(SUM(CAST(Comms.Radio as INT)),'Yes') as Radio,  
  STRING_AGG(Comms.USB, ',') as USBs,  
  STRING_AGG(Comms.GPS, ',') as GPSs,  
  dbo.hasFeature(SUM(CAST(Comms.NFC as INT)),'Yes') as NFC  
FROM modelComms  
LEFT OUTER JOIN Comms  
ON modelComms.model_id = Comms.id  
GROUP BY modelComms.model_id  

-----------------------------------------------------------------------------------------------
-- Display By Model
CREATE VIEW vwDisplayByModel  
AS  
SELECT modelDisplay.model_id,  
  dbo.hasFeature(SUM(CAST(Display.touchscreen as INT)),'Yes') AS Touchscreen,  
  dbo.hasFeature(SUM(CAST(Display.refreshRate as INT)),'Yes') AS RefreshRate,  
  STRING_AGG(Display.technology,',') AS Technology,  
  STRING_AGG(Display.resolution,',') AS Resolution,  
  STRING_AGG(Display.notch,',') AS Notches  
FROM modelDisplay  
LEFT OUTER JOIN Display  
ON modelDisplay.model_id = Display.id  
GROUP BY modelDisplay.model_id  

-----------------------------------------------------------------------------------------------
-- Model and Series
CREATE VIEW vwModelAndSeries  
AS  
SELECT Model.id,  
  Model.name,  
  Model.releaseDate,  
  Model.releasePrice,  
  Model.model,  
  vwSeriesAndCompany.SeriesName,   
  vwSeriesAndCompany.CompanyName,  
  vwSeriesAndCompany.CompanyLogo  
FROM Model  
LEFT JOIN vwSeriesAndCompany  
ON Model.series_id = vwSeriesAndCompany.id

-----------------------------------------------------------------------------------------------
-- Platform By Model
CREATE VIEW vwPlatformsByModel  
AS  
SELECT modelPlatform.model_id,  
  STRING_AGG(Platform.OS,',') as OSs,  
  STRING_AGG(Platform.CPU,',') as CPUSs,  
  STRING_AGG(Platform.GPU,',') as GPUs,  
  STRING_AGG(Platform.chipset,',') as Chipsets  
FROM modelPlatform  
RIGHT OUTER JOIN Platform  
ON modelPlatform.platform_id = Platform.id  
GROUP BY modelPlatform.model_id  

----------------------------------------------------------------------------------------------
-- Network By Model
CREATE VIEW vwNetworkByModel
AS
SELECT	modelNetwork.model_id,
		dbo.hasFeature(SUM(CAST([2gBand] as INT)),'Yes') AS [2G],
		dbo.hasFeature(SUM(CAST([3gBand] as INT)),'Yes') AS [3G],
		dbo.hasFeature(SUM(CAST([4gBand] as INT)),'Yes') AS [4G],
		dbo.hasFeature(SUM(CAST([5gBand] as INT)),'Yes') AS [5G],
		STRING_AGG ( speedmin, ',' ) AS SpeedMin,
		STRING_AGG ( speedmax, ',') AS SpeedMax
FROM modelNetwork
LEFT OUTER JOIN Network
ON modelNetwork.model_id = Network.id
GROUP BY modelNetwork.model_id

-----------------------------------------------------------------------------------------------
-- Sensor By Model
CREATE VIEW vwSensorByModel
AS
SELECT	modelSensor.model_id,
		STRING_AGG(Sensor.Fingerprint, ',') AS Fingerprint,
		dbo.hasFeature(SUM(CAST(Sensor.Gyroscope as INT)),'Yes') AS Gyroscope,
		dbo.hasFeature(SUM(CAST(Sensor.Proximity as INT)),'Yes') AS Proximity,
		dbo.hasFeature(SUM(CAST(Sensor.HeatRate as INT)),'Yes') AS Barometer
FROM modelSensor
LEFT OUTER JOIN Sensor
ON modelSensor.model_id = Sensor.id
GROUP BY modelSensor.model_id

-----------------------------------------------------------------------------------------------
-- Sim By Model
CREATE VIEW vwSimByModel
AS
SELECT modelSim.model_id, STRING_AGG(Sim.size, ',') as SimSizes
FROM modelSim
LEFT OUTER JOIN Sim
ON modelSim.model_id = Sim.id
GROUP BY modelSim.model_id

-----------------------------------------------------------------------------------------------
-- Sound By Model
CREATE VIEW vwSoundByModel
AS
SELECT	modelSound.model_id, 
		STRING_AGG(Sound.loudspeaker, ',') as Loudspeaker,
		dbo.hasFeature(SUM(CAST(Sound.jack as INT)),'Yes') AS AudioJack,
		STRING_AGG(Sound.other, ',') as OtherSound
FROM modelSound
LEFT OUTER JOIN Sound
ON modelSound.model_id = Sound.id
GROUP BY modelSound.model_id

-----------------------------------------------------------------------------------------------
-- Display By Model
CREATE VIEW vwDisplayByModel
AS
SELECT	modelDisplay.model_id,
		dbo.hasFeature(SUM(CAST(Display.touchscreen as INT)),'Yes') AS Touchscreen,
		dbo.hasFeature(SUM(CAST(Display.refreshRate as INT)),'Yes') AS RefreshRate,
		STRING_AGG(Display.technology,',') AS Technology,
		STRING_AGG(Display.resolution,',') AS Resolution,
		STRING_AGG(Display.notch,',') AS Notches
FROM modelDisplay
LEFT OUTER JOIN Display
ON modelDisplay.model_id = Display.id
GROUP BY modelDisplay.model_id


-----------------------------------------------------------------------------------------------
-- Series and models
CREATE VIEW vwModelAndSeries
AS
SELECT	Model.id,
		Model.name,
		Model.releaseDate,
		Model.releasePrice,
		Model.numReleased,
		Model.model,
		vwSeriesAndCompany.SeriesName,
		vwSeriesAndCompany.CompanyName,
		vwSeriesAndCompany.CompanyLogo
FROM Model
LEFT OUTER JOIN vwSeriesAndCompany
ON Model.series_id =vwSeriesAndCompany.id

-----------------------------------------------------------------------------------------------
-- Joined View


