USE [AIMSV3]
GO
/****** Object:  StoredProcedure [dbo].[usp.UpdateUseQuantity]    Script Date: 08-01-2025 13:50:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
exec [dbo].[usp_UpdateUseQuantity]
CREATE OR ALTER   PROCEDURE [dbo].[usp_UpdateUseQuantity]
AS
BEGIN
    -- Set NOCOUNT ON to avoid extra result sets
    SET NOCOUNT ON;

    -- Update UseQuantity in the Products table
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
