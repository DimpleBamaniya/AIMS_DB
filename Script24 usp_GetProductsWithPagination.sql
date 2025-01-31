USE [AIMSV3]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetProductsWithPagination]    Script Date: 24-01-2025 19:09:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	EXEC [dbo].[usp_GetProductsWithPagination]
	@SearchString = '',
	@PageNo = 1,
	@PageSize = 1000,
	@SortColumn = 'ID',
	@SortOrder = 'ASC'
*/
ALTER       PROCEDURE [dbo].[usp_GetProductsWithPagination]
(
	@SearchString NVARCHAR(50),
	@PageNo INT = 1,
	@PageSize INT = 100,
	@SortColumn VARCHAR(50) = 'CategoryName',
	@SortOrder VARCHAR(20) = 'ASC'
)
AS
BEGIN	
	SET NOCOUNT ON;	

	DECLARE @Offset INT
	DECLARE @TotalRecords INT
		
    SET @SearchString = TRIM(ISNULL(@SearchString, ''));
	
	DROP TABLE IF EXISTS #Temp_AllProductData
	DROP TABLE IF EXISTS #Temp_FilteredProductData
	DROP TABLE IF EXISTS #Temp_SortedProducts

	SELECT  [P].[ID],
		[P].[Code],
		[P].[CategoryID],
		[P].[CategoryName],
		[P].[BrandID],
		[P].[BrandName],
		[P].[Quantity],
		[P].[UseQuantity],
		[P].[AvailableQuantity],
		[P].[Modified],
        [P].[ModifiedBy],
        [P].[Created],
        [P].[CreatedBy]
	  INTO	#Temp_AllProductData
  FROM [dbo].[vw_Products] As P

	SELECT  *
	INTO	#Temp_FilteredProductData
	FROM	[#Temp_AllProductData] 
	WHERE	(
		        @SearchString IS NULL 
				OR 
				@SearchString = '' 
				OR 
				[CategoryName] LIKE '%' + @SearchString + '%'
				OR
				[BrandName] LIKE '%' + @SearchString + '%'
			)

	SELECT	@TotalRecords = COUNT(1) 
	FROM	[#Temp_FilteredProductData]

	SET @Offset = ((@PageNo - 1) * @PageSize)

	SELECT		[P].*,
				IDENTITY(INT,1,1) AS [RowNo]
	INTO		[#Temp_SortedProducts]
	FROM		[#Temp_FilteredProductData] P
	ORDER BY	CASE WHEN (@SortColumn = 'ID' AND @SortOrder = 'ASC') THEN [P].[ID] END ASC,
				CASE WHEN (@SortColumn = 'ID' AND @SortOrder = 'DESC') THEN [P].[ID] END DESC,
				CASE WHEN (@SortColumn = 'CategoryName' AND @SortOrder = 'ASC') THEN [P].[CategoryName] END ASC,
				CASE WHEN (@SortColumn = 'CategoryName' AND @SortOrder = 'DESC') THEN [P].[CategoryName] END DESC,
				CASE WHEN (@SortColumn = 'Code' AND @SortOrder = 'ASC') THEN [P].[Code] END ASC,
				CASE WHEN (@SortColumn = 'Code' AND @SortOrder = 'DESC') THEN [P].[Code] END DESC,
				CASE WHEN (@SortColumn = 'BrandName' AND @SortOrder = 'ASC') THEN [P].[BrandName] END ASC,
				CASE WHEN (@SortColumn = 'BrandName' AND @SortOrder = 'DESC') THEN [P].[BrandName] END DESC,
				[P].[ID]
	OFFSET @Offset ROWS    
    FETCH NEXT @PageSize ROWS ONLY 

	SELECT  [P].[ID],
			[P].[Code],
			[P].[CategoryID],
			[P].[CategoryName],
			[P].[BrandID],
			[P].[BrandName],
			[P].[Quantity],
			[P].[UseQuantity],
			[P].[AvailableQuantity],
			[P].[Modified],
			[P].[ModifiedBy],
			[P].[Created],
			[P].[CreatedBy],
				@TotalRecords AS [TotalRecords]		
	FROM		[#Temp_SortedProducts] P
	ORDER BY	[RowNo]
END
------