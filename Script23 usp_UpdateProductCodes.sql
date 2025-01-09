USE [AIMSV3]
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateProductCodes]    Script Date: 09-01-2025 12:04:01 ******/
SET ANSI_NULLS ON
GO
/*
EXEC [dbo].[usp_UpdateProductCodes]
*/
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER   PROCEDURE [dbo].[usp_UpdateProductCodes]
AS
BEGIN
    -- Start a transaction for safety
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Update all userCodes
        UPDATE Products
        SET Code = 'Product' + CAST(id AS VARCHAR);

        -- Commit the transaction if successful
        COMMIT TRANSACTION;

        PRINT 'All Product Codes updated successfully.';
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if an error occurs
        ROLLBACK TRANSACTION;

        -- Capture and print the error message
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        PRINT 'Error updating userCodes: ' + @ErrorMessage;
    END CATCH;
END;

