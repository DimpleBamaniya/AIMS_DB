USE [AIMSV3]
GO
/****** Object:  StoredProcedure [dbo].[usp_IsExistProduct]    Script Date: 16-01-2025 11:40:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
exec usp_IsExistProduct @BrandID= 4,@CategoryID=1
*/

ALTER    PROCEDURE [dbo].[usp_IsExistProduct]
    @BrandID INT,
    @CategoryID INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM [AIMSV3].[dbo].[Products]
        WHERE [BrandID] = @BrandID AND [CategoryID] = @CategoryID and IsDeleted = 0
    )
    BEGIN
        SELECT CAST(1 AS BIT) AS Result; -- Return true (1) if the combination exists
    END
    ELSE
    BEGIN
        SELECT CAST(0 AS BIT) AS Result; -- Return false (0) if the combination does not exist
    END
END;
