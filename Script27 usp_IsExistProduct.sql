

/*
exec usp_IsExistProduct @BrandID= 4,@CategoryID=1
*/

CREATE  OR ALTER PROCEDURE [dbo].[usp_IsExistProduct]
    @BrandID INT,
    @CategoryID INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM [AIMSV3].[dbo].[Products]
        WHERE [BrandID] = @BrandID AND [CategoryID] = @CategoryID
    )
    BEGIN
        SELECT CAST(1 AS BIT) AS Result; -- Return true (1) if the combination exists
    END
    ELSE
    BEGIN
        SELECT CAST(0 AS BIT) AS Result; -- Return false (0) if the combination does not exist
    END
END;
GO
