-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 04, 2024 at 05:08 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `airlinedb`
--

-- --------------------------------------------------------

--
-- Table structure for table `airline`
--

CREATE TABLE `airline` (
  `airline_id` int(11) NOT NULL,
  `airline_name` varchar(100) NOT NULL,
  `country` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `airplane`
--

CREATE TABLE `airplane` (
  `airplane_id` int(11) NOT NULL,
  `model` varchar(50) NOT NULL,
  `capacity` int(11) NOT NULL,
  `airline_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `airport`
--

CREATE TABLE `airport` (
  `airport_id` int(11) NOT NULL,
  `airport_name` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `IATA_code` char(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `airport_maintenance`
--

CREATE TABLE `airport_maintenance` (
  `maintenance_id` int(11) NOT NULL,
  `airport_id` int(11) NOT NULL,
  `service_type` enum('Runway Check','Fueling','Technical Inspection') NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `status` varchar(20) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `airport_security`
--

CREATE TABLE `airport_security` (
  `security_id` int(11) NOT NULL,
  `airport_id` int(11) NOT NULL,
  `security_type` varchar(50) NOT NULL,
  `staff_count` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `last_inspection_date` date NOT NULL,
  `next_inspection_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `co_pilot`
--

CREATE TABLE `co_pilot` (
  `crew_id` int(11) NOT NULL,
  `license_number` varchar(50) NOT NULL,
  `flight_hours` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `crew`
--

CREATE TABLE `crew` (
  `crew_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `date_of_birth` date NOT NULL,
  `role` enum('Pilot','Co-Pilot','Flight Attendant') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `crew_assignment`
--

CREATE TABLE `crew_assignment` (
  `schedule_id` int(11) NOT NULL,
  `flight_id` int(11) NOT NULL,
  `crew_id` int(11) NOT NULL,
  `shift_start` datetime NOT NULL,
  `shift_end` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flight`
--

CREATE TABLE `flight` (
  `flight_id` int(11) NOT NULL,
  `flight_number` varchar(20) NOT NULL,
  `departure_time` datetime NOT NULL,
  `arrival_time` datetime NOT NULL,
  `status` varchar(30) NOT NULL,
  `route_id` int(11) DEFAULT NULL,
  `airplane_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flight_attendant`
--

CREATE TABLE `flight_attendant` (
  `crew_id` int(11) NOT NULL,
  `training_certification` varchar(50) NOT NULL,
  `languages_spoken` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flight_status`
--

CREATE TABLE `flight_status` (
  `status_id` int(11) NOT NULL,
  `flight_id` int(11) NOT NULL,
  `status_update` varchar(20) NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `reason` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `medical_assistance`
--

CREATE TABLE `medical_assistance` (
  `medical_team_id` int(11) NOT NULL,
  `team_lead` varchar(100) NOT NULL,
  `service_type` enum('Emergency Response','First Aid','Health Checks') NOT NULL,
  `availability_status` enum('Available','Engaged') NOT NULL,
  `response_time` int(11) NOT NULL,
  `airport_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pilot`
--

CREATE TABLE `pilot` (
  `crew_id` int(11) NOT NULL,
  `license_number` varchar(50) NOT NULL,
  `flight_hours` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `route`
--

CREATE TABLE `route` (
  `route_id` int(11) NOT NULL,
  `origin_airport_id` int(11) NOT NULL,
  `destination_airport_id` int(11) NOT NULL,
  `distance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `airline`
--
ALTER TABLE `airline`
  ADD PRIMARY KEY (`airline_id`);

--
-- Indexes for table `airplane`
--
ALTER TABLE `airplane`
  ADD PRIMARY KEY (`airplane_id`),
  ADD KEY `airline_id` (`airline_id`);

--
-- Indexes for table `airport`
--
ALTER TABLE `airport`
  ADD PRIMARY KEY (`airport_id`),
  ADD UNIQUE KEY `IATA_code` (`IATA_code`);

--
-- Indexes for table `airport_maintenance`
--
ALTER TABLE `airport_maintenance`
  ADD PRIMARY KEY (`maintenance_id`),
  ADD KEY `airport_id` (`airport_id`);

--
-- Indexes for table `airport_security`
--
ALTER TABLE `airport_security`
  ADD PRIMARY KEY (`security_id`),
  ADD KEY `airport_id` (`airport_id`);

--
-- Indexes for table `co_pilot`
--
ALTER TABLE `co_pilot`
  ADD PRIMARY KEY (`crew_id`),
  ADD UNIQUE KEY `license_number` (`license_number`);

--
-- Indexes for table `crew`
--
ALTER TABLE `crew`
  ADD PRIMARY KEY (`crew_id`);

--
-- Indexes for table `crew_assignment`
--
ALTER TABLE `crew_assignment`
  ADD PRIMARY KEY (`schedule_id`),
  ADD UNIQUE KEY `flight_id` (`flight_id`,`crew_id`),
  ADD KEY `crew_id` (`crew_id`);

--
-- Indexes for table `flight`
--
ALTER TABLE `flight`
  ADD PRIMARY KEY (`flight_id`),
  ADD UNIQUE KEY `flight_number` (`flight_number`),
  ADD KEY `route_id` (`route_id`),
  ADD KEY `airplane_id` (`airplane_id`);

--
-- Indexes for table `flight_attendant`
--
ALTER TABLE `flight_attendant`
  ADD PRIMARY KEY (`crew_id`);

--
-- Indexes for table `flight_status`
--
ALTER TABLE `flight_status`
  ADD PRIMARY KEY (`status_id`),
  ADD KEY `flight_id` (`flight_id`);

--
-- Indexes for table `medical_assistance`
--
ALTER TABLE `medical_assistance`
  ADD PRIMARY KEY (`medical_team_id`),
  ADD KEY `airport_id` (`airport_id`);

--
-- Indexes for table `pilot`
--
ALTER TABLE `pilot`
  ADD PRIMARY KEY (`crew_id`),
  ADD UNIQUE KEY `license_number` (`license_number`);

--
-- Indexes for table `route`
--
ALTER TABLE `route`
  ADD PRIMARY KEY (`route_id`),
  ADD UNIQUE KEY `origin_airport_id` (`origin_airport_id`,`destination_airport_id`),
  ADD KEY `destination_airport_id` (`destination_airport_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `airline`
--
ALTER TABLE `airline`
  MODIFY `airline_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `airplane`
--
ALTER TABLE `airplane`
  MODIFY `airplane_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `airport`
--
ALTER TABLE `airport`
  MODIFY `airport_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `airport_maintenance`
--
ALTER TABLE `airport_maintenance`
  MODIFY `maintenance_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `airport_security`
--
ALTER TABLE `airport_security`
  MODIFY `security_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `crew`
--
ALTER TABLE `crew`
  MODIFY `crew_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `crew_assignment`
--
ALTER TABLE `crew_assignment`
  MODIFY `schedule_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flight`
--
ALTER TABLE `flight`
  MODIFY `flight_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flight_status`
--
ALTER TABLE `flight_status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `medical_assistance`
--
ALTER TABLE `medical_assistance`
  MODIFY `medical_team_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `route`
--
ALTER TABLE `route`
  MODIFY `route_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `airplane`
--
ALTER TABLE `airplane`
  ADD CONSTRAINT `airplane_ibfk_1` FOREIGN KEY (`airline_id`) REFERENCES `airline` (`airline_id`) ON DELETE SET NULL;

--
-- Constraints for table `airport_maintenance`
--
ALTER TABLE `airport_maintenance`
  ADD CONSTRAINT `airport_maintenance_ibfk_1` FOREIGN KEY (`airport_id`) REFERENCES `airport` (`airport_id`) ON DELETE CASCADE;

--
-- Constraints for table `airport_security`
--
ALTER TABLE `airport_security`
  ADD CONSTRAINT `airport_security_ibfk_1` FOREIGN KEY (`airport_id`) REFERENCES `airport` (`airport_id`) ON DELETE CASCADE;

--
-- Constraints for table `co_pilot`
--
ALTER TABLE `co_pilot`
  ADD CONSTRAINT `co_pilot_ibfk_1` FOREIGN KEY (`crew_id`) REFERENCES `crew` (`crew_id`) ON DELETE CASCADE;

--
-- Constraints for table `crew_assignment`
--
ALTER TABLE `crew_assignment`
  ADD CONSTRAINT `crew_assignment_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`flight_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `crew_assignment_ibfk_2` FOREIGN KEY (`crew_id`) REFERENCES `crew` (`crew_id`) ON DELETE CASCADE;

--
-- Constraints for table `flight`
--
ALTER TABLE `flight`
  ADD CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`route_id`) REFERENCES `route` (`route_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`airplane_id`) REFERENCES `airplane` (`airplane_id`) ON DELETE SET NULL;

--
-- Constraints for table `flight_attendant`
--
ALTER TABLE `flight_attendant`
  ADD CONSTRAINT `flight_attendant_ibfk_1` FOREIGN KEY (`crew_id`) REFERENCES `crew` (`crew_id`) ON DELETE CASCADE;

--
-- Constraints for table `flight_status`
--
ALTER TABLE `flight_status`
  ADD CONSTRAINT `flight_status_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`flight_id`) ON DELETE CASCADE;

--
-- Constraints for table `medical_assistance`
--
ALTER TABLE `medical_assistance`
  ADD CONSTRAINT `medical_assistance_ibfk_1` FOREIGN KEY (`airport_id`) REFERENCES `airport` (`airport_id`) ON DELETE CASCADE;

--
-- Constraints for table `pilot`
--
ALTER TABLE `pilot`
  ADD CONSTRAINT `pilot_ibfk_1` FOREIGN KEY (`crew_id`) REFERENCES `crew` (`crew_id`) ON DELETE CASCADE;

--
-- Constraints for table `route`
--
ALTER TABLE `route`
  ADD CONSTRAINT `route_ibfk_1` FOREIGN KEY (`origin_airport_id`) REFERENCES `airport` (`airport_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `route_ibfk_2` FOREIGN KEY (`destination_airport_id`) REFERENCES `airport` (`airport_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
