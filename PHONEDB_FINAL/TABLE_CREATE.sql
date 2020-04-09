USE [PHONEDB]
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
​
CREATE TABLE [Company] (
  [id] BIGINT IDENTITY(1,1),
  [name] VARCHAR(50) NOT NULL,
  [logo] VARCHAR(150) NOT NULL,
  CONSTRAINT PK_Company PRIMARY KEY ([id])
);
GO
​
CREATE TABLE [Series] (
  [id] BIGINT IDENTITY(1,1),
  [name] VARCHAR(50) NOT NULL,
  [company_id] BIGINT NOT NULL,
  CONSTRAINT PK_Series PRIMARY KEY ([id]),
  CONSTRAINT FK_SeriesCompany FOREIGN KEY ([company_id]) REFERENCES Company([id]),
  CONSTRAINT UC_Series UNIQUE ([company_id], [name])
);
GO
​
CREATE TABLE [Model] (
  [id] BIGINT IDENTITY(1,1),
  [name] VARCHAR(50) NOT NULL,
  [releaseDate] DATE ,
  [releasePrice] DECIMAL(18,2),
  [numReleased] INT CHECK (numReleased > 0),
  [numSim] INT CHECK (numSim >= 0),
  [model] VARCHAR(50) NOT NULL,
  [series_id] BIGINT NOT NULL,
  CONSTRAINT PK_Model PRIMARY KEY ([id]),
  CONSTRAINT FK_ModelSeries FOREIGN KEY (series_id) REFERENCES Series(id),
  CONSTRAINT UC_Model UNIQUE ([series_id], [name])
);
GO
​
​
CREATE TABLE [Comms] (
  [id] BIGINT IDENTITY(1,1),
  [bluetooth] VARCHAR(50),
  [WLAN] VARCHAR(50),
  [Radio] BIT NOT NULL,
  [USB] VARCHAR(50),
  [GPS] VARCHAR(50),
  [NFC] BIT NOT NULL,
  CONSTRAINT PK_Comms PRIMARY KEY ([id]),
  CONSTRAINT UC_Comms UNIQUE (bluetooth, WLAN, Radio, USB, GPS, NFC)
);
GO
​
CREATE TABLE [Sound] (
  [id] BIGINT IDENTITY(1,1),
  [loudspeaker] VARCHAR(50),
  [jack] BIT,
  [other] VARCHAR(50),
  CONSTRAINT PK_Sound PRIMARY KEY ([id]),
  CONSTRAINT UC_Sound UNIQUE (loudspeaker, jack, other)
);
GO
​
CREATE TABLE [Sensor] (
  [id] BIGINT IDENTITY(1,1),
  [Fingerprint] NVARCHAR(50),
  [Accelerometer] BIT,
  [Gyroscope] BIT,
  [Proximity] BIT,
  [Barometer] BIT,
  [HeartRate] BIT,
  CONSTRAINT PK_Sensor PRIMARY KEY ([id]),
  CONSTRAINT UC_Sensor UNIQUE (Fingerprint, Accelerometer, Gyroscope, Proximity, Barometer, HeartRate)
);
GO
​
CREATE TABLE [Battery] (
  [id] BIGINT IDENTITY(1,1),
  [charging] DECIMAL(10,2) NOT NULL CHECK( charging > 0),
  [wirelessCharging] BIT DEFAULT 0 CHECK (wirelessCharging >= 0),
  [size] INT NOT NULL CHECK (size > 0),
  CONSTRAINT PK_Battery PRIMARY KEY ([id]),
  CONSTRAINT UC_Battery UNIQUE (charging, wirelessCharging, size)
);
GO
​
CREATE TABLE [Sim] (
  [id] BIGINT IDENTITY(1,1),
  [size] VARCHAR(50) NOT NULL UNIQUE,
  CONSTRAINT PK_Sim PRIMARY KEY ([id]),
);
GO
​
CREATE TABLE [Network] (
  [id] BIGINT IDENTITY(1,1),
  [2gBand] BIT DEFAULT 0,
  [3gBand] BIT DEFAULT 0,
  [4gBand] BIT DEFAULT 0,
  [5gBand] BIT DEFAULT 0,
  [speedmax] DECIMAL(10,2) NOT NULL,
  [speedmin] DECIMAL(10,2) NOT NULL,
  CONSTRAINT PK_Network PRIMARY KEY ([id]),
  CHECK( speedmax > speedmin),
  CHECK( speedmin < speedmax),
  CONSTRAINT UC_Network UNIQUE ([2gBand], [3gBand], [4gBand], [5gBand], speedmax, speedmin)
);
GO
​
CREATE TABLE [Platform] (
  [id] BIGINT IDENTITY(1,1),
  [OS] VARCHAR(100) NOT NULL,
  [CPU] VARCHAR(100) NOT NULL,
  [GPU] VARCHAR(100),
  [chipset] VARCHAR(100),
  CONSTRAINT PK_Platform PRIMARY KEY ([id]),
  CONSTRAINT UC_Platform UNIQUE (OS, CPU, GPU, chipset)
);
GO
​
CREATE TABLE [Body] (
  [id] BIGINT IDENTITY(1,1),
  [formFactor] VARCHAR(50) NOT NULL ,
  [keyboard] BIT DEFAULT 0,
  [height] DECIMAL(10,2) CHECK (height > 0),
  [width] DECIMAL(10,2) CHECK (width > 0),
  [thickness] DECIMAL(10,2) CHECK (thickness > 0),
  [ipCertificate] VARCHAR(50),
  [backMaterial] VARCHAR(50) NOT NULL,
  [frontMaterial] VARCHAR(50) NOT NULL,
  CONSTRAINT PK_Body PRIMARY KEY ([id]),
  CONSTRAINT UC_Body UNIQUE (formFactor, keyboard, height, width, thickness, ipCertificate, backMaterial, frontMaterial)
);
GO
​
CREATE TABLE [Display] (
  [id] BIGINT IDENTITY(1,1),
  [size] DECIMAL(10,2) CHECK (size > 0),
  [touchscreen] BIT DEFAULT 0,
  [refreshRate] BIT DEFAULT 0,
  [technology] VARCHAR(50) NOT NULL,
  [resolution] INT NOT NULL,
  [notch] VARCHAR(50) NOT NULL,
  CONSTRAINT PK_Display PRIMARY KEY ([id]),
  CONSTRAINT UC_Display UNIQUE (size, touchscreen, refreshRate, technology, resolution, notch)
);
GO
​
CREATE TABLE [modelSound] (
  [model_id] BIGINT,
  [sound_id] BIGINT,
  CONSTRAINT PK_modelSound PRIMARY KEY ( model_id,sound_id),
  CONSTRAINT FK_SoundModel FOREIGN KEY (sound_id) REFERENCES Sound(id),
  CONSTRAINT FK_ModelSound FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO
​
CREATE TABLE [modelBody] (
  [model_id] BIGINT,
  [body_id] BIGINT,
  CONSTRAINT PK_modelBody PRIMARY KEY (model_id,body_id),
  CONSTRAINT FK_BodyModel FOREIGN KEY (body_id) REFERENCES Body(id),
  CONSTRAINT FK_ModelBody FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO
​
CREATE TABLE [modelPlatform] (
  [model_id] BIGINT,
  [platform_id] BIGINT,
  CONSTRAINT PK_modelPlatform PRIMARY KEY (model_id,platform_id),
  CONSTRAINT FK_PlatformModel FOREIGN KEY (platform_id) REFERENCES Platform(id),
  CONSTRAINT FK_ModelPlatform FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO
​
CREATE TABLE [modelDisplay] (
  [model_id] BIGINT,
  [display_id] BIGINT,
  CONSTRAINT PK_modelDisplay PRIMARY KEY ( model_id,display_id),
  CONSTRAINT FK_DisplayModel FOREIGN KEY (display_id) REFERENCES Display(id),
  CONSTRAINT FK_ModelDisplay FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO
​
CREATE TABLE [modelBattery] (
  [model_id] BIGINT,
  [battery_id] BIGINT,
  CONSTRAINT PK_modelBattery PRIMARY KEY (model_id,battery_id),
  CONSTRAINT FK_BatteryModel FOREIGN KEY (battery_id) REFERENCES Battery(id),
  CONSTRAINT FK_ModelBattery FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO
​
CREATE TABLE [modelSensor] (
  [model_id] BIGINT,
  [sensor_id] BIGINT,
  CONSTRAINT PK_modelSensor PRIMARY KEY (model_id,sensor_id),
  CONSTRAINT FK_SensorModel FOREIGN KEY (sensor_id) REFERENCES Sensor(id),
  CONSTRAINT FK_ModelSensor FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO
​
CREATE TABLE [modelSim] (
  [model_id] BIGINT,
  [sim_id] BIGINT,
  CONSTRAINT PK_modelSim PRIMARY KEY (model_id,sim_id),
  CONSTRAINT FK_SimModel FOREIGN KEY (sim_id) REFERENCES Sim(id),
  CONSTRAINT FK_ModelSim FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO
​
CREATE TABLE [modelComms] (
  [model_id] BIGINT,
  [comms_id] BIGINT,
  CONSTRAINT PK_modelComms PRIMARY KEY (model_id,comms_id),
  CONSTRAINT FK_CommsModel FOREIGN KEY (comms_id) REFERENCES Comms(id),
  CONSTRAINT FK_ModelComms FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO
​
CREATE TABLE [modelNetwork] (
  [model_id] BIGINT,
  [network_id] BIGINT,
  CONSTRAINT PK_modelNetwork PRIMARY KEY (model_id,network_id),
  CONSTRAINT FK_NetworkModel FOREIGN KEY (network_id) REFERENCES	Network(id),
  CONSTRAINT FK_ModelNetwork FOREIGN KEY (model_id) REFERENCES Model(id)
);
GO