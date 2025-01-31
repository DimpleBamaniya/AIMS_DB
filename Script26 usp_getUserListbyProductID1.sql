USE [AIMSV3]
GO
/****** Object:  StoredProcedure [dbo].[usp_getUserListbyProductID]    Script Date: 1/13/2025 1:14:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC usp_getUserListbyProductID @ProductID = 6
*/

ALTER   PROCEDURE [dbo].[usp_getUserListbyProductID]
    @ProductID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Retrieve the total count of assigned products, along with ProductID and UserProductID
    SELECT 
        [p].[ID] AS UserProductID,         -- UserProductID
        [p].[UserID] as ID,  --userid
		[u].[FirstName] as Name, -- username
        COUNT(*) OVER() AS TotalRecord -- Total count of user assigned to the product
    FROM 
        [AIMSV3].[dbo].[UserProducts] p
		JOIN 
    [AIMSV3].[dbo].[Users] u ON p.UserID = u.ID
    WHERE 
        [p].[ProductID] = @ProductID;
END;
