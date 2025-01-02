

/*
-- Execute the stored procedure
EXEC [dbo].[usp.UpdateUserPermissions];
*/

CREATE OR ALTER PROCEDURE [dbo].[usp.UpdateUserPermissions]
AS
BEGIN
    -- Update Permissions to true for matching DepartmentIDs
    UPDATE U
    SET U.Permissions = 1
    FROM [dbo].[Users] U
    INNER JOIN [dbo].[Departments] D
        ON U.DepartmentID = D.ID
    WHERE D.Name IN ('Admin', 'Network and Systems Administrator');

    -- Update Permissions to false for non-matching DepartmentIDs
    UPDATE U
    SET U.Permissions = 0
    FROM [dbo].[Users] U
    WHERE U.DepartmentID NOT IN (
        SELECT ID
        FROM [dbo].[Departments]
        WHERE Name IN ('Admin', 'Network and Systems Administrator')
    );
END;
GO