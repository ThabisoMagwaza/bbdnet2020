------------------------------------------------------------------
-- INSERT PLATFORM BY MODEL
CREATE PROCEDURE spAddPlatformByModel 
@Model_id INT,
@OS NVARCHAR(100),
@CPU NVARCHAR(100),
@GPU NVARCHAR(100),
@chipset NVARCHAR(100)
AS
BEGIN
	DECLARE  @PlatId INT

	-- TRY TO SELECT BODY TYPE
	SELECT @PlatId = Id FROM Platform 
	WHERE
		(	
			OS = @OS AND
			CPU = @CPU AND
			GPU = @GPU AND
			chipset = @chipset
		)
	BEGIN TRANSACTION
	-- IF NEW PLATFORM
	IF @PlatId IS NULL
		BEGIN
			-- INSERT NEW BODY TYPE AND RETREIVE ID
			BEGIN TRY
				
					INSERT INTO Platform
					VALUES
						(@OS,@CPU,@GPU,@chipset)
					INSERT INTO modelBody VALUES (@Model_id,SCOPE_IDENTITY())
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
	ELSE
		BEGIN 
			INSERT INTO modelPlatform VALUES (@Model_id,@PlatId)
			COMMIT TRANSACTION
		END
END

SELECT * FROM modelPlatform
EXEC spAddPlatformByModel 17, 'Android 10.0',	'Octa-core',	'Mali-G77 MP11 - Global',	'Exynos 990'
