USE [AIMSV3]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetUsersWithPagination]    Script Date: 23-01-2025 14:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

Exec usp_GetUsersWithPagination @SearchString = '',@PageNo=1,@PageSize=10,@SortColumn='id',@SortOrder='ASC'

*/

ALTER PROCEDURE [dbo].[usp_GetUsersWithPagination]
(
    @SearchString NVARCHAR(50),
    @PageNo INT = 1,
    @PageSize INT = 10,
    @SortColumn VARCHAR(50) = 'ID',
    @SortOrder VARCHAR(20) = 'ASC'
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT;
    DECLARE @TotalRecords INT;

    SET @SearchString = TRIM(ISNULL(@SearchString, ''));

    DROP TABLE IF EXISTS #Temp_AllUserData, #Temp_FilteredUserData, #Temp_SortedUsers;

    SELECT      
        U.[ID],
        U.[UserCode],
        U.[FirstName],
        U.[LastName],
        U.[Permissions],
        U.[Modified],
        U.[ModifiedBy],
        U.[Created],
        U.[CreatedBy],
        D.[Id] AS DepartmentID,
        D.[Name] AS DepartmentName,
        C.[ID] AS CityID,
        C.[Name] AS CityName
    INTO        #Temp_AllUserData
    FROM        [dbo].[vw_Users] U
    LEFT JOIN   Departments D ON U.DepartmentID = D.Id
    LEFT JOIN   Cities C ON U.CityID = C.Id;

    SELECT *
    INTO   #Temp_FilteredUserData
    FROM   #Temp_AllUserData
    WHERE  @SearchString IS NULL OR @SearchString = ''
           OR [FirstName] LIKE '%' + @SearchString + '%'
           OR [LastName] LIKE '%' + @SearchString + '%'
           OR [CityName] LIKE '%' + @SearchString + '%'
           OR [DepartmentName] LIKE '%' + @SearchString + '%'
           OR [UserCode] LIKE '%' + @SearchString + '%';

    SELECT @TotalRecords = COUNT(1) 
    FROM #Temp_FilteredUserData;

    SET @Offset = (@PageNo - 1) * @PageSize;

    SELECT *, ROW_NUMBER() OVER (
        ORDER BY
        CASE WHEN @SortColumn = 'ID' AND @SortOrder = 'ASC' THEN ID END ASC,
        CASE WHEN @SortColumn = 'ID' AND @SortOrder = 'DESC' THEN ID END DESC,
        CASE WHEN @SortColumn = 'UserCode' AND @SortOrder = 'ASC' THEN UserCode END ASC,
        CASE WHEN @SortColumn = 'UserCode' AND @SortOrder = 'DESC' THEN UserCode END DESC
    ) AS RowNo
    INTO #Temp_SortedUsers
    FROM #Temp_FilteredUserData;

    SELECT *
    FROM #Temp_SortedUsers
    WHERE RowNo BETWEEN @Offset + 1 AND @Offset + @PageSize;

    DROP TABLE IF EXISTS #Temp_AllUserData, #Temp_FilteredUserData, #Temp_SortedUsers;
END;
