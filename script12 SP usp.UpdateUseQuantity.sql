/* 
-- Execute the stored procedure
EXEC [dbo].[usp.UpdateUseQuantity];
*/

/****** Object:  StoredProcedure [dbo].[usp.UpdateUseQuantity]    Script Date: 26-12-2024 11:14:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp.UpdateUseQuantity]
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
            COUNT(up.UserProductID) AS UsageCount
        FROM [dbo].[UserProducts] up
        GROUP BY up.ProductID
    ) up ON p.ID = up.ProductID;

END
