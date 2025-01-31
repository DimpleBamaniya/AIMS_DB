USE [AIMSV3]
GO
/****** Object:  Trigger [dbo].[trg_CheckProductQuantity]    Script Date: 26-12-2024 18:36:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create OR ALTER TRIGGER [dbo].[trg_CheckProductQuantity]
ON [dbo].[UserProducts]
INSTEAD OF INSERT
AS
BEGIN
    -- Check if the new ProductID assignment exceeds available Quantity
    IF EXISTS (
        SELECT 1
        FROM INSERTED i
        JOIN [dbo].[Products] p ON i.ProductID = p.ID
        WHERE (
            SELECT COUNT(*) 
            FROM [dbo].[UserProducts] up 
            WHERE up.ProductID = i.ProductID
        ) >= p.Quantity
    )
    BEGIN
        -- Block the insert operation
        RAISERROR ('ProductID assignment exceeds available Quantity.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Allow the insert if the condition is not violated
    INSERT INTO [dbo].[UserProducts] (UserID, ProductID, AssignedDate)
    SELECT UserID, ProductID, AssignedDate
    FROM INSERTED;
END;
