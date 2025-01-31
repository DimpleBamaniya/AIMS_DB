USE [AIMSV3]
GO
/****** Object:  StoredProcedure [dbo].[usp_getProductListbyUserID]    Script Date: 1/13/2025 3:07:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC usp_getProductListbyUserID @UserID =1
*/

ALTER   PROCEDURE [dbo].[usp_getProductListbyUserID]
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Retrieve the total count of assigned products, along with ProductID and UserProductID
    SELECT 
		[up].[ID] AS UserProductID,         -- UserProductID
        [up].[ProductID] as ID,  --userid
		[c].[name] as Name, -- username
        COUNT(*) OVER() AS TotalRecord -- Total count of products assigned to the user
    FROM 
        [AIMSV3].[dbo].[UserProducts] up
		JOIN 
    [AIMSV3].[dbo].[Products] p ON up.ProductID = p.ID
			JOIN 
    [AIMSV3].[dbo].[Categories] c ON p.CategoryID = c.ID
    WHERE 
        [UserID] = @UserID;
END;
