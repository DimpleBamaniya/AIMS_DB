USE [AIMSV3]
GO

/****** Object:  View [dbo].[vw_Users]    Script Date: 06-01-2025 11:54:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_Users] AS
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
JOIN 
    Departments d ON u.DepartmentID = d.Id
JOIN 
    Cities c ON u.CityID = c.Id;
GO
