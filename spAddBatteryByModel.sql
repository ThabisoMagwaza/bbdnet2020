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
	IF @BatteryId IS NULL
		BEGIN
			-- INSERT NEW BATTERY TYPE AND RETREIVE ID
			BEGIN TRANSACTION
			BEGIN TRY
					INSERT INTO Battery
					VALUES
						(@Charging,@wirelessCharging,@size)
					INSERT INTO modelBattery VALUES (@Model_id,SCOPE_IDENTITY())
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
		END
END

SELECT * FROM Battery
SELECT * FROM vwBatteryByModel

EXEC spAddBatteryByModel 1,53,0,60
