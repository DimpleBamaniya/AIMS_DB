/*

Exec usp_GetUsersWithPagination @SearchString = '',@PageNo=1,@PageSize=10,@SortColumn='id',@SortOrder='ASC'

*/

ALTER PROCEDURE [dbo].[usp_GetUsersWithPagination]
(
    @SearchString NVARCHAR(50),
    @PageNo INT = 1,
    @PageSize INT = 100,
    @SortColumn VARCHAR(50) = 'ID',
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

    -- Create a temp table with all user data
    SELECT      
        [U].[ID],
        [U].[UserCode],
        [U].[FirstName],
        [U].[LastName],
        [U].[Permissions],
        [U].[Modified],
        [U].[ModifiedBy],
        [U].[Created],
        [U].[CreatedBy],
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
    SELECT      *
    INTO        #Temp_SortedUsers
    FROM        (
                    SELECT *, ROW_NUMBER() OVER (
                        ORDER BY 
                        CASE WHEN @SortOrder = 'ASC' AND @SortColumn = 'ID' THEN [ID] END ASC,
                        CASE WHEN @SortOrder = 'DESC' AND @SortColumn = 'ID' THEN [ID] END DESC,
                        CASE WHEN @SortOrder = 'ASC' AND @SortColumn = 'UserCode' THEN [ID] END ASC,
                        CASE WHEN @SortOrder = 'DESC' AND @SortColumn = 'UserCode' THEN [ID] END DESC,
                        CASE WHEN @SortOrder = 'ASC' AND @SortColumn = 'FirstName' THEN [FirstName] END ASC,
                        CASE WHEN @SortOrder = 'DESC' AND @SortColumn = 'FirstName' THEN [FirstName] END DESC,
                        CASE WHEN @SortOrder = 'ASC' AND @SortColumn = 'LastName' THEN [LastName] END ASC,
                        CASE WHEN @SortOrder = 'DESC' AND @SortColumn = 'LastName' THEN [LastName] END DESC,
                        CASE WHEN @SortOrder = 'ASC' AND @SortColumn = 'CityName' THEN [CityName] END ASC,
                        CASE WHEN @SortOrder = 'DESC' AND @SortColumn = 'CityName' THEN [CityName] END DESC,
                        CASE WHEN @SortOrder = 'ASC' AND @SortColumn = 'DepartmentName' THEN [DepartmentName] END ASC,
                        CASE WHEN @SortOrder = 'DESC' AND @SortColumn = 'DepartmentName' THEN [DepartmentName] END DESC
                    ) AS RowNo
                    FROM #Temp_FilteredUserData
                ) AS T
    WHERE       RowNo BETWEEN @Offset + 1 AND @Offset + @PageSize;

    -- Return paginated and sorted data
    SELECT      [ID],
                [UserCode],
                [FirstName],
                [LastName],
                [CityID],
                [CityName],
                [DepartmentID],
                [DepartmentName],
                [Permissions],
                [Modified],
                [ModifiedBy],
                [Created],
                [CreatedBy],
                @TotalRecords AS [TotalRecords]
    FROM        #Temp_SortedUsers
    ORDER BY    RowNo;

    -- Clean up temp tables
    DROP TABLE IF EXISTS #Temp_AllUserData;
    DROP TABLE IF EXISTS #Temp_FilteredUserData;
    DROP TABLE IF EXISTS #Temp_SortedUsers;
END;
