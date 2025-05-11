create database pharmacy_portal_db;
USE pharmacy_portal_db;
CREATE TABLE Users (
    userId INT NOT NULL UNIQUE AUTO_INCREMENT,
    userName VARCHAR(45) NOT NULL UNIQUE,
    contactInfo VARCHAR(200),
    userType ENUM('pharmacist', 'patient') NOT NULL,
    PRIMARY KEY (userId)
);
CREATE TABLE  Medications (
    medicationId INT NOT NULL UNIQUE AUTO_INCREMENT,
    medicationName VARCHAR(45) NOT NULL,
    dosage VARCHAR(45) NOT NULL,
    manufacturer VARCHAR(100),
    PRIMARY KEY (medicationId)
);

CREATE TABLE  Prescriptions (
    prescriptionId INT NOT NULL UNIQUE AUTO_INCREMENT,
    userId INT NOT NULL,
    medicationId INT NOT NULL,
    prescribedDate DATETIME NOT NULL,
    dosageInstructions VARCHAR(200),
    quantity INT NOT NULL,
    refillCount INT DEFAULT 0,
    PRIMARY KEY (prescriptionId),
    FOREIGN KEY (userId) REFERENCES Users(userId),
    FOREIGN KEY (medicationId) REFERENCES Medications(medicationId)
);

CREATE TABLE Inventory (
    inventoryId INT NOT NULL UNIQUE AUTO_INCREMENT,
    medicationId INT NOT NULL,
    quantityAvailable INT NOT NULL,
    lastUpdated DATETIME NOT NULL,
    PRIMARY KEY (inventoryId),
    FOREIGN KEY (medicationId) REFERENCES Medications(medicationId)
);

CREATE TABLE Sales (
    saleId INT NOT NULL UNIQUE AUTO_INCREMENT,
    prescriptionId INT NOT NULL,
    saleDate DATETIME NOT NULL,
    quantitySold INT NOT NULL,
    saleAmount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (saleId),
    FOREIGN KEY (prescriptionId) REFERENCES Prescriptions(prescriptionId)
);

INSERT INTO Users (userName, contactInfo, userType, password) VALUES
('JohnDoe', 'john@example.com', 'pharmacist', 'password123'),
('JaneSmith', 'jane@example.com', 'patient', 'password123'),
('AliceBrown', 'alice@example.com', 'patient', 'password123');

INSERT INTO Medications (medicationName, dosage, manufacturer) VALUES
('Aspirin', '500mg', 'Bayer'),
('Ibuprofen', '200mg', 'Advil'),
('Amoxicillin', '250mg', 'GSK');

INSERT INTO Inventory (medicationId, quantityAvailable, lastUpdated) VALUES
(1, 100, NOW()),
(2, 150, NOW()),
(3, 50, NOW());

INSERT INTO Prescriptions (userId, medicationId, prescribedDate, dosageInstructions, quantity, refillCount) VALUES
(2, 1, NOW(), 'Take 1 tablet daily', 30, 1),
(3, 2, NOW(), 'Take 2 tablets daily', 60, 2),
(3, 3, NOW(), 'Take 1 capsule daily', 10, 0);



    