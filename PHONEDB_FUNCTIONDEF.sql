CREATE FUNCTION hasFeature(@sumVal INT, @featureName NVARCHAR(20))
RETURNS NVARCHAR(20)
AS
BEGIN
	DECLARE @rv NVARCHAR(20)
	IF(@sumVal > 0)
		BEGIN
			SET @rv = @featureName
		END
	ELSE
		BEGIN
			SET @rv = 'None'
		END
	RETURN @rv
END

