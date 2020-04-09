USE PHONEDB;
GO
​
DROP TABLE IF EXISTS modelNetwork;
DROP TABLE IF EXISTS modelDisplay;
DROP TABLE IF EXISTS modelPlatform;
DROP TABLE IF EXISTS modelSound;
DROP TABLE IF EXISTS modelComms;
DROP TABLE IF EXISTS modelSim;
DROP TABLE IF EXISTS modelBody;
DROP TABLE IF EXISTS modelSensor;
DROP TABLE IF EXISTS modelBattery;
DROP TABLE IF EXISTS Model;
DROP TABLE IF EXISTS Series;
DROP TABLE IF EXISTS Company;
DROP TABLE IF EXISTS Display;
DROP TABLE IF EXISTS Network;
DROP TABLE IF EXISTS Network;
DROP TABLE IF EXISTS PlatForm;
DROP TABLE IF EXISTS Sound;
DROP TABLE IF EXISTS Comms;
DROP TABLE IF EXISTS Battery;
DROP TABLE IF EXISTS Sensor;
DROP TABLE IF EXISTS Body;
DROP TABLE IF EXISTS Sim;
GO
----------------------------------------------------------------------------------------
-- CREATE FEATURE TABLES
CREATE TABLE [Company] (
  [Id] INT IDENTITY(1,1),
  [Name] VARCHAR(50) NOT NULL,
  [Logo] VARCHAR(50) NOT NULL,

  CONSTRAINT PK_Company PRIMARY KEY ([Id]),
  CONSTRAINT UQ_Company UNIQUE (Name,Logo)
);
GO
​
CREATE TABLE [Series] (
  [Id] INT IDENTITY(1,1),
  [Name] VARCHAR(50) NOT NULL,
  [Company_id] INT,
  CONSTRAINT PK_Series PRIMARY KEY ([Id]),
  CONSTRAINT FK_SeriesCompany FOREIGN KEY ([Company_id]) REFERENCES Company([Id]),
  CONSTRAINT UC_Series UNIQUE ([Company_id], [Name]),
  CONSTRAINT UQ_Series UNIQUE (Name, Company_id)
);
GO
​
CREATE TABLE [Model] (
  [Id] INT IDENTITY(1,1),
  [Name] VARCHAR(50) NOT NULL,
  [ReleaseDate] DATE ,
  [ReleasePrice] DECIMAL,
  [NumReleased] INT CHECK (NumReleased > 0),
  [Model] VARCHAR(50) NOT NULL,
  [Series_id] INT,
  CONSTRAINT PK_Model PRIMARY KEY ([id]),
  CONSTRAINT FK_ModelSeries FOREIGN KEY (series_id) REFERENCES Series(id),
  CONSTRAINT UQ_Model UNIQUE ([Series_id], [Name])
);
GO
​
​
CREATE TABLE [Comms] (
  [Id] INT IDENTITY(1,1),
  [Bluetooth] VARCHAR(50),
  [WLAN] VARCHAR(50),
  [Radio] BIT NOT NULL,
  [USB] VARCHAR(50),
  [GPS] VARCHAR(50),
  [NFC] BIT NOT NULL,
  CONSTRAINT PK_Comms PRIMARY KEY ([Id]),
  CONSTRAINT UQ_Comms UNIQUE (Bluetooth,WLAN,Radio,USB,GPS,NFC)
);
GO
​
CREATE TABLE [Sound] (
  [Id] INT IDENTITY(1,1),
  [Loudspeaker] VARCHAR(50),
  [Jack] BIT,
  [Other] NVARCHAR(50),
  CONSTRAINT PK_Sound PRIMARY KEY ([id]),
  CONSTRAINT UQ_Sound UNIQUE (Loudspeaker,Jack,Other)
);
GO
​
CREATE TABLE [Sensor] (
  [id] INT IDENTITY(1,1),
  [Fingerprint] NVARCHAR(50),
  [Accelerometer] BIT,
  [Gyroscope] BIT,
  [Proximity] BIT,
  [Barometer] BIT,
  [HeatRate] BIT,

  CONSTRAINT PK_Sensor PRIMARY KEY ([Id]),
  CONSTRAINT UQ_Sensor UNIQUE (Fingerprint, Accelerometer, Gyroscope, Proximity, Barometer, HeatRate)
);
GO
​
CREATE TABLE [Battery] (
  [Id] INT IDENTITY(1,1),
  [Charging] INT NOT NULL CHECK( Charging > 0),
  [WirelessCharging] INT NOT NULL CHECK (WirelessCharging >= 0),
  [Size] INT NOT NULL CHECK (Size > 0),
  CONSTRAINT PK_Battry PRIMARY KEY ([Id]),
  CONSTRAINT UQ_Battery UNIQUE (Charging, WirelessCharging,Size)
);
GO
​
CREATE TABLE [Sim] (
  [Id] INT IDENTITY(1,1),
  [Size] VARCHAR(50),
  [Multiple] INT NOT NULL CHECK (Multiple > 0),
  CONSTRAINT PK_Sim PRIMARY KEY ([Id]),
  CONSTRAINT UQ_Sim UNIQUE (Size,Multiple)
);
GO
​
CREATE TABLE [Network] (
  [Id] INT IDENTITY(1,1),
  [2gBand] BIT DEFAULT 0,
  [3gBand] BIT DEFAULT 0,
  [4gBand] BIT DEFAULT 0,
  [5gBand] BIT DEFAULT 0,
  [SpeedMax] INT NOT NULL,
  [SpeedMin] INT NOT NULL,
  CONSTRAINT PK_Network PRIMARY KEY ([id]),
  CONSTRAINT UQ_Network UNIQUE ( [2gBand],[3gBand],[4gBand],[5gBand],SpeedMax,SpeedMin)
);
GO
​
CREATE TABLE [Platform] (
  [Id] INT IDENTITY(1,1),
  [OS] VARCHAR(50) NOT NULL,
  [CPU] VARCHAR(50) NOT NULL,
  [GPU] VARCHAR(50),
  [Chipset] VARCHAR(50),
  CONSTRAINT PK_Platform PRIMARY KEY ([id]),
  CONSTRAINT UQ_Platform UNIQUE (OS,CPU,GPU,Chipset)
);
GO
​
CREATE TABLE [Body] (
  [Id] INT IDENTITY(1,1),
  [FormFactor] VARCHAR(50) NOT NULL ,
  [Keyboard] BIT DEFAULT 0,
  [Height] INT CHECK (height > 0),
  [Width] INT CHECK (width > 0),
  [Thickness] INT CHECK (thickness > 0),
  [IPCertificate] VARCHAR(50),
  [BackMaterial] VARCHAR(50) NOT NULL,
  [FrontMaterial] VARCHAR(50) NOT NULL,
  CONSTRAINT PK_Body PRIMARY KEY ([Id]),
  CONSTRAINT UQ_Body UNIQUE (FormFactor,Keyboard,Height,Width,Thickness,IPCertificate,BackMaterial,FrontMaterial)
);
GO
​
CREATE TABLE [Display] (
  [Id] INT IDENTITY(1,1),
  [Size] DECIMAL CHECK (size > 0),
  [Touchscreen] BIT DEFAULT 0,
  [RefreshRate] BIT DEFAULT 0,
  [Technology] VARCHAR(50) NOT NULL,
  [Resolution] VARCHAR(50) NOT NULL,
  [Notch] VARCHAR(50) NOT NULL,
  CONSTRAINT PK_Display PRIMARY KEY ([Id]),
  CONSTRAINT UQ_Display UNIQUE (Size, Touchscreen, RefreshRate,Technology,Resolution,Notch)
);
GO
----------------------------------------------------------------------------------------
-- CREATE FEATURE TABLES
​
CREATE TABLE [modelSound] (
  [model_id] INT,
  [sound_id] INT,
  CONSTRAINT PK_modelSound PRIMARY KEY (model_id, sound_id),
  CONSTRAINT FK_SoundModel FOREIGN KEY (sound_id) REFERENCES Sound(id),
  CONSTRAINT FK_ModelSound FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO
​
CREATE TABLE [modelBody] (
  [model_id] INT,
  [body_id] INT,
  CONSTRAINT PK_modelBody PRIMARY KEY (model_id,body_id),
  CONSTRAINT FK_BodyModel FOREIGN KEY (body_id) REFERENCES Body(id),
  CONSTRAINT FK_ModelBody FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO
​
CREATE TABLE [modelPlatform] (
  [model_id] INT,
  [platform_id] INT,
  CONSTRAINT PK_modelPlatform PRIMARY KEY ( model_id, platform_id),
  CONSTRAINT FK_PlatformModel FOREIGN KEY (platform_id) REFERENCES Platform(id),
  CONSTRAINT FK_ModelPlatform FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO
​
CREATE TABLE [modelDisplay] (
  [model_id] INT,
  [display_id] INT,
  CONSTRAINT PK_modelDisplay PRIMARY KEY (model_id,display_id),
  CONSTRAINT FK_DisplayModel FOREIGN KEY (display_id) REFERENCES Display(id),
  CONSTRAINT FK_ModelDisplay FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO
​
CREATE TABLE [modelBattery] (
  [model_id] INT,
  [battery_id] INT,
  CONSTRAINT PK_modelBattery PRIMARY KEY (model_id, battery_id),
  CONSTRAINT FK_BatteryModel FOREIGN KEY (battery_id) REFERENCES Battery(id),
  CONSTRAINT FK_ModelBattery FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO
​
CREATE TABLE [modelSensor] (
  [model_id] INT,
  [sensor_id] INT,
  CONSTRAINT PK_modelSensor PRIMARY KEY (model_id,sensor_id),
  CONSTRAINT FK_SensorModel FOREIGN KEY (sensor_id) REFERENCES Sensor(id),
  CONSTRAINT FK_ModelSensor FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO
​
CREATE TABLE [modelSim] (
  [model_id] INT,
  [sim_id] INT,
  CONSTRAINT PK_modelSim PRIMARY KEY (model_id,sim_id),
  CONSTRAINT FK_SimModel FOREIGN KEY (sim_id) REFERENCES Sim(id),
  CONSTRAINT FK_ModelSim FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO
​
CREATE TABLE [modelComms] (
  [model_id] INT,
  [comms_id] INT,
  CONSTRAINT PK_modelComms PRIMARY KEY (model_id, comms_id),
  CONSTRAINT FK_CommsModel FOREIGN KEY (comms_id) REFERENCES Comms(id),
  CONSTRAINT FK_ModelComms FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO
​
CREATE TABLE [modelNetwork] (
  [model_id] INT,
  [network_id] INT,
  CONSTRAINT PK_modelNetwork PRIMARY KEY (model_id, network_id),
  CONSTRAINT FK_NetworkModel FOREIGN KEY (network_id) REFERENCES Network(id),
  CONSTRAINT FK_ModelNetwork FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO