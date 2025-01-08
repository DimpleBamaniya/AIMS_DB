USE [AIMSV3]
GO

/****** Object:  View [dbo].[vw_Users]    Script Date: 08-01-2025 13:48:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [dbo].[vw_Users] AS
SELECT 
    u.ID,
    u.UserCode,
    u.FirstName,
    u.LastName,
    d.Id AS DepartmentID,
    d.Name AS DepartmentName,
    c.ID AS CityID,
    c.Name AS CityName
FROM 
    USERS u
LEFT JOIN 
    Departments d ON u.DepartmentID = d.Id
LEFT JOIN 
    Cities c ON u.CityID = c.Id
WHERE 
    u.IsDeleted = 0; -- Exclude deleted users (assuming IsDeleted is a bit column and 0 = not deleted)
GO


