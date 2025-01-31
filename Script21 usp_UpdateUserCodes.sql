USE [AIMSV3]
GO
/*
EXEC [dbo].[usp_UpdateUserCodes];
*/
/****** Object:  StoredProcedure [dbo].[usp.UpdateUserCodes]    Script Date: 08-01-2025 12:48:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE or ALTER PROCEDURE [dbo].[usp_UpdateUserCodes]
AS
BEGIN
    -- Start a transaction for safety
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Update all userCodes
        UPDATE Users
        SET userCode = 'AIMS' + CAST(id AS VARCHAR);

        -- Commit the transaction if successful
        COMMIT TRANSACTION;

        PRINT 'All userCodes updated successfully.';
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if an error occurs
        ROLLBACK TRANSACTION;

        -- Capture and print the error message
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        PRINT 'Error updating userCodes: ' + @ErrorMessage;
    END CATCH;
END;



