USE [AIMSV3]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
-- Execute the stored procedure
EXEC [dbo].[usp_GetBrandsByCategoryAndAvailability] @CategoryID = 2
*/

CREATE OR ALTER PROCEDURE [dbo].[usp_GetBrandsByCategoryAndAvailability]
    @CategoryID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Retrieve Brand IDs from Products based on the provided CategoryID and conditions
    SELECT DISTINCT b.[ID], b.[Name]
    FROM [dbo].[Brands] b
    INNER JOIN [dbo].[Products] p
        ON b.[ID] = p.[BrandID]
    WHERE p.[CategoryID] = @CategoryID
      AND p.[IsDeleted] = 0
      AND p.[AvailableQuantity] != 0
      AND b.[IsActive] = 1; -- Ensure only active brands are included
END
GO
