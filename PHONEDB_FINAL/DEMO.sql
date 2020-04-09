SELECT * FROM Platform

INSERT INTO Platform
VALUES ('ISO14','6-core','Apple GPU(6-core graphics)','Apple A14')

UPDATE Platform SET OS = 'iOS14' WHERE id = 6

SELECT * FROM vwPlatformsByModel
SELECT * FROM vwModelAndSeries

INSERT INTO vwModelAndSeries
VALUES ('iPhone', 'Pro 14', GETDATE(), 16323.32,2000,2,'A14-21','APPLE','logo')
