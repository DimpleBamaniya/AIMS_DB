USE [AIMSV3]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC usp_CheckUserProductCategoryMatch @UserID =2 ,@CategoryID = 3
*/
CREATE OR ALTER PROCEDURE [dbo].[usp_CheckUserProductCategoryMatch]
    @UserID INT,
    @CategoryID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Create a temporary table to store the result of usp_GetProductListByUserId
    CREATE TABLE #UserProducts (
        UserProductID INT,
        ProductID INT,
        Name NVARCHAR(255),
        TotalRecord INT
    );

    -- Insert the result of usp_GetProductListByUserId into the temporary table
    INSERT INTO #UserProducts (UserProductID, ProductID, Name, TotalRecord)
    EXEC [dbo].[usp_GetProductListByUserId] @UserID;

    -- Check if any ProductID from usp_GetProductListByUserId matches the provided CategoryID
    IF EXISTS (
        SELECT 1
        FROM #UserProducts up
        INNER JOIN [AIMSV3].[dbo].[Products] p ON up.ProductID = p.ID
        WHERE p.CategoryID = @CategoryID
    )
    BEGIN
        -- Match found
        SELECT CAST(1 AS BIT) AS Result; -- TRUE
    END
    ELSE
    BEGIN
        -- No match found
        SELECT CAST(0 AS BIT) AS Result; -- FALSE
    END

    -- Drop the temporary table
    DROP TABLE #UserProducts;
END;
GO
