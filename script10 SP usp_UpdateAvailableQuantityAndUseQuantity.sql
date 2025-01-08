USE [AIMSV3]
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateAvailableQuantityAndUseQuantity]    Script Date: 08-01-2025 13:12:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
-- Execute the stored procedure
EXEC [dbo].[usp_UpdateAvailableQuantityAndUseQuantity];
*/


Create or ALTER  PROCEDURE [dbo].[usp_UpdateAvailableQuantityAndUseQuantity]
AS
BEGIN
    -- Set NOCOUNT ON to avoid extra result sets
    SET NOCOUNT ON;

    -- Update AvailableQuantity in the Products table
    UPDATE p
    SET AvailableQuantity = p.Quantity - ISNULL(up.UseQuantity, 0)
    FROM [dbo].[Products] p
    LEFT JOIN (
        -- Calculate UseQuantity from UserProducts table
        SELECT 
            up.ProductID,
            COUNT(up.ID) AS UseQuantity
        FROM [dbo].[UserProducts] up
        GROUP BY up.ProductID
    ) up ON p.ID = up.ProductID;

	UPDATE p
    SET UseQuantity = ISNULL(up.UsageCount, 0)
    FROM [dbo].[Products] p
    LEFT JOIN (
        -- Calculate the count of ProductID usage from UserProducts
        SELECT 
            up.ProductID,
            COUNT(up.ID) AS UsageCount
        FROM [dbo].[UserProducts] up
        GROUP BY up.ProductID
    ) up ON p.ID = up.ProductID;

END