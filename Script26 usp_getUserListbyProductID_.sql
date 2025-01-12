/*
EXEC usp_getUserListbyProductID @ProductID =6
*/

CREATE or ALTER PROCEDURE [dbo].[usp_getUserListbyProductID]
    @ProductID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Retrieve the total count of assigned products, along with ProductID and UserProductID
    SELECT 
        [ID] AS ID,         -- UserProductID
        [UserID],                    -- userID
        COUNT(*) OVER() AS TotalRecord -- Total count of user assigned to the product
    FROM 
        [AIMSV3].[dbo].[UserProducts]
    WHERE 
        [ProductID] = @ProductID;
END;
GO

