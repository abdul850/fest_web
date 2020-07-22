-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 06, 2019 at 11:08 AM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fest`
--

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `Event_ID` int(11) NOT NULL,
  `EvType_ID` int(11) NOT NULL,
  `EvName` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `Date` date NOT NULL,
  `StartTime` time NOT NULL,
  `EndTime` time NOT NULL,
  `P_Fees` int(11) NOT NULL,
  `Prize` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`Event_ID`, `EvType_ID`, `EvName`, `Date`, `StartTime`, `EndTime`, `P_Fees`, `Prize`) VALUES
(1, 1, 'Cadd Designing', '2019-03-30', '13:00:00', '15:00:00', 100, 10000),
(2, 1, 'Capture The Flag', '2019-03-30', '14:00:00', '15:00:00', 100, 2000),
(3, 1, 'Code Relay', '2019-03-30', '15:00:00', '17:00:00', 100, 15000),
(4, 1, 'Hackathon', '2019-03-30', '13:00:00', '17:00:00', 100, 15000),
(5, 1, 'Line Follower', '2019-03-30', '16:00:00', '18:00:00', 100, 3000),
(6, 2, 'Arm Wrestling', '2019-03-29', '15:00:00', '17:00:00', 50, 1000),
(7, 2, 'Bridge Building', '2019-03-29', '13:00:00', '15:00:00', 50, 2000),
(8, 2, 'Gully Cricket', '2019-03-29', '10:00:00', '17:00:00', 50, 10000),
(9, 2, 'City Tycoon', '2019-03-29', '13:00:00', '16:00:00', 50, 3000),
(10, 2, 'Face Painting', '2019-03-29', '14:00:00', '15:00:00', 50, 1500),
(11, 3, 'Creative Writing', '2019-03-31', '12:00:00', '14:00:00', 75, 1000),
(12, 3, 'Tarz E Libas', '2019-03-31', '14:00:00', '15:00:00', 75, 10000),
(13, 3, 'Nritya', '2019-03-31', '14:00:00', '17:00:00', 75, 5000),
(14, 3, 'General Quiz', '2019-03-31', '15:00:00', '16:00:00', 75, 2000),
(15, 3, 'Talent Hunt', '2019-03-31', '15:00:00', '18:00:00', 75, 4000);

-- --------------------------------------------------------

--
-- Table structure for table `event_type`
--

CREATE TABLE `event_type` (
  `EvType_ID` int(11) NOT NULL,
  `Category` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `event_type`
--

INSERT INTO `event_type` (`EvType_ID`, `Category`) VALUES
(3, 'CULTURAL'),
(2, 'NON TECHNICAL'),
(1, 'TECHNICAL');

-- --------------------------------------------------------

--
-- Table structure for table `fm_team`
--

CREATE TABLE `fm_team` (
  `M_ID` int(11) NOT NULL,
  `User_ID` int(11) NOT NULL,
  `Event_ID` int(11) NOT NULL,
  `Role` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fm_team`
--

INSERT INTO `fm_team` (`M_ID`, `User_ID`, `Event_ID`, `Role`) VALUES
(1, 1, 1, 'c'),
(2, 2, 2, 'v'),
(3, 3, 3, 'p');

-- --------------------------------------------------------

--
-- Table structure for table `p_single`
--

