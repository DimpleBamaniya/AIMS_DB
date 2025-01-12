--Exec usp_getListUserProductbyUserid @UserID = 0
CREATE PROCEDURE [dbo].[usp_getProductListbyUserID]
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Retrieve the list of products assigned to the given UserID
    SELECT 
        [ID],
        [UserID],
        [ProductID]
    FROM 
        [AIMSV3].[dbo].[UserProducts]
    WHERE 
        [UserID] = @UserID;
   END;
GO
