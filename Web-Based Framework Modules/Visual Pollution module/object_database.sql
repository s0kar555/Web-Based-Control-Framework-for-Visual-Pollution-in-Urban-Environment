-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 28, 2024 at 12:05 AM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `object_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `new_objects`
--

CREATE TABLE `new_objects` (
  `id` int(11) NOT NULL,
  `unique_id` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `objectName` varchar(255) DEFAULT NULL,
  `size` varchar(255) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `negativeAction` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `new_objects`
--

INSERT INTO `new_objects` (`id`, `unique_id`, `quantity`, `category`, `status`, `objectName`, `size`, `weight`, `negativeAction`) VALUES
(1, '6682d17c56743', 1, 'Other (facilities)', 'neutral', 'Poles (light, electricity, transformer, etc...)', 'small', 2.5, 'Broken, wire clutter, visually unappealing'),
(2, '6682d1dec6aa6', 1, 'Other (facilities)', 'neutral', 'Poles (light, electricity, transformer, etc...)', 'small', 2.5, 'Broken, wire clutter, visually unappealing'),
(3, '6689bbaacbee7', 1, 'Other (facilities)', 'neutral', 'Poles (light, electricity, transformer, etc...)', 'small', 2.5, 'Broken, wire clutter, visually unappealing'),
(4, '6695abd5c5fe8', 1, 'Other (facilities)', 'neutral', 'Poles (light, electricity, transformer, etc...)', 'small', 2.5, 'Broken, wire clutter, visually unappealing'),
(5, '66c3cab04142f', 1, 'Other (facilities)', 'neutral', 'Poles (light, electricity, transformer, etc...)', 'small', 2.5, 'Broken, wire clutter, visually unappealing'),
(6, '66c3cab04142f', 1, 'Other (facilities)', 'negative', 'Trash Bins', 'small', 5, 'Overflowing, visually unappealing');

-- --------------------------------------------------------

--
-- Table structure for table `objects`
--

CREATE TABLE `objects` (
  `id` int(11) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `objectName` varchar(100) DEFAULT NULL,
  `size` varchar(50) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `negativeAction` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `objects`
--

INSERT INTO `objects` (`id`, `category`, `status`, `objectName`, `size`, `weight`, `negativeAction`) VALUES
(1, 'Buildings', 'neutral', 'Building', 'Large', 3.75, 'Dilapidated and poorly maintained'),
(2, 'Buildings', 'neutral', 'Building', 'Large', 3.75, 'Under construction (Uncovered)'),
(3, 'Buildings', 'neutral', 'Building', 'Large', 3.75, 'Visually unappealing shape or color'),
(4, 'Buildings', 'neutral', 'Wall', 'Small', 3.75, 'Graffiti, wall chalking, broken, unpainted'),
(5, 'Buildings', 'neutral', 'Rooftops', 'Small', 3.75, 'Blue water tanks'),
(6, 'Buildings', 'neutral', 'Building', 'Medium', 3.75, 'Modifications such as covered balconies, hanging clothes, roof projections, and building alterations'),
(7, 'Buildings', 'neutral', 'Air Conditioning Units And Ducts', 'Small', 3.75, 'Broken'),
(8, 'Buildings', 'neutral', 'Ventilation Chimneys', 'Small', 3.75, 'Broken'),
(9, 'Buildings', 'neutral', 'Satellite Dishes, Antennas', 'Small', 3.75, 'Broken'),
(10, 'Street', 'neutral', 'Manholes', 'Small', 1.25, 'Blocked, uncovered'),
(11, 'Street', 'neutral', 'Roads', 'Small', 1.25, 'Broken'),
(12, 'Street', 'neutral', 'Bumps', 'Small', 1.25, 'Random, visually unappealing'),
(13, 'Street', 'neutral', 'Sidewalks', 'Small', 1.25, 'Dilapidated'),
(14, 'Street', 'neutral', 'Water', 'Small', 1.25, 'Leakage'),
(15, 'Street', 'neutral', 'Services Excavation Projects', 'Small', 1.25, 'Ongoing, causing disruption, uncovered'),
(16, 'Other (facilities)', 'neutral', 'Car Shelter', 'Medium', 2.5, 'Broken, visually unappealing'),
(17, 'Other (facilities)', 'neutral', 'Concrete Barriers', 'Small', 2.5, 'Broken, unpainted, uncovered'),
(18, 'Other (facilities)', 'neutral', 'Billboards', 'Medium', 2.5, 'Broken, over bright, unethical content, visually unappealing'),
(19, 'Other (facilities)', 'neutral', 'Banners', 'Small', 2.5, 'Broken, over bright, unethical content, visually unappealing'),
(20, 'Other (facilities)', 'neutral', 'Signs', 'Small', 2.5, 'Broken, over bright, unethical content, visually unappealing'),
(21, 'Other (facilities)', 'neutral', 'Cars', 'Small', 2.5, 'Damaged'),
(22, 'Other (facilities)', 'neutral', 'Towers (cellular, Communication, etc...)', 'Medium', 2.5, 'Broken, uncovered'),
(23, 'Other (facilities)', 'neutral', 'Poles (light, electricity, transformer, etc...)', 'Small', 2.5, 'Broken, wire clutter, visually unappealing'),
(24, 'Other (facilities)', 'neutral', 'Ramps', 'Small', 2.5, 'Uneven, broken'),
(25, 'Other (facilities)', 'neutral', 'Fences', 'Small', 2.5, 'Broken, unpainted, uncovered, corrugated steel'),
(26, 'Other (facilities)', 'neutral', 'Street Furniture', 'Small', 2.5, 'Broken, visually unappealing'),
(27, 'Other (facilities)', 'negative', 'Litter', 'Small', 5, 'Scattered, visually unappealing'),
(28, 'Other (facilities)', 'negative', 'Trash Bins', 'Small', 5, 'Overflowing, visually unappealing'),
(29, 'Other (facilities)', 'negative', 'Construction And Demolition Waste', 'Small', 5, 'Overflowing, visually unappealing'),
(30, 'Other (facilities)', 'negative', 'Construction Materials', 'Small', 5, 'Unorganized, visually unappealing'),
(31, 'Other (facilities)', 'negative', 'Scrap Materials', 'Small', 5, 'Scattered, visually unappealing'),
(32, 'Other (facilities)', 'negative', 'Dumpsters', 'Medium', 5, 'Overfilled, visually unappealing'),
(33, 'Other (facilities)', 'negative', 'Encroachments', 'Small', 5, 'Street camping');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `new_objects`
--
ALTER TABLE `new_objects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `objects`
--
ALTER TABLE `objects`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `new_objects`
--
ALTER TABLE `new_objects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `objects`
--
ALTER TABLE `objects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
