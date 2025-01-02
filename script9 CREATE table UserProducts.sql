CREATE TABLE UserProducts (
    ID INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incrementing unique ID for each assignment
    UserID INT NOT NULL,                          -- Foreign key referencing the Users table
    ProductID INT NOT NULL,                       -- Foreign key referencing the Products table
    AssignedDate DATE NOT NULL DEFAULT GETDATE(), -- Timestamp of the assignment
    FOREIGN KEY (UserID) REFERENCES Users(ID) ON DELETE CASCADE,   -- Foreign key constraint on UserID
    FOREIGN KEY (ProductID) REFERENCES Products(ID) ON DELETE CASCADE, -- Foreign key constraint on ProductID
    CONSTRAINT UQ_UserProduct UNIQUE (UserID, ProductID)  -- Unique constraint on UserID and ProductID
);
