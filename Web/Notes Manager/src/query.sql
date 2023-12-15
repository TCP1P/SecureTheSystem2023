-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 11, 2023 at 09:23 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_ctf`
--

-- --------------------------------------------------------

--
-- Table structure for table `note`
--

CREATE TABLE `note` (
  `id` varchar(255) NOT NULL,
  `title` text NOT NULL,
  `content` text NOT NULL,
  `password` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `note`
--

INSERT INTO `note` (`id`, `title`, `content`, `password`, `user_id`, `created_at`, `updated_at`) VALUES
('42474cd7-ebf7-4244-807e-7c7a865af4c2', 'Don\'t open this...', 'We\'re no strangers to love\nYou know the rules and so do I (do I)\nA full commitment\'s what I\'m thinking of\nYou wouldn\'t get this from any other guy\nI just wanna tell you how I\'m feeling\nGotta make you understand\nNever gonna give you up\nNever gonna let you down\nNever gonna run around and desert you\nNever gonna make you cry\nNever gonna say goodbye\nNever gonna tell a lie and hurt you\nWe\'ve known each other for so long\nYour heart\'s been aching, but you\'re too shy to say it (say it)\nInside, we both know what\'s been going on (going on)\nWe know the game and we\'re gonna play it\nAnd if you ask me how I\'m feeling\nDon\'t tell me you\'re too blind to see\nNever gonna give you up\nNever gonna let you down\nNever gonna run around and desert you\nNever gonna make you cry\nNever gonna say goodbye\nNever gonna tell a lie and hurt you\nNever gonna give you up\nNever gonna let you down\nNever gonna run around and desert you\nNever gonna make you cry\nNever gonna say goodbye\nNever gonna tell a lie and hurt you\nWe\'ve known each other for so long\nYour heart\'s been aching, but you\'re too shy to say it (to say it)\nInside, we both know what\'s been going on (going on)\nWe know the game and we\'re gonna play it\nI just wanna tell you how I\'m feeling\nGotta make you understand\nNever gonna give you up\nNever gonna let you down\nNever gonna run around and desert you\nNever gonna make you cry\nNever gonna say goodbye\nNever gonna tell a lie and hurt you\nNever gonna give you up\nNever gonna let you down\nNever gonna run around and desert you\nNever gonna make you cry\nNever gonna say goodbye\nNever gonna tell a lie and hurt you\nNever gonna give you up\nNever gonna let you down\nNever gonna run around and desert you\nNever gonna make you cry\nNever gonna say goodbye\nNever gonna tell a lie and hurt you', '', 6, '2023-12-11 21:53:02', NULL),
('a6faca0d-7e51-4b02-834f-c7b11370056f', 'FLAG', 'STS23{Bl4ckb0x_Ch4ll_F0r_An0th3r_D4y}', 'this_is_a_very_long_password', 6, '2023-12-11 21:12:48', NULL),
('bb06631b-9b72-424a-b8ec-fb815eb24a75', 'TODO', 'Fix these known vulnerabilities:\r\n- IDOR\r\n- Broken Access Control\r\n', '', 6, '2023-12-11 22:05:41', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(32) NOT NULL,
  `password` varchar(64) NOT NULL,
  `name` text,
  `gender` enum('male','female','attack_helicopter') DEFAULT NULL,
  `role` enum('admin','user') NOT NULL,
  `status` enum('active','blocked') NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `name`, `gender`, `role`, `status`, `created_at`, `updated_at`) VALUES
(6, 'admin', '771c6e704e35050bdf73af3b505a913c0c1bbcc6055644f9806f54befbfcfd5d', 'Aimar', 'male', 'admin', 'active', '2023-12-11 09:55:00', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `note`
--
ALTER TABLE `note`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
