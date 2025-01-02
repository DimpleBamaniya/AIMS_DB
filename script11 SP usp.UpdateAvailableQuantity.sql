USE [AIMSV3]
GO
/* 
-- Execute the stored procedure
EXEC [dbo].[usp.UpdateAvailableQuantity];
*/

/****** Object:  StoredProcedure [dbo].[usp.UpdateAvailableQuantity] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp.UpdateAvailableQuantity]
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
            COUNT(up.UserProductID) AS UseQuantity
        FROM [dbo].[UserProducts] up
        GROUP BY up.ProductID
    ) up ON p.ID = up.ProductID;

END
GO