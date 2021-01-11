-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 24, 2020 at 08:29 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bloodbank`
--
-- --------------------------------------------------------

--
-- Table structure for table `hospitals`
--

CREATE TABLE `hospitals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hname` varchar(100) NOT NULL,
  `hemail` varchar(100) NOT NULL,
  `hpassword` varchar(100) NOT NULL,
  `hphone` varchar(100) NOT NULL,
  `hcity` varchar(100) NOT NULL,
  `haccepted` int(11) NOT NULL DEFAULT 0,
  `hrejected` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hemail` (`hemail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hospitals`
--

INSERT INTO `hospitals` (`hname`, `hemail`, `hpassword`, `hphone`, `hcity`) VALUES
('Gandhi hospital', 'gandhi@gmail.com', 'gandhi', '7865376358', 'Delhi'),
('Bangalore hospital', 'unknown@gmail.com', 'unknown', '9876543267', 'unknown');

-- --------------------------------------------------------

--
-- Table structure for table `receivers`
--

CREATE TABLE `receivers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rname` varchar(100) NOT NULL,
  `remail` varchar(100) NOT NULL,
  `rpassword` varchar(100) NOT NULL,
  `rphone` varchar(100) NOT NULL,
  `rbg` varchar(10) NOT NULL,
  `rcity` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `remail` (`remail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `receivers`
--

INSERT INTO `receivers` (`rname`, `remail`, `rpassword`, `rphone`, `rbg`, `rcity`) VALUES
('test', 'test@gmail.com', 'test', '8875643456', 'A+', 'lucknow'),
('xyz', 'xyz@gmail.com', 'xyz', '8875643456', 'AB+', 'Punjab');

-- --------------------------------------------------------

--
-- Table structure for table `bloodinfo`
--

CREATE TABLE `bloodinfo` (
  `bid` int(11) NOT NULL AUTO_INCREMENT,
  `hid` int(11) NOT NULL,
  `bg` varchar(10) NOT NULL,
  PRIMARY KEY (`bid`),
  KEY `hid` (`hid`),
  CONSTRAINT `bloodinfo_ibfk_1` FOREIGN KEY (`hid`) REFERENCES `hospitals` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bloodinfo`
--

INSERT INTO `bloodinfo` (`hid`, `bg`) VALUES
(1, 'B+'),
(2, 'A+');

-- --------------------------------------------------------

--
-- Table structure for table `bloodrequest`
--

CREATE TABLE `bloodrequest` (
  `reqid` int(11) NOT NULL AUTO_INCREMENT,
  `hid` int(11) NOT NULL,
  `rid` int(11) NOT NULL,
  `bg` varchar(11) NOT NULL,
  `status` varchar(100) NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`reqid`),
  KEY `hid` (`hid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bloodrequest`
--

INSERT INTO `bloodrequest` (`hid`, `rid`, `bg`, `status`) VALUES
(1, 1, 'B+', 'Pending'),
(1, 2, 'B+', 'Pending');

-- 
-- Triggers
-- 
DELIMITER //

CREATE TRIGGER Accepttrigger 
AFTER UPDATE ON bloodrequest
FOR EACH ROW
BEGIN
	IF NEW.status = 'Accepted' THEN
		UPDATE hospitals
     	SET haccepted = haccepted+1
     	WHERE id = NEW.hid;
    END IF;
END; //

DELIMITER ;


DELIMITER //

CREATE TRIGGER RejectTrigger 
AFTER UPDATE ON bloodrequest
FOR EACH ROW
BEGIN
	IF NEW.status = 'Rejected' THEN
		UPDATE hospitals
     	SET hrejected = hrejected+1
     	WHERE id = NEW.hid;
    END IF;
END; //

DELIMITER ;
--
-- Indexes for dumped tables
--

--
-- Indexes for table `bloodinfo`
--
-- ALTER TABLE `bloodinfo`
--   ADD PRIMARY KEY (`bid`),
--   ADD KEY `hid` (`hid`);

--
-- Indexes for table `bloodrequest`
--
-- ALTER TABLE `bloodrequest`
--   ADD PRIMARY KEY (`reqid`),
--   ADD KEY `hid` (`hid`);

--
-- Indexes for table `hospitals`
--
-- ALTER TABLE `hospitals`
--   ADD PRIMARY KEY (`id`),
--   ADD UNIQUE KEY `hemail` (`hemail`);

--
-- Indexes for table `receivers`
--
-- ALTER TABLE `receivers`
--   ADD PRIMARY KEY (`id`),
--   ADD UNIQUE KEY `remail` (`remail`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bloodinfo`
--
-- ALTER TABLE `bloodinfo`
--   MODIFY `bid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `bloodrequest`
--
-- ALTER TABLE `bloodrequest`
--   MODIFY `reqid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `hospitals`
--
-- ALTER TABLE `hospitals`
--   MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `receivers`
--
-- ALTER TABLE `receivers`
--   MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bloodinfo`
--
-- ALTER TABLE `bloodinfo`
--   ADD CONSTRAINT `bloodinfo_ibfk_1` FOREIGN KEY (`hid`) REFERENCES `hospitals` (`id`);
-- COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
