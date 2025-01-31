USE [AIMSV3]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetUsersWithPagination]    Script Date: 06-01-2025 12:37:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	EXEC [dbo].[usp_GetUsersWithPagination]
	@SearchString = 'TITA',
	@PageNo = 1,
	@PageSize = 1000,
	@SortColumn = 'ID',
	@SortOrder = 'ASC'
*/
ALTER    PROCEDURE [dbo].[usp_GetUsersWithPagination]
(
	@SearchString NVARCHAR(50),
	@PageNo INT = 1,
	@PageSize INT = 100,
	@SortColumn VARCHAR(50) = 'Name',
	@SortOrder VARCHAR(20) = 'ASC'
)
AS
BEGIN	
	SET NOCOUNT ON;	

	DECLARE @Offset INT
	DECLARE @TotalRecords INT
		
    SET @SearchString = TRIM(ISNULL(@SearchString, ''));
	
	DROP TABLE IF EXISTS #Temp_AllUserData
	DROP TABLE IF EXISTS #Temp_FilteredUserData
	DROP TABLE IF EXISTS #Temp_SortedUsers

	SELECT		[U].[ID],
				[U].[UserCode],
				[U].[FirstName],
				[U].[LastName],
				[U].[CityID],
				[U].[CityName],
				[U].[DepartmentID],
				[U].[DepartmentName]
	INTO		#Temp_AllUserData
	FROM		[dbo].[vw_Users] AS U

	SELECT  *
	INTO	#Temp_FilteredUserData
	FROM	[#Temp_AllUserData] 
	WHERE	(
		        @SearchString IS NULL 
				OR 
				@SearchString = '' 
				OR 
				[FirstName] LIKE '%' + @SearchString + '%'
				OR
				[LastName] LIKE '%' + @SearchString + '%'
				OR
				[CityName] LIKE '%' + @SearchString + '%'
				OR
				[DepartmentName] LIKE '%' + @SearchString + '%'
				OR 
				[UserCode] LIKE '%' + @SearchString + '%'
			)

	SELECT	@TotalRecords = COUNT(1) 
	FROM	[#Temp_FilteredUserData]

	SET @Offset = ((@PageNo - 1) * @PageSize)

	SELECT		[U].*,
				IDENTITY(INT,1,1) AS [RowNo]
	INTO		[#Temp_SortedUsers]
	FROM		[#Temp_FilteredUserData] U
	ORDER BY	CASE WHEN (@SortColumn = 'ID' AND @SortOrder = 'ASC') THEN [U].[ID] END ASC,
				CASE WHEN (@SortColumn = 'ID' AND @SortOrder = 'DESC') THEN [U].[ID] END DESC,
				CASE WHEN (@SortColumn = 'FirstName' AND @SortOrder = 'ASC') THEN [U].[FirstName] END ASC,
				CASE WHEN (@SortColumn = 'FirstName' AND @SortOrder = 'DESC') THEN [U].[FirstName] END DESC,
				CASE WHEN (@SortColumn = 'LastName' AND @SortOrder = 'ASC') THEN [U].[LastName] END ASC,
				CASE WHEN (@SortColumn = 'LastName' AND @SortOrder = 'DESC') THEN [U].[LastName] END DESC,
				CASE WHEN (@SortColumn = 'CityName' AND @SortOrder = 'ASC') THEN [U].[CityName] END ASC,
				CASE WHEN (@SortColumn = 'CityName' AND @SortOrder = 'DESC') THEN [U].[CityName] END DESC,
				CASE WHEN (@SortColumn = 'DepartmentName' AND @SortOrder = 'ASC') THEN [U].[DepartmentName] END ASC,
				CASE WHEN (@SortColumn = 'DepartmentName' AND @SortOrder = 'DESC') THEN [U].[DepartmentName] END DESC,
				[U].[ID]
	OFFSET @Offset ROWS    
    FETCH NEXT @PageSize ROWS ONLY 

	SELECT		[U].[ID],
				[U].[UserCode], 
				[U].[FirstName],
				[U].[LastName],
				[U].[CityName],
				[U].[DepartmentName],
				@TotalRecords AS [TotalRecords]		
	FROM		[#Temp_SortedUsers] U
	ORDER BY	[RowNo]
END
------