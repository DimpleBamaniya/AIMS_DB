USE [AIMSV3]
GO

-- Create the Cities table
CREATE TABLE [dbo].[Cities] (
    [ID] INT IDENTITY(1,1) NOT NULL,       -- Auto-incrementing ID
    [Name] VARCHAR(100) NOT NULL,         -- Name of the city
    [IsActive] BIT NOT NULL DEFAULT (1),  -- IsActive with default value true
    CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED ([ID] ASC), -- Primary key on ID
    CONSTRAINT [UQ_Cities_Name] UNIQUE ([Name])              -- Unique constraint on Name
) ON [PRIMARY];
GO

---- Insert a Gujarat city (example: Ahmedabad)
INSERT INTO [dbo].[Cities] ([Name]) VALUES ('Ahmedabad'),('Amreli'),('Anand'),('Arvalli'),('Banas Kantha'),('Bharuch'),('Bhavnagar'),('Botad'),('Chhota Udepur'),('Devbhoomi Dwarka'),('Dohad'),('Gandhinagar'),('Gir Somnath'),('Jamnagar'),('Junagadh'),('Kachchh'),
('Kheda'),('Mahesana'),('Mahisagar'),('Morbi'),('Narmada'),('Navsari'),('Panch Mahals'),('Patan'),('Porbandar'),('Rajkot'),('Sabar Kantha'),('Surat'),('Surendranagar'),('Tapi'),('Dangs'),('Vadodara'),('Valsad');
--GO
