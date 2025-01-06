-- Insert the data
INSERT INTO Users (FirstName, LastName, EmailID, PassWord, CityID, DepartmentID, Created, CreatedBy)
VALUES 
    ('Shital', 'Bamaniya', 'Shital@123', 'Shital@123', 25, 1, GETDATE(), 1),
    ('Pallavi', 'Chavda', 'Pallavi@123', 'Pallavi@123', 3, 2, GETDATE(), 1),
    ('Lekha', 'Raval', 'Lekha@123', 'Lekha@123', 1, 4, GETDATE(), 1),
    ('Aarti', 'Tita', 'Aarti@123', 'Aarti@123', 18, 5, GETDATE(), 1),
    ('Kavita', 'Adatiya', 'Kavita@123', 'Kavita@123', 15, 12, GETDATE(), 1),
    ('Tanvi', 'Tita', 'Tanvi@123', 'Tanvi@123', 25, 12, GETDATE(), 1);

-- Update the UserCode column based on the generated ID
UPDATE Users
SET UserCode = CONCAT('AIMS', RIGHT('00' + CAST(ID AS VARCHAR), 2))
WHERE UserCode IS NULL; -- Ensures only new rows are updated