CREATE TABLE `p_single` (
  `P_ID` int(11) NOT NULL,
  `Event_ID` int(11) NOT NULL,
  `User_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `p_single`
--

INSERT INTO `p_single` (`P_ID`, `Event_ID`, `User_ID`) VALUES
(1, 1, 1),
(2, 6, 2),
(3, 11, 3);

-- --------------------------------------------------------

--
-- Table structure for table `p_team`
--

CREATE TABLE `p_team` (
  `Team_ID` int(11) NOT NULL,
  `P1_ID` int(11) NOT NULL,
  `P2_ID` int(11) NOT NULL,
  `P3_ID` int(11) DEFAULT NULL,
  `P4_ID` int(11) DEFAULT NULL,
  `Event_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `p_team`
--

INSERT INTO `p_team` (`Team_ID`, `P1_ID`, `P2_ID`, `P3_ID`, `P4_ID`, `Event_ID`) VALUES
(1, 1, 2, 3, 4, 1),
(2, 5, 6, 7, NULL, 2),
(3, 8, 9, NULL, NULL, 3);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `User_ID` int(11) NOT NULL,
  `Name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `Institution` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `Contact` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '9XXXXXXXX0',
  `Email_ID` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `Password` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `usertype` char(1) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`User_ID`, `Name`, `Institution`, `Contact`, `Email_ID`, `Password`, `usertype`) VALUES
(1, 'ABDUL HAFIZ', 'JMI', '9XXXXXXXX1', 'abc@gmail.com', 'xxcvbn123', 'c'),
(2, 'AREEB', 'JMI', '9XXXXXXXX2', 'xyz@gmail.com', 'xxcvbn124', 'v'),
(3, 'ABDULLAH', 'JMI', '9XXXXXXXX3', 'mno@gmail.com', 'xxcvbn125', 'p'),
(4, 'ARQAM', 'JMI', '9XXXXXXXX4', 'mnb@gmail.com', 'xxcvbn126', 'p'),
(5, 'ARSH', 'JMI', '9XXXXXXXX5', 'qwr@gmail.com', 'xxcvbn127', 'c'),
(6, 'SAFDAR', 'JMI', '9XXXXXXXX0', 'arb@gmail.com', 'xxcvbn124', 'v'),
(7, 'SALMAN', 'JMI', '9XXXXXXXX6', 'sal@gmail.com', 'xxcvbn156', 'p'),
(8, 'MONU', 'JMI', '9XXXXXXXX8', 'mon@gmail.com', 'xxcvbn1232', 'v'),
(9, 'ADNAN', 'JMI', '9XXXXXXXX9', 'adn@gmail.com', 'xxcvbn127', 'p'),
(10, 'MEHMOOD', 'JMI', '9XXXXXXX10', 'meh@gmail.com', 'xxcvbn189', 'c'),
(12, 'ayan', 'amu', '9XXXXXXX11', 'ayn@gmail.com', 'xxcvbn126', 'p');

-- --------------------------------------------------------

--
-- Table structure for table `winners`
--

CREATE TABLE `winners` (
  `Win_ID` int(11) NOT NULL,
  `Event_ID` int(11) NOT NULL,
  `P_ID` int(11) DEFAULT NULL,
  `Team_id` int(11) DEFAULT NULL,
  `Position` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `winners`
--

INSERT INTO `winners` (`Win_ID`, `Event_ID`, `P_ID`, `Team_id`, `Position`) VALUES
(1, 1, 1, NULL, 1),
(9, 2, NULL, 1, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`Event_ID`),
  ADD UNIQUE KEY `EvName` (`EvName`),
  ADD UNIQUE KEY `e1` (`EvType_ID`,`EvName`);

--
-- Indexes for table `event_type`
--
ALTER TABLE `event_type`
  ADD PRIMARY KEY (`EvType_ID`),
  ADD UNIQUE KEY `Category` (`Category`);

--
-- Indexes for table `fm_team`
--
ALTER TABLE `fm_team`
  ADD PRIMARY KEY (`M_ID`),
  ADD UNIQUE KEY `User_ID` (`User_ID`);

--
-- Indexes for table `p_single`
--
ALTER TABLE `p_single`
  ADD PRIMARY KEY (`P_ID`),
  ADD UNIQUE KEY `p1` (`Event_ID`,`User_ID`),
  ADD KEY `participants_ibfk_user_id` (`User_ID`);

--
-- Indexes for table `p_team`
--
ALTER TABLE `p_team`
  ADD PRIMARY KEY (`Team_ID`),
  ADD UNIQUE KEY `t1` (`P1_ID`,`Event_ID`),
  ADD UNIQUE KEY `t2` (`P2_ID`,`Event_ID`) USING BTREE,
  ADD UNIQUE KEY `t3` (`P3_ID`,`Event_ID`),
  ADD UNIQUE KEY `t4` (`P4_ID`,`Event_ID`) USING BTREE,
  ADD UNIQUE KEY `dp1234eventid` (`Event_ID`,`P1_ID`,`P2_ID`,`P3_ID`,`P4_ID`) USING BTREE;

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`User_ID`),
  ADD UNIQUE KEY `Email_ID` (`Email_ID`),
  ADD UNIQUE KEY `u1` (`Contact`),
  ADD KEY `u2` (`usertype`);

--
-- Indexes for table `winners`
--
ALTER TABLE `winners`
  ADD PRIMARY KEY (`Win_ID`),
  ADD UNIQUE KEY `w3` (`Event_ID`,`Position`),
  ADD UNIQUE KEY `w2` (`Event_ID`,`P_ID`) USING BTREE,
  ADD UNIQUE KEY `w1` (`Event_ID`,`Team_id`) USING BTREE,
  ADD KEY `winners_ibfk_p_id` (`P_ID`),
  ADD KEY `winners_ibfk_team_id` (`Team_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `Event_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `event_type`
--
ALTER TABLE `event_type`
  MODIFY `EvType_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `fm_team`
--
ALTER TABLE `fm_team`
  MODIFY `M_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `p_single`
--
ALTER TABLE `p_single`
  MODIFY `P_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `p_team`
--
ALTER TABLE `p_team`
  MODIFY `Team_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `User_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `winners`
--
ALTER TABLE `winners`
  MODIFY `Win_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_evtype_id1` FOREIGN KEY (`EvType_ID`) REFERENCES `event_type` (`EvType_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `fm_team`
--
ALTER TABLE `fm_team`
  ADD CONSTRAINT `fm_team_ibfk_event_id` FOREIGN KEY (`Event_ID`) REFERENCES `events` (`Event_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fm_team_ibfk_user_id` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `p_single`
--
ALTER TABLE `p_single`
  ADD CONSTRAINT `p_single_ibfk_event_id` FOREIGN KEY (`Event_ID`) REFERENCES `events` (`Event_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `p_single_ibfk_user_id` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `p_team`
--
ALTER TABLE `p_team`
  ADD CONSTRAINT `events_ibfk_event_id` FOREIGN KEY (`Event_ID`) REFERENCES `events` (`Event_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `p_team_ibfk_p1_id` FOREIGN KEY (`P1_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `p_team_ibfk_p2_id` FOREIGN KEY (`P2_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `p_team_ibfk_p3_id` FOREIGN KEY (`P3_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `p_team_ibfk_p4_id` FOREIGN KEY (`P4_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `winners`
--
ALTER TABLE `winners`
  ADD CONSTRAINT `winners_ibfk_event_id` FOREIGN KEY (`Event_ID`) REFERENCES `events` (`Event_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `winners_ibfk_p_id` FOREIGN KEY (`P_ID`) REFERENCES `p_single` (`P_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `winners_ibfk_team_id` FOREIGN KEY (`Team_id`) REFERENCES `p_team` (`Team_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
