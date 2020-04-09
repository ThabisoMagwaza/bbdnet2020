USE [PHONEDB]
GO

-----------------------------------------------------------------------------
-- INSERT TABLES

INSERT INTO Company VALUES
			('APPLE','http://t1.gstatic.com/images?q=tbn:ANd9GcSjoU2lZ2eJX3aCMfiFDt39uRNcDu9W7pTKcyZymE2iKa7IOVaI'),
			('SAMSUNG','https://europeansting.files.wordpress.com/2014/04/samsung-logo.jpg?w=640'),
			('HUAWEI','https://www.huawei.com/-/media/corporate/images/home/logo/new-logo.png'),
			('NOKIA','https://www.nokia.com/sites/default/files/styles/scale_1920_no_crop/public/media/nokia_white_logo.png');
GO

INSERT INTO Series VALUES
				('iPad',1),
				('iPhone',1),
				('Galaxy S',2),
				('Galaxy M',2),
				('P',3),
				('Mate',3),
				('Asha',4);
GO


INSERT INTO Model VALUES
					('Air', '2019-03-01', 10885.75, 10000, 1, 'A2153', 1),
					('X', '2017-10-01', 9892.56, 20000, 1, 'A1865', 2),
					('11 Pro', '2019-09-01', 21348.56, 20000, 2, 'A2215', 2),
					('20', '2020-03-06', 14759.99, 10000, 2, 'SM-G980', 3),
					('10 Lite', '2020-03-03', 9872.97, 20000, 1, 'SM-G770F', 3),
					('31', '2020-03-05', 4135.17, 20000, 2, 'SM-M315F', 4),
					('40', '2020-04-07', 15929.34, 20000, 1, 'ANA-AN00', 5),
					('40 Pro', '2020-04-07', 19765.72, 20000, 1, 'ELS-NX9', 5),
					('Xs', '2020-03-05', 49463.77, 10000, 2, 'TAH-N29m', 6),
					('210', '2013-04-01', 989.28, 1000, 2, 'TA-1234', 7);
GO
-----------------------------------------------------------------------------

INSERT INTO Battery VALUES
				(10, 0, 8134),
				(15, 0, 2716),
				(18, 0, 3046),
				(25, 0, 4000),
				(45, 0 , 4500),
				(15, 0, 6000),
				(22.5, 0, 3800),
				(40, 1, 4200),
				(55, 0, 4500),
				(12, 0, 1200);
GO

INSERT INTO modelBattery VALUES
						(1,1),
						(2,2),
						(3,3),
						(4,4),
						(5,5),
						(6,6),
						(7,7),
						(8,8),
						(9,9),
						(10,10);
GO

-----------------------------------------------------------------------------

INSERT INTO Body VALUES
				('bar', 0, 250.6, 174.1, 6.1,'','aluminum','glass'),
				('bar', 0, 143.6, 70.9, 7.7, 'IP67', 'glass', 'glass'),
				('bar', 0, 144, 71.4, 8.1, 'IP68','glass', 'glass'),
				('bar', 0, 151.7, 69.1, 7.9, 'IP68','glass', 'glass' ),
				('bar', 0, 162.5, 75.6, 8.1,'','aluminum','glass'),
				('bar', 0, 159.2, 75.1, 8.9,'','plastic','glass'),
				('bar', 0, 148.9, 71.1, 8.5, 'IP53', 'aluminum','glass'),
				('bar', 0, 158.2, 72.6, 9, 'IP68', 'glass', 'glass'),
				('bar', 0, 161.3, 146.2, 5.4, '', 'plastic', 'aluminum'),
				('bar', 1, 111.5, 60, 11.8, '', 'plastic', 'plastic');
GO

INSERT INTO modelBody VALUES
					(1,1),
					(2,2),
					(3,3),
					(4,4),
					(5,5),
					(6,6),
					(7,7),
					(8,8),
					(9,9),
					(10,10);
GO

-----------------------------------------------------------------------------
INSERT INTO Platform VALUES
					('iOS 12.1.3', 'Hexa-core', 'Apple GPU(4-core graphics)', 'Apple A12 Bionic'),
					('iOS 11.1.1', 'Hexa-core 2.39 GHz', 'Apple GPU(three-core graphics)', 'Apple A11 Bionic'),
					('iOS 13', 'Hexa-core', 'Apple GPU(three-core graphics)', 'Apple A13 Bionic'),
					('Android 10.0', 'Octa-core', 'Mali-G77 MP11 - Global', 'Exynos 990'),
					('nokiaOS', 'nokia CPU', '', '');
GO

INSERT INTO modelPlatform VALUES
						(1,1),
						(2,2),
						(3,3),
						(4,4),
						(5,4),
						(6,4),
						(7,4),
						(8,4),
						(9,4),
						(10,5);
GO
