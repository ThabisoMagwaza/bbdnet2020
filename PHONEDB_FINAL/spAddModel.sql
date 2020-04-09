ALTER PROC spVwModelAndSeries_INSERT
			@SeriesName NVARCHAR(50),
			@ModelName NVARCHAR(50),
			@releaseDate DATE,
			@releasePrice DECIMAL(18,2),
			@numReleased INT,
			@numSim INT,
			@model NVARCHAR(50),
			@brand NVARCHAR(50),
			@logo NVARCHAR(150)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @company_id INT
			DECLARE @series_id INT
			
			-- GET COMPANY ID
			SELECT @company_id = id FROM Company WHERE name = @brand
			-- IF NEW COMPANY
			IF @company_id IS NULL
				BEGIN
					INSERT INTO Company VALUES (@Brand,@logo)
					SET @company_id = SCOPE_IDENTITY()
					INSERT INTO Series VALUES (@SeriesName,@company_id)
					SET @series_id = SCOPE_IDENTITY()
				END
			-- IF EXISTING COMPANY
			ELSE
				BEGIN
					-- GET EXISTING SERIES
					SELECT @series_id = id FROM Series WHERE name = @SeriesName
					-- IF NEW SERIES
					IF @series_id IS NULL
						BEGIN
							INSERT INTO Series VALUES (@SeriesName,@company_id)
							SET @series_id = SCOPE_IDENTITY()
						END
				END

				INSERT INTO Model VALUES (@ModelName, @releaseDate,@releasePrice,@numReleased,@numSim,@model,@series_id)
				COMMIT TRANSACTION
		END TRY
	BEGIN CATCH
			ROLLBACK TRANSACTION
			SELECT  
				ERROR_NUMBER() AS ErrorNumber  
				,ERROR_SEVERITY() AS ErrorSeverity  
				,ERROR_STATE() AS ErrorState  
				,ERROR_PROCEDURE() AS ErrorProcedure  
				,ERROR_LINE() AS ErrorLine  
				,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END

SELECT * FROM vwModelAndSeries
SELECT * FROM model
SELECT * FROM Series
SELECT * FROM Company


EXEC spVwModelAndSeries_INSERT	'iMac3' ,'Pro 6', '2020-04-10' , 3545223.34 ,2000 ,1,'A45-64','APPLE','logo'

SELECT * FROM vwPlatformsByModel

