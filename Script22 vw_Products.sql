USE [AIMSV3]
GO

/****** Object:  View [dbo].[vw_Products]    Script Date: 09-01-2025 15:16:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE   OR alter  VIEW [dbo].[vw_Products] AS
SELECT 
    p.ID,
	p.Code,
    p.CategoryID,
    c.Name AS CategoryName,
    p.BrandID,
    b.Name AS BrandName,
    p.Quantity,
    p.UseQuantity,
    p.AvailableQuantity,
	p.Modified,
	p.ModifiedBy,
	p.Created,
	p.CreatedBy
FROM 
    [AIMSV3].[dbo].[Products] p
JOIN 
    [AIMSV3].[dbo].[Categories] c ON p.CategoryID = c.ID
JOIN 
    [AIMSV3].[dbo].[Brands] b ON p.BrandID = b.ID
WHERE 
    p.isdeleted = 0; -- Exclude records where IsActive is false
GO


