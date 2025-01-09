USE [AIMSV3]
GO

/****** Object:  View [dbo].[vw_Users]    Script Date: 09-01-2025 17:14:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  OR ALTER VIEW [dbo].[vw_Users] AS
SELECT 
    u.ID,
    u.UserCode,
    u.FirstName,
    u.LastName,
	u.Permissions,
    d.Id AS DepartmentID,
    d.Name AS DepartmentName,
    c.ID AS CityID,
    c.Name AS CityName,
	u.Modified,
	u.ModifiedBy,
	u.Created,
	u.CreatedBy
FROM 
    USERS u
LEFT JOIN 
    Departments d ON u.DepartmentID = d.Id
LEFT JOIN 
    Cities c ON u.CityID = c.Id
WHERE 
    u.IsDeleted = 0; -- Exclude deleted users (assuming IsDeleted is a bit column and 0 = not deleted)
GO


