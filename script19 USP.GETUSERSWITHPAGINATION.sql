USE [AIMSV3]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetUsersWithPagination]    Script Date: 08-01-2025 13:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

EXEC [dbo].[usp_GetUsersWithPagination]
	@SearchString ='',
    @PageNo  = 1,
    @PageSize = 50,
    @SortColumn = 'id',
    @SortOrder  = 'ASC'
*/
Create or ALTER PROCEDURE [dbo].[usp_GetUsersWithPagination]
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

    DECLARE @Offset INT;
    DECLARE @TotalRecords INT;

    -- Sanitize input
    SET @SearchString = TRIM(ISNULL(@SearchString, ''));

    -- Drop temp tables if they already exist
    DROP TABLE IF EXISTS #Temp_AllUserData;
    DROP TABLE IF EXISTS #Temp_FilteredUserData;
    DROP TABLE IF EXISTS #Temp_SortedUsers;

    -- Create a temp table with all user data
    SELECT      
        [U].[ID],
        [U].[UserCode],
        [U].[FirstName],
        [U].[LastName],
        CASE WHEN [U].[DepartmentID] IS NULL THEN NULL ELSE [D].[Id] END AS DepartmentID,
        CASE WHEN [U].[DepartmentID] IS NULL THEN NULL ELSE [D].[Name] END AS DepartmentName,
        CASE WHEN [U].[CityID] IS NULL THEN NULL ELSE [C].[ID] END AS CityID,
        CASE WHEN [U].[CityID] IS NULL THEN NULL ELSE [C].[Name] END AS CityName
    INTO        #Temp_AllUserData
    FROM        [dbo].[vw_Users] AS U
    LEFT JOIN   Departments D ON U.DepartmentID = D.Id
    LEFT JOIN   Cities C ON U.CityID = C.Id;

    -- Filter data based on the search string
    SELECT  *
    INTO    #Temp_FilteredUserData
    FROM    #Temp_AllUserData
    WHERE   (
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
            );

    -- Calculate total records
    SELECT  @TotalRecords = COUNT(1) 
    FROM    #Temp_FilteredUserData;

    -- Calculate offset for pagination
    SET @Offset = ((@PageNo - 1) * @PageSize);

    -- Sort and paginate the data
    SELECT      *,
                IDENTITY(INT, 1, 1) AS [RowNo]
    INTO        #Temp_SortedUsers
    FROM        #Temp_FilteredUserData U
    ORDER BY    CASE WHEN (@SortColumn = 'ID' AND @SortOrder = 'ASC') THEN [U].[ID] END ASC,
                CASE WHEN (@SortColumn = 'ID' AND @SortOrder = 'DESC') THEN [U].[ID] END DESC,
                CASE WHEN (@SortColumn = 'UserCode' AND @SortOrder = 'ASC') THEN [U].[UserCode] END ASC,
                CASE WHEN (@SortColumn = 'UserCode' AND @SortOrder = 'DESC') THEN [U].[UserCode] END DESC,
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
    FETCH NEXT @PageSize ROWS ONLY;

    -- Return paginated and sorted data
    SELECT      [U].[ID],
                [U].[UserCode],
                [U].[FirstName],
                [U].[LastName],
                [U].[CityID],
                [U].[CityName],
                [U].[DepartmentID],
                [U].[DepartmentName],
                @TotalRecords AS [TotalRecords]
    FROM        #Temp_SortedUsers U
    ORDER BY    [RowNo];
END;
