USE [AIMSV3]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetProductListByUserId]    Script Date: 1/12/2025 1:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	EXEC [dbo].[usp_GetProductListByUserId]
	@UserID = 1
*/

Create or ALTER   PROCEDURE [dbo].[usp_GetProductListByUserId]
(
	@UserID INT = null
)
AS
BEGIN	
	 SELECT 
        up.ID AS UserProductID,  -- UserProductID from UserProducts table
        c.Name AS CategoryName  -- CategoryName from Categories table
    FROM 
        [AIMSV3].[dbo].[UserProducts] up
    JOIN 
        [AIMSV3].[dbo].[Products] p ON up.ProductID = p.ID  -- Join UserProducts with Products table
    JOIN 
        [AIMSV3].[dbo].[Categories] c ON p.CategoryID = c.ID  -- Join Products with Categories table
    WHERE 
        up.UserID = @UserID  -- Filter by the passed UserID
    ORDER BY 
        up.AssignedDate DESC;  -- Optionally order by AssignedDate (if needed)
END
------