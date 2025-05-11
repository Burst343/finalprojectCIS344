SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `pharmacy_portal_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `pharmacy_portal_db`;

DROP TABLE IF EXISTS `inventory`;
CREATE TABLE IF NOT EXISTS `inventory` (
  `inventoryId` int(11) NOT NULL AUTO_INCREMENT,
  `medicationId` int(11) NOT NULL,
  `quantityAvailable` int(11) NOT NULL,
  `lastUpdated` datetime NOT NULL,
  PRIMARY KEY (`inventoryId`),
  UNIQUE KEY `inventoryId` (`inventoryId`),
  KEY `medicationId` (`medicationId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `inventory` (`inventoryId`, `medicationId`, `quantityAvailable`, `lastUpdated`) VALUES
(1, 1, 86, '2025-05-10 21:55:25'),
(2, 2, 145, '2025-05-11 03:07:49'),
(3, 3, 50, '2025-05-11 00:17:39');
DROP VIEW IF EXISTS `medicationinventoryview`;
CREATE TABLE IF NOT EXISTS `medicationinventoryview` (
`medicationId` int(11)
,`medicationName` varchar(45)
,`dosage` varchar(45)
,`manufacturer` varchar(100)
,`currentInventory` int(11)
,`inventoryLastUpdated` datetime
);

DROP TABLE IF EXISTS `medications`;
CREATE TABLE IF NOT EXISTS `medications` (
  `medicationId` int(11) NOT NULL AUTO_INCREMENT,
  `medicationName` varchar(45) NOT NULL,
  `dosage` varchar(45) NOT NULL,
  `manufacturer` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`medicationId`),
  UNIQUE KEY `medicationId` (`medicationId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `medications` (`medicationId`, `medicationName`, `dosage`, `manufacturer`) VALUES
(1, 'Aspirin', '500mg', 'Bayer'),
(2, 'Ibuprofen', '200mg', 'Advil'),
(3, 'Amoxicillin', '250mg', 'GSK');

DROP TABLE IF EXISTS `prescriptions`;
CREATE TABLE IF NOT EXISTS `prescriptions` (
  `prescriptionId` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `medicationId` int(11) NOT NULL,
  `prescribedDate` datetime NOT NULL,
  `dosageInstructions` varchar(200) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `refillCount` int(11) DEFAULT 0,
  PRIMARY KEY (`prescriptionId`),
  UNIQUE KEY `prescriptionId` (`prescriptionId`),
  KEY `userId` (`userId`),
  KEY `medicationId` (`medicationId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `prescriptions` (`prescriptionId`, `userId`, `medicationId`, `prescribedDate`, `dosageInstructions`, `quantity`, `refillCount`) VALUES
(1, 2, 1, '2025-05-10 00:32:15', 'Take 1 tablet daily', 30, 1),
(2, 3, 2, '2025-05-10 00:32:15', 'Take 2 tablets daily', 60, 2),
(3, 3, 3, '2025-05-10 00:32:15', 'Take 1 capsule daily', 10, 0),
(7, 2, 1, '2025-05-11 02:48:43', 'take daily for a week', 7, 1),
(8, 2, 1, '2025-05-11 03:55:06', '2 a day', 14, 1),
(9, 6, 3, '0000-00-00 00:00:00', 'Take 4 a day', 20, 0),
(10, 6, 3, '0000-00-00 00:00:00', 'Take 4 a day', 20, 0),
(11, 6, 2, '0000-00-00 00:00:00', 'TAKE 1', 5, 0);
DROP TRIGGER IF EXISTS `afterPrescriptionInsert`;
DELIMITER $$
CREATE TRIGGER `afterPrescriptionInsert` AFTER INSERT ON `prescriptions` FOR EACH ROW UPDATE inventory 
    SET quantityAvailable = quantityAvailable - NEW.quantity,
        lastUpdated = NOW()
    WHERE medicationId = NEW.medicationId
$$
DELIMITER ;

DROP TABLE IF EXISTS `sales`;
CREATE TABLE IF NOT EXISTS `sales` (
  `saleId` int(11) NOT NULL AUTO_INCREMENT,
  `prescriptionId` int(11) NOT NULL,
  `saleDate` datetime NOT NULL,
  `quantitySold` int(11) NOT NULL,
  `saleAmount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`saleId`),
  UNIQUE KEY `saleId` (`saleId`),
  KEY `prescriptionId` (`prescriptionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(45) NOT NULL,
  `contactInfo` varchar(200) DEFAULT NULL,
  `userType` enum('pharmacist','patient') NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `userId` (`userId`),
  UNIQUE KEY `userName` (`userName`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `users` (`userId`, `userName`, `contactInfo`, `userType`, `password`) VALUES
(1, 'JohnDoe', 'john@example.com', 'pharmacist', 'password123'),
(2, 'JaneSmith', 'jane@example.com', 'patient', 'password123'),
(3, 'AliceBrown', 'alice@example.com', 'patient', 'password123'),
(6, 'Mohamedsillah', 'mohamed@example.com', 'patient', 'water');
DROP TABLE IF EXISTS `medicationinventoryview`;

DROP VIEW IF EXISTS `medicationinventoryview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `medicationinventoryview`  AS SELECT `medications`.`medicationId` AS `medicationId`, `medications`.`medicationName` AS `medicationName`, `medications`.`dosage` AS `dosage`, `medications`.`manufacturer` AS `manufacturer`, `inventory`.`quantityAvailable` AS `currentInventory`, `inventory`.`lastUpdated` AS `inventoryLastUpdated` FROM (`medications` join `inventory` on(`medications`.`medicationId` = `inventory`.`medicationId`)) ;


ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`medicationId`) REFERENCES `medications` (`medicationId`);

ALTER TABLE `prescriptions`
  ADD CONSTRAINT `prescriptions_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`),
  ADD CONSTRAINT `prescriptions_ibfk_2` FOREIGN KEY (`medicationId`) REFERENCES `medications` (`medicationId`);

ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`prescriptionId`) REFERENCES `prescriptions` (`prescriptionId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
