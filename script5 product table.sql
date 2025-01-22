USE [AIMSV3]
GO

/****** Object:  Table [dbo].[Products]    Script Date: 22-01-2025 17:30:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Products](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NULL,
	[BrandID] [int] NOT NULL,
	[Quantity] [int] NULL,
	[UseQuantity] [int] NULL,
	[AvailableQuantity] [int] NULL,
	[Code] [varchar](100) NULL,
	[Created] [date] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Modified] [date] NULL,
	[ModifiedBy] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted] [date] NULL,
	[DeletedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_UseQuantity]  DEFAULT (NULL) FOR [UseQuantity]
GO

ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_AvailableQuantity]  DEFAULT (NULL) FOR [AvailableQuantity]
GO

ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO

ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_BrandID] FOREIGN KEY([BrandID])
REFERENCES [dbo].[Brands] ([ID])
GO

ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_BrandID]
GO

ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_CategoryID] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([ID])
GO

ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_CategoryID]
GO


