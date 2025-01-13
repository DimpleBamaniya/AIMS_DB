USE [AIMSV3]
GO

/****** Script to Create View vw_UserProductsActive ******/
CREATE VIEW [dbo].[vw_UserProducts]
AS
SELECT up.[ID]
      ,up.[UserID]
      ,up.[ProductID]
      ,up.[AssignedDate]
  FROM [dbo].[UserProducts] up
  JOIN [dbo].[Users] u ON up.UserID = u.ID
  WHERE u.IsDeleted = 0
GO
