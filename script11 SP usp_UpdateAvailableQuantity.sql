USE [AIMSV3]
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateAvailableQuantity]    Script Date: 08-01-2025 13:56:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   PROCEDURE [dbo].[usp_UpdateAvailableQuantity]
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

END
