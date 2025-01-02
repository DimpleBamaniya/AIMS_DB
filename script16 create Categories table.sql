CREATE TABLE [dbo].[Categories] (
    ID INT IDENTITY(1,1) PRIMARY KEY,         -- Auto-increment ID, primary key
    Name NVARCHAR(150) NOT NULL,              -- Category name, with a maximum length of 150 characters
    IsActive BIT NOT NULL DEFAULT 1,          -- Active status, using BIT (boolean) type, default to 1 (true)
    Created DATE NOT NULL DEFAULT GETDATE()   -- Created date, default to the current date
);
