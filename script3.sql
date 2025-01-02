CREATE TABLE [dbo].[Models](
    [ID] [int] IDENTITY(1,1) NOT NULL,
	[name][varchar](255) NULL,
	[Value] [int] null,
     [BrandID][int] NOT NULL,
    [IsActive] [bit] NOT NULL,
    PRIMARY KEY CLUSTERED 
    (
        [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Models] 
ADD CONSTRAINT [DF_Models_IsActive] 
DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[Models]
ADD CONSTRAINT [FK_Models_BrandID] 
FOREIGN KEY ([BrandID]) 
REFERENCES [dbo].[Brands]([ID])
GO