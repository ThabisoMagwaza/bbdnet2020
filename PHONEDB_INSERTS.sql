------------------------------------------------------------------
-- INSERT BODY BY MODEL
CREATE PROCEDURE spAddBodyByModel 
@Model_id INT,
@FormFactor NVARCHAR(50),
@KeyBoard BIT,
@width INT,
@height INT,
@thickness INT,
@IPCertificate NVARCHAR(50),
@BackMaterial NVARCHAR(50),
@FrontMaterial NVARCHAR(50)
AS
BEGIN
	DECLARE  @BodyId INT

	-- TRY TO SELECT BODY TYPE
	SELECT @BodyId = Id FROM Body 
	WHERE
		(	formFactor = @FormFactor AND
			keyboard = @KeyBoard AND
			height = @height AND
			width = @width AND
			thickness = @thickness AND
			ipCertificate = @IPCertificate AND
			backMaterial = @BackMaterial AND
			frontMaterial = @FrontMaterial
		)
	IF @BodyId IS NULL
		BEGIN
			-- INSERT NEW BODY TYPE AND RETREIVE ID
			BEGIN TRANSACTION
			BEGIN TRY
				
					INSERT INTO Body
					VALUES
						(@FormFactor,@KeyBoard,@height,@width,@thickness,@IPCertificate,@BackMaterial,@FrontMaterial)
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
			INSERT INTO modelBody VALUES (@Model_id,@BodyId)
			COMMIT TRANSACTION
		END
END

------------------------------------------------------------------
-- INSERT BODY BY MODEL
ALTER PROCEDURE spAddBatteryByModel 
@Model_id INT,
@Charging INT,
@wirelessCharging BIT,
@size INT
AS
BEGIN
	DECLARE  @BatteryId INT

	-- TRY TO SELECT BATTERY TYPE
	SELECT @BatteryId = Id FROM Battery 
	WHERE
		(	
			charging = @Charging AND
			wirelessCharging = @wirelessCharging AND
			size = @size
		)
	BEGIN TRANSACTION
	IF @BatteryId IS NULL
		BEGIN
			-- INSERT NEW BATTERY TYPE AND RETREIVE ID
			BEGIN TRY
					INSERT INTO Battery
					VALUES
						(@Charging,@wirelessCharging,@size)
					INSERT INTO modelBattery VALUES (@BatteryId,SCOPE_IDENTITY())
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
			INSERT INTO modelBattery VALUES (@Model_id,@BatteryId)
			COMMIT TRANSACTION
		END
END

SELECT * FROM Battery
SELECT * FROM vwBatteryByModel

EXEC spAddBatteryByModel 2,50,0,2432
