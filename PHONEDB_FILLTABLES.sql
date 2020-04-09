USE [PHONEDB]
GO
--------------------------------------------------------------
-- INSERT INTO BASE TABLES
INSERT INTO Battery
VALUES 
	(10,20,30),
	(22,32,42),
	(40,20,53),
	(30,30,60)

INSERT INTO Body
VALUES 
	('factor-1',1,12,32,42,'cert-1','mat-1','mat-1'),
	('factor-2',0,23,32,24,'cert-2','mat-2','mat-2'),
	('factor-3',1,67,86,21,'cert-3','mat-3','mat-3'),
	('factor-4',1,23,44,65,'cert-4','mat-4','mat-4')

INSERT INTO Comms
VALUES 
	('blt-1','wlan-1',1,'usb-1','gps-1',1),
	('blt-2','wlan-2',1,'usb-2','gps-2',0),
	('blt-3','wlan-3',0,'usb-3','gps-3',1),
	('blt-4','wlan-4',0,'usb-4','gps-4',0)

INSERT INTO Company
VALUES
	('comp-1','logo-1'),
	('comp-2','logo-2'),
	('comp-3','logo-3'),
	('comp-4','logo-4')

INSERT INTO Display
VALUES
	(12,1,1,'tech-1','res-1','notch-1'),
	(32,0,1,'tech-2','res-2','notch-2'),
	(13,0,1,'tech-3','res-3','notch-3'),
	(32,0,0,'tech-4','res-4','notch-4')


INSERT INTO Series
VALUES
	('s1',1),
	('s2',2),
	('s3',3),
	('s4',4)

INSERT INTO Model
VAlUES
	('name-1',GETDATE(),454,67,'model-1',1),
	('name-2',GETDATE(),796,65,'model-2',2),
	('name-3',GETDATE(),43,46,'model-3',3),
	('name-4',GETDATE(),123,23,'model-4',4)


INSERT INTO Network
VALUES 
	(1,1,1,1,232,123),
	(1,0,1,1,989,212),
	(0,1,1,0,987,121),
	(0,0,0,0,345,12)


INSERT INTO Platform
VALUES
	('os-1','cpu-1','gpu-1','set-1'),
	('os-2','cpu-2','gpu-2','set-2'),
	('os-3','cpu-3','gpu-3','set-3'),
	('os-4','cpu-4','gpu-4','set-4')


INSERT INTO Sensor 
VALUES 
	('fingerprint-1',1,1,1,1,1),
	('fingerprint-2',1,1,1,0,0),
	('fingerprint-3',1,0,0,1,1),
	('fingerprint-4',0,1,1,1,1)

INSERT INTO Sim
VALUES
	('size-1',1),
	('size-2',2),
	('size-3',1),
	('size-4',2)


INSERT INTO Sound
VALUES
	('ls-1',1,'sound-1'),
	('ls-2',1,'sound-2'),
	('ls-3',1,'sound-3'),
	('ls-4',0,'sound-4')


SELECT * FROM Sound
SELECT * FROM Sim
SELECT * FROM Sensor
SELECT * FROM Platform
SELECT * FROM Network
SELECT * FROM Model
SELECT * FROM Series
SELECT * FROM Display
SELECT * FROM Company
SELECT * FROM Comms
SELECT * FROM Body
SELECT * FROM Battery
--------------------------------------------------------------
-- INSERT INTO LINKING TABLES

INSERT INTO modelBattery
VALUES
	(1,1),
	(2,2),
	(1,3),
	(4,1),
	(3,2),
	(3,4)

INSERT INTO modelBody
VALUES
	(1,1),
	(2,2),
	(1,3),
	(4,1),
	(3,2),
	(3,4)

INSERT INTO modelComms
VALUES
	(1,1),
	(2,2),
	(1,3),
	(4,1),
	(3,2),
	(3,4)

INSERT INTO modelDisplay
VALUES
	(1,1),
	(2,2),
	(1,3),
	(4,1),
	(3,2),
	(3,4)

INSERT INTO modelSensor
VALUES
	(1,1),
	(2,2),
	(1,3),
	(4,1),
	(3,2),
	(3,4)

INSERT INTO modelSim
VALUES
	(1,1),
	(2,2),
	(1,3),
	(4,1),
	(3,2),
	(3,4)

INSERT INTO modelSound
VALUES
	(1,1),
	(2,2),
	(1,3),
	(4,1),
	(3,2),
	(3,4)

INSERT INTO modelPlatform
VALUES
	(1,1),
	(2,2),
	(1,3),
	(4,1),
	(3,2),
	(3,4)

INSERT INTO modelNetwork
VALUES
	(1,1),
	(2,2),
	(1,3),
	(4,1),
	(3,2),
	(3,4)

SELECT * FROM modelNetwork
SELECT * FROM modelPlatform
SELECT * FROM modelSound	
SELECT * FROM modelSim
SELECT * FROM modelSensor
SELECT * FROM modelDisplay
SELECT * FROM modelComms
SELECT * FROM modelBody
SELECT * FROM modelBattery
