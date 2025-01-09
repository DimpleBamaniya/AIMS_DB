CREATE TABLE [dbo].[Products](
    [ID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NULL,
    [BrandID][int] NOT NULL,
	[Quantity] [int] NULL,
	[UseQuantity] [int] NULL,
	[AvailableQuantity] [int] NULL,
    [IsActive] [bit] NOT NULL,
    PRIMARY KEY CLUSTERED 
    (
        [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Products] 
ADD CONSTRAINT [DF_Products_UseQuantity] 
DEFAULT ((NULL)) FOR [UseQuantity]
GO

ALTER TABLE [dbo].[Products] 
ADD CONSTRAINT [DF_Products_AvailableQuantity] 
DEFAULT ((NULL)) FOR [AvailableQuantity]
GO

ALTER TABLE [dbo].[Products] 
ADD CONSTRAINT [DF_Products_IsActive] 
DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [FK_Products_BrandID] 
FOREIGN KEY ([BrandID]) 
REFERENCES [dbo].[Brands]([ID])

ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [FK_Products_CategoryID] 
FOREIGN KEY ([CategoryID]) 
REFERENCES [dbo].[Categories]([ID])

ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [UQ_Products_CategoryID_BrandID]
UNIQUE ([CategoryID], [BrandID]);

ALTER TABLE [dbo].[Products]
ADD [Code] VARCHAR(100) NULL; -- Adding 'Code' column as VARCHAR(100) with NULLABLE constraint

GO