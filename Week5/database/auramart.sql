-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 03, 2026 at 12:32 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `alnoor_store`
--
CREATE DATABASE IF NOT EXISTS `alnoor_store` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `alnoor_store`;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Home & Kitchen'),
(4, 'Sports');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT 'placeholder.png',
  `category_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `image`, `category_id`, `created_at`) VALUES
(1, 'Smartphone X', 'Latest 5G smartphone with 128GB storage', 599.99, 'phone.png', 1, '2026-05-28 01:15:59'),
(2, 'Laptop Pro', '15.6\" Full HD, 16GB RAM, 512GB SSD', 899.99, 'laptop.png', 1, '2026-05-28 01:15:59'),
(3, 'Wireless Headphones', 'Noise cancelling, 30hr battery', 79.99, 'headphones.png', 1, '2026-05-28 01:15:59'),
(4, 'Running Shoes', 'Lightweight, breathable mesh', 59.99, 'shoes.png', 4, '2026-05-28 01:15:59'),
(5, 'test', 'test', 100.00, 'placeholder.png', 1, '2026-05-28 01:26:33');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `created_at`) VALUES
(1, 'ali', 'mohamed', 'ali@gmail.com', '$2y$10$/GBXdVGR6DdlSiITYzXI/elH8FGRDPNlN.dt5T97ipSVZ6d5A3tdW', '2026-05-27 17:25:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;
--
-- Database: `auramart`
--
CREATE DATABASE IF NOT EXISTS `auramart` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `auramart`;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `fullname` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` text NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) DEFAULT 'Cash on Delivery',
  `status` enum('pending','processing','shipped','delivered','cancelled') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `fullname`, `email`, `phone`, `address`, `total`, `payment_method`, `status`, `created_at`) VALUES
(7, NULL, 'Hubert Mulama', 'hubert.mulama@gmail.com', '0700683765', '7887', 16000.00, 'Cash on Delivery', 'pending', '2026-05-27 14:34:35'),
(8, 2, 'Kapis njeri', 'kapis@gmail.com', '071111111', '9898', 2000.00, 'Cash on Delivery', 'pending', '2026-05-27 15:09:42');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(150) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `product_name`, `price`, `quantity`) VALUES
(1, 7, 1, 'Jbl charge 5', 16000.00, 1),
(2, 8, 2, 'Rich dad poor dad', 2000.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) DEFAULT 0,
  `category` varchar(100) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `stock`, `category`, `image`, `created_at`) VALUES
(1, 'Jbl charge 5', 'The JBL Charge 5 has an optimized long excursion driver, a separate tweeter, and dual JBL bass radiators, all delivering impressively rich and clear audio', 16000.00, 1, 'Electronics', 'JBL-Charge-5.webp', '2026-05-27 11:29:23'),
(2, 'Rich dad poor dad', 'Rich Dad Poor Dad is a 1997 personal finance book by Robert Kiyosaki that advocates for financial independence, entrepreneurship, and building wealth through investing.', 2000.00, 4, 'Books', 'Rich dad poor dad book image.jpg', '2026-05-27 11:32:28');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','customer') DEFAULT 'customer',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullname`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'Muthee Kinuthia', 'Muthee@gmail.com', '$2y$10$6NYdHzfMOzV7YHVTCzPsJeyR5KRkg60.cePCr.l3Jcp1pQFTAXgrC', 'admin', '2026-05-27 11:07:46'),
(2, 'Kapis njeri', 'kapis@gmail.com', '$2y$10$r6s2qYiz4VA68M8oT/e9T.vq1GJLNOcruyowJ7dK1ZLI/WT5B7bmK', 'customer', '2026-05-27 11:52:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
--
-- Database: `cms_db`
--
CREATE DATABASE IF NOT EXISTS `cms_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cms_db`;

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` int(30) NOT NULL,
  `branch_code` varchar(50) NOT NULL,
  `street` text NOT NULL,
  `city` text NOT NULL,
  `state` text NOT NULL,
  `zip_code` varchar(50) NOT NULL,
  `country` text NOT NULL,
  `contact` varchar(100) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `branch_code`, `street`, `city`, `state`, `zip_code`, `country`, `contact`, `date_created`) VALUES
(1, 'vzTL0PqMogyOWhF', 'thika bazaar', 'Thika', 'Thika', '1001', 'Kenya', '0723456789', '2020-11-26 11:21:41'),
(3, 'KyIab3mYBgAX71t', 'Eastleigh RNG', 'Eastleigh', 'Gaza', '6000', 'Kenya', '+254 011687489', '2020-11-26 16:45:05'),
(4, 'dIbUK5mEh96f0Zc', 'Jaramogi,Luthuli', 'Nairobi', 'CBD', '123456', 'Kenya', '0778123456', '2020-11-27 13:31:49'),
(5, 'hYrjA4q6m9cBFnG', 'mandera', 'nairobi', 'california states', '70300', 'mandera', '0720029832', '2025-07-10 08:04:49');

-- --------------------------------------------------------

--
-- Table structure for table `parcels`
--

CREATE TABLE `parcels` (
  `id` int(30) NOT NULL,
  `reference_number` varchar(100) NOT NULL,
  `sender_name` text NOT NULL,
  `sender_address` text NOT NULL,
  `sender_contact` text NOT NULL,
  `recipient_name` text NOT NULL,
  `recipient_address` text NOT NULL,
  `recipient_contact` text NOT NULL,
  `type` int(1) NOT NULL COMMENT '1 = Deliver, 2=Pickup',
  `from_branch_id` varchar(30) NOT NULL,
  `to_branch_id` varchar(30) NOT NULL,
  `weight` varchar(100) NOT NULL,
  `height` varchar(100) NOT NULL,
  `width` varchar(100) NOT NULL,
  `length` varchar(100) NOT NULL,
  `price` float NOT NULL,
  `status` int(2) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `parcels`
--

INSERT INTO `parcels` (`id`, `reference_number`, `sender_name`, `sender_address`, `sender_contact`, `recipient_name`, `recipient_address`, `recipient_contact`, `type`, `from_branch_id`, `to_branch_id`, `weight`, `height`, `width`, `length`, `price`, `status`, `date_created`) VALUES
(1, '201406231415', 'John Smith', 'Sample', '+123456', 'Claire Blake', 'Sample', 'Sample', 1, '1', '0', '30kg', '12in', '12in', '15in', 2500, 7, '2020-11-26 16:15:46'),
(2, '117967400213', 'John Smith', 'Sample', '+123456', 'Claire Blake', 'Sample', 'Sample', 2, '1', '3', '30kg', '12in', '12in', '15in', 2500, 1, '2020-11-26 16:46:03'),
(3, '983186540795', 'John Smith', 'Sample', '+123456', 'Claire Blake', 'Sample', 'Sample', 2, '1', '3', '20Kg', '10in', '10in', '10in', 1500, 2, '2020-11-26 16:46:03'),
(5, '897856905844', 'yunus yahya', 'Sample', '+123456', 'John Smith', 'Sample Address', '+12345', 2, '4', '1', '30kg', '10in', '10in', '10in', 1450, 0, '2020-11-27 13:52:14'),
(6, '505604168988', 'zakaria Abdallah', 'Sample', '+123456', 'Sample', 'Sample', '+12345', 1, '1', '', '23kg', '12in', '12in', '15in', 2500, 1, '2020-11-27 14:06:42'),
(7, '928009125247', 'zakicade ', 'banisa', '079876543', 'khala', 'eymole', '078765434567', 2, '3', '3', '54', '454', '65', '65', 456, 0, '2025-06-25 12:45:02'),
(8, '220113033747', 'alker barow', 'banisa', '0709876543', 'edow sirgo ', 'bula slu;la', '071234567', 2, '3', '4', '34', '454', '65', '65', 456, 0, '2025-06-25 13:17:06'),
(9, '439982272326', 'alker barow', 'banisa', '0709876543', 'edow sirgo ', 'bula slu;la', '074500832', 2, '3', '4', '34', '454', '65', '65', 456, 0, '2025-07-09 15:40:28'),
(10, '888663115975', 'alker barow', 'banisa', '0709876543', 'edow sirgo ', 'bula slu;la', '074500832', 2, '3', '4', '54', '677', '50', '23', 864, 0, '2025-07-09 15:40:28'),
(11, '625566208929', 'kulow', 'banisa', '0709876543', 'ibrahim', 'eymole', '078765434567', 2, '4', '4', '54', '454', '65', '65', 0, 0, '2025-07-09 19:42:16'),
(12, '732531034278', 'salah', 'takaba', '0709876543', 'manga', 'bula slu;la', '072367882', 2, '3', '', '67', '5', '10', '4', 30000, 0, '2025-07-09 19:45:50'),
(13, '695532322237', 'salah', 'takaba', '0709876543', 'manga', 'bula slu;la', '0720029823', 2, '3', '3', '67', '5', '10', '4', 3000, 0, '2025-07-09 19:54:26'),
(14, '688410158696', 'malala', 'banisa', '0723456789', 'yarso', 'derkaleh', '078765434567', 2, '1', '3', '54', '454', '65', '65', 600, 0, '2025-07-09 22:13:17'),
(15, '196579529182', 'malala', 'banisa', '0723456789', 'yarso', 'derkaleh', '078765434567', 2, '4', '4', '54', '454', '65', '65', 600, 0, '2025-07-09 22:15:40'),
(16, '829443704177', 'malala', 'banisa', '0723456789', 'yarso', 'derkaleh', '078765434567', 2, '4', '4', '90', '5', '80', '28', 1276, 0, '2025-07-09 22:15:40'),
(17, '032043053715', 'kulow', 'takaba', '0709876543', 'ibrahim', 'eymole', '0720029823', 2, '3', '3', '34', '5', '10', '4', 500, 0, '2025-07-09 22:20:43'),
(18, '841084672398', 'qala', 'banisa', '073454321', 'ibrahim', 'yama', '078765434567', 2, '4', '', '21', '5', '4', '8', 300, 0, '2025-07-09 22:24:34'),
(19, '693975339739', 'qala', 'banisa', '0723456789', 'ibrahim', 'yama', '078765434567', 2, '4', '4', '21', '5', '4', '8', 300, 0, '2025-07-09 22:25:19');

-- --------------------------------------------------------

--
-- Table structure for table `parcel_tracks`
--

CREATE TABLE `parcel_tracks` (
  `id` int(30) NOT NULL,
  `parcel_id` int(30) NOT NULL,
  `status` int(2) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `parcel_tracks`
--

INSERT INTO `parcel_tracks` (`id`, `parcel_id`, `status`, `date_created`) VALUES
(1, 2, 1, '2020-11-27 09:53:27'),
(2, 3, 1, '2020-11-27 09:55:17'),
(3, 1, 1, '2020-11-27 10:28:01'),
(4, 1, 2, '2020-11-27 10:28:10'),
(5, 1, 3, '2020-11-27 10:28:16'),
(6, 1, 4, '2020-11-27 11:05:03'),
(7, 1, 5, '2020-11-27 11:05:17'),
(8, 1, 7, '2020-11-27 11:05:26'),
(9, 3, 2, '2020-11-27 11:05:41'),
(10, 6, 1, '2020-11-27 14:06:57');

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` int(30) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(200) NOT NULL,
  `contact` varchar(20) NOT NULL,
  `address` text NOT NULL,
  `cover_img` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `name`, `email`, `contact`, `address`, `cover_img`) VALUES
(1, 'Cargo Management System', 'info@cargo.comm', '+254 34567890', '2102  Thika Road,Ruiru,', '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(30) NOT NULL,
  `firstname` varchar(200) NOT NULL,
  `lastname` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` text NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 2 COMMENT '1 = admin, 2 = staff',
  `branch_id` int(30) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password`, `type`, `branch_id`, `date_created`) VALUES
(1, 'Administrator', 'Ibrahim', 'ibrahim@gmail.com', '0192023a7bbd73250516f069df18b500', 1, 0, '2025-05-26 10:57:04'),
(2, 'Juma', 'Abdallah', 'jdullah@gmail.com', '1254737c076cf867dc53d60a0364f38e', 2, 1, '2025-05-26 11:52:04'),
(3, 'George', 'Guyo', 'guyo@yahoo.com', 'd40242fb23c45206fadee4e2418f274f', 2, 4, '2025-05-27 13:32:12'),
(4, 'zakaria barowe', 'alkher', 'ibrahimokitjrhdgfcg@gmail.com', '0192023a7bbd73250516f069df18b500', 2, 3, '2025-06-25 12:46:35'),
(5, 'jabro', 'wario', 'kala@gmail.com', '0192023a7bbd73250516f069df18b500', 2, 3, '2025-07-09 15:31:33');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `parcels`
--
ALTER TABLE `parcels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `parcel_tracks`
--
ALTER TABLE `parcel_tracks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `parcels`
--
ALTER TABLE `parcels`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `parcel_tracks`
--
ALTER TABLE `parcel_tracks`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Database: `healthcare`
--
CREATE DATABASE IF NOT EXISTS `healthcare` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `healthcare`;

-- --------------------------------------------------------

--
-- Table structure for table `medication`
--

CREATE TABLE `medication` (
  `VisitID` int(11) DEFAULT NULL,
  `Medication` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medication`
--

INSERT INTO `medication` (`VisitID`, `Medication`) VALUES
(1, 'Paracetamol'),
(1, 'Vitamin C'),
(2, 'Cetirizine'),
(3, 'Metformin'),
(3, 'Insulin'),
(1, 'Paracetamol'),
(1, 'Vitamin C'),
(2, 'Cetirizine'),
(3, 'Metformin'),
(3, 'Insulin');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `PatientID` int(11) NOT NULL,
  `PatientName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`PatientID`, `PatientName`) VALUES
(1, 'John Doe'),
(2, 'Jane Smith');

-- --------------------------------------------------------

--
-- Table structure for table `visit`
--

CREATE TABLE `visit` (
  `VisitID` int(11) NOT NULL,
  `PatientID` int(11) DEFAULT NULL,
  `VisitDate` date DEFAULT NULL,
  `Diagnosis` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `visit`
--

INSERT INTO `visit` (`VisitID`, `PatientID`, `VisitDate`, `Diagnosis`) VALUES
(1, 1, '2025-06-01', 'Flu'),
(2, 1, '2025-06-15', 'Allergy'),
(3, 2, '2025-06-10', 'Diabetes');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `medication`
--
ALTER TABLE `medication`
  ADD KEY `VisitID` (`VisitID`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`PatientID`);

--
-- Indexes for table `visit`
--
ALTER TABLE `visit`
  ADD PRIMARY KEY (`VisitID`),
  ADD KEY `PatientID` (`PatientID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `medication`
--
ALTER TABLE `medication`
  ADD CONSTRAINT `medication_ibfk_1` FOREIGN KEY (`VisitID`) REFERENCES `visit` (`VisitID`);

--
-- Constraints for table `visit`
--
ALTER TABLE `visit`
  ADD CONSTRAINT `visit_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`);
--
-- Database: `hotel_db`
--
CREATE DATABASE IF NOT EXISTS `hotel_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hotel_db`;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `status` varchar(20) DEFAULT 'Confirmed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `customer_id`, `room_id`, `check_in`, `check_out`, `status`) VALUES
(1, 1, 1, '2025-11-12', '2025-11-13', 'Confirmed'),
(2, 2, 2, '2025-11-15', '2025-11-27', 'Confirmed'),
(3, 3, 4, '2025-11-29', '2025-12-01', 'Confirmed'),
(4, 4, 3, '2025-11-28', '2025-12-05', 'Confirmed'),
(5, 5, 5, '2025-12-04', '2025-12-05', 'Confirmed'),
(6, 6, 6, '2025-12-05', '2025-12-06', 'Confirmed'),
(7, 7, 7, '2025-11-13', '2025-11-29', 'Confirmed');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`) VALUES
(1, 'samuel', 'muthee001@gmail.com'),
(2, 'fred', 'kyama@gmail.com'),
(3, 'Billy', 'Billy@gmail.com'),
(4, 'ali', 'ali@gmail.com'),
(5, 'ian', 'ian@gmail.com'),
(6, 'Sharon', 'Sharon@gmail.com'),
(7, 'Njeri', 'Njaeri@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `room_number` varchar(10) NOT NULL,
  `room_type` varchar(50) NOT NULL,
  `price` int(11) NOT NULL,
  `status` varchar(20) DEFAULT 'Available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `room_number`, `room_type`, `price`, `status`) VALUES
(1, '1101', 'executive', 20000, 'Occupied'),
(2, '1102', 'basic', 1000, 'Occupied'),
(3, '1103', 'Normal', 3000, 'Occupied'),
(4, '1104', 'executive', 20000, 'Occupied'),
(5, '1105', 'basic', 4000, 'Occupied'),
(6, '1106', 'executive', 20000, 'Occupied'),
(7, '1107', 'executive', 20000, 'Occupied'),
(8, '1107', 'executive', 20000, 'Available'),
(9, '1108', 'basic', 1000, 'Available');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`);
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

--
-- Dumping data for table `pma__designer_settings`
--

INSERT INTO `pma__designer_settings` (`username`, `settings_data`) VALUES
('root', '{\"angular_direct\":\"direct\",\"snap_to_grid\":\"off\",\"relation_lines\":\"true\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

--
-- Dumping data for table `pma__pdf_pages`
--

INSERT INTO `pma__pdf_pages` (`db_name`, `page_nr`, `page_descr`) VALUES
('healthcare', 1, 'joe');

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data for table `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"alnoor_store\",\"table\":\"products\"},{\"db\":\"alnoor_store\",\"table\":\"users\"},{\"db\":\"alnoor_store\",\"table\":\"categories\"},{\"db\":\"auramart\",\"table\":\"products\"},{\"db\":\"auramart\",\"table\":\"users\"},{\"db\":\"auramart\",\"table\":\"orders\"},{\"db\":\"auramart\",\"table\":\"order_items\"},{\"db\":\"hotel_db\",\"table\":\"rooms\"},{\"db\":\"hotel_db\",\"table\":\"bookings\"},{\"db\":\"hotel_db\",\"table\":\"customers\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

--
-- Dumping data for table `pma__table_coords`
--

INSERT INTO `pma__table_coords` (`db_name`, `table_name`, `pdf_page_number`, `x`, `y`) VALUES
('healthcare', 'medication', 1, 201, 22),
('healthcare', 'patient', 1, 351, 540),
('healthcare', 'visit', 1, 277, 35);

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2026-06-03 10:30:36', '{\"Console\\/Mode\":\"collapse\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `school`
--
CREATE DATABASE IF NOT EXISTS `school` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `school`;

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `Course_ID` varchar(5) NOT NULL,
  `Course_Name` varchar(50) DEFAULT NULL,
  `Instructor_ID` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`Course_ID`, `Course_Name`, `Instructor_ID`) VALUES
('C01', 'Math', 'I01'),
('C02', 'English', 'I02'),
('C03', 'Biology', 'I03'),
('C04', 'Chemistry', 'I04');

-- --------------------------------------------------------

--
-- Table structure for table `enrollment`
--

CREATE TABLE `enrollment` (
  `Student_ID` varchar(5) NOT NULL,
  `Course_ID` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrollment`
--

INSERT INTO `enrollment` (`Student_ID`, `Course_ID`) VALUES
('S01', 'C01'),
('S01', 'C02'),
('S02', 'C01'),
('S02', 'C03'),
('S02', 'C04'),
('S03', 'C02'),
('S03', 'C03');

-- --------------------------------------------------------

--
-- Table structure for table `instructor`
--

CREATE TABLE `instructor` (
  `Instructor_ID` varchar(5) NOT NULL,
  `Instructor_Name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `instructor`
--

INSERT INTO `instructor` (`Instructor_ID`, `Instructor_Name`) VALUES
('I01', 'Mr. Tom'),
('I02', 'Ms. Grace'),
('I03', 'Dr. Jane'),
('I04', 'Dr. Sam');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `Student_ID` varchar(5) NOT NULL,
  `Student_Name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`Student_ID`, `Student_Name`) VALUES
('S01', 'Ali Hassan'),
('S02', 'Aisha Noor'),
('S03', 'Mohamed Yusuf');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`Course_ID`),
  ADD KEY `Instructor_ID` (`Instructor_ID`);

--
-- Indexes for table `enrollment`
--
ALTER TABLE `enrollment`
  ADD PRIMARY KEY (`Student_ID`,`Course_ID`),
  ADD KEY `Course_ID` (`Course_ID`);

--
-- Indexes for table `instructor`
--
ALTER TABLE `instructor`
  ADD PRIMARY KEY (`Instructor_ID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`Student_ID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_ibfk_1` FOREIGN KEY (`Instructor_ID`) REFERENCES `instructor` (`Instructor_ID`);

--
-- Constraints for table `enrollment`
--
ALTER TABLE `enrollment`
  ADD CONSTRAINT `enrollment_ibfk_1` FOREIGN KEY (`Student_ID`) REFERENCES `student` (`Student_ID`),
  ADD CONSTRAINT `enrollment_ibfk_2` FOREIGN KEY (`Course_ID`) REFERENCES `course` (`Course_ID`);
--
-- Database: `school_exam_jk`
--
CREATE DATABASE IF NOT EXISTS `school_exam_jk` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `school_exam_jk`;

-- --------------------------------------------------------

--
-- Table structure for table `exams_jk`
--

CREATE TABLE `exams_jk` (
  `id` int(11) NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `exam_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exam_questions_jk`
--

CREATE TABLE `exam_questions_jk` (
  `id` int(11) NOT NULL,
  `exam_id` int(11) DEFAULT NULL,
  `question` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exam_results_jk`
--

CREATE TABLE `exam_results_jk` (
  `id` int(11) NOT NULL,
  `exam_id` int(11) DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments_jk`
--

CREATE TABLE `payments_jk` (
  `id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `status` enum('paid','pending') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments_jk`
--

INSERT INTO `payments_jk` (`id`, `student_id`, `amount`, `status`) VALUES
(1, 5, 200.00, 'paid');

-- --------------------------------------------------------

--
-- Table structure for table `student_subjects_jk`
--

CREATE TABLE `student_subjects_jk` (
  `id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `status` enum('pending_payment','cleared') DEFAULT 'pending_payment'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_subjects_jk`
--

INSERT INTO `student_subjects_jk` (`id`, `student_id`, `subject_id`, `status`) VALUES
(1, 5, 1, 'cleared'),
(2, 5, 1, 'cleared'),
(3, 5, 1, 'cleared');

-- --------------------------------------------------------

--
-- Table structure for table `subjects_jk`
--

CREATE TABLE `subjects_jk` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects_jk`
--

INSERT INTO `subjects_jk` (`id`, `name`) VALUES
(1, 'Mathematics'),
(2, 'Science');

-- --------------------------------------------------------

--
-- Table structure for table `tokens_jk`
--

CREATE TABLE `tokens_jk` (
  `id` int(11) NOT NULL,
  `token_code` varchar(100) NOT NULL,
  `token_type` enum('system','admin','teacher','student','finance','exam') DEFAULT 'system',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `locked` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tokens_jk`
--

INSERT INTO `tokens_jk` (`id`, `token_code`, `token_type`, `created_by`, `created_at`, `locked`) VALUES
(1, 'JK2025-SYSTEMKEY', 'system', NULL, '2025-10-15 10:36:36', 1),
(2, 'JK2025-ADMINLOCK', 'admin', NULL, '2025-10-15 10:36:36', 1),
(3, 'JK2025-TEACHLOCK', 'teacher', NULL, '2025-10-15 10:36:36', 1),
(4, 'JK2025-STUDENTKEY', 'student', NULL, '2025-10-15 10:36:36', 1),
(5, 'JK2025-FINLOCK', 'finance', NULL, '2025-10-15 10:36:36', 1),
(6, 'JK2025-EXAMKEY', 'exam', NULL, '2025-10-15 10:36:36', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users_jk`
--

CREATE TABLE `users_jk` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','teacher','finance','admin') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_jk`
--

INSERT INTO `users_jk` (`id`, `username`, `password`, `role`) VALUES
(1, 'admin1', '$2y$10$jkhashedpassword1234567890', 'admin'),
(2, 'student1', '$2y$10$jkhashedpassword1234567890', 'student'),
(3, 'teacher1', '$2y$10$jkhashedpassword1234567890', 'teacher'),
(4, 'finance1', '$2y$10$jkhashedpassword1234567890', 'finance'),
(5, 'zakaria', '$2y$10$1YjNpip.0fLg8oiOAXxowOWyYfaN7ZA3YVpyR4DDW99I5RXD.YVWG', 'student'),
(6, 'njagi', '$2y$10$0gBTqwTchg1J/Go1oh9Jkuh7rQJYz5GEu7WyIP4nr6dHE6juRWMnm', 'teacher'),
(7, 'chege', '$2y$10$DbclxBvhw5Ud.vZ9z3sCveaz/ab8AstsPedmFtMOvYDOJPP4/xNvW', 'finance');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `exams_jk`
--
ALTER TABLE `exams_jk`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `exam_questions_jk`
--
ALTER TABLE `exam_questions_jk`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exam_id` (`exam_id`);

--
-- Indexes for table `exam_results_jk`
--
ALTER TABLE `exam_results_jk`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exam_id` (`exam_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `payments_jk`
--
ALTER TABLE `payments_jk`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `student_subjects_jk`
--
ALTER TABLE `student_subjects_jk`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `subjects_jk`
--
ALTER TABLE `subjects_jk`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tokens_jk`
--
ALTER TABLE `tokens_jk`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token_code` (`token_code`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `users_jk`
--
ALTER TABLE `users_jk`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `exams_jk`
--
ALTER TABLE `exams_jk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_questions_jk`
--
ALTER TABLE `exam_questions_jk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_results_jk`
--
ALTER TABLE `exam_results_jk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments_jk`
--
ALTER TABLE `payments_jk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `student_subjects_jk`
--
ALTER TABLE `student_subjects_jk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `subjects_jk`
--
ALTER TABLE `subjects_jk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tokens_jk`
--
ALTER TABLE `tokens_jk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users_jk`
--
ALTER TABLE `users_jk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `exams_jk`
--
ALTER TABLE `exams_jk`
  ADD CONSTRAINT `exams_jk_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects_jk` (`id`);

--
-- Constraints for table `exam_questions_jk`
--
ALTER TABLE `exam_questions_jk`
  ADD CONSTRAINT `exam_questions_jk_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `exams_jk` (`id`);

--
-- Constraints for table `exam_results_jk`
--
ALTER TABLE `exam_results_jk`
  ADD CONSTRAINT `exam_results_jk_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `exams_jk` (`id`),
  ADD CONSTRAINT `exam_results_jk_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `users_jk` (`id`);

--
-- Constraints for table `payments_jk`
--
ALTER TABLE `payments_jk`
  ADD CONSTRAINT `payments_jk_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users_jk` (`id`);

--
-- Constraints for table `student_subjects_jk`
--
ALTER TABLE `student_subjects_jk`
  ADD CONSTRAINT `student_subjects_jk_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users_jk` (`id`),
  ADD CONSTRAINT `student_subjects_jk_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects_jk` (`id`);

--
-- Constraints for table `tokens_jk`
--
ALTER TABLE `tokens_jk`
  ADD CONSTRAINT `tokens_jk_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users_jk` (`id`);
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
