CREATE VIEW vw_Products AS
SELECT 
    p.ID,
    p.CategoryID,
    c.Name AS CategoryName,
    p.BrandID,
    b.Name AS BrandName,
    p.Quantity,
    p.UseQuantity,
    p.AvailableQuantity
FROM 
    [AIMSV3].[dbo].[Products] p
JOIN 
    [AIMSV3].[dbo].[Categories] c ON p.CategoryID = c.ID
JOIN 
    [AIMSV3].[dbo].[Brands] b ON p.BrandID = b.ID;
