-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 02, 2025 at 12:47 AM
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
-- Database: `hospital`
--

-- --------------------------------------------------------

--
-- Table structure for table `nurses`
--

CREATE TABLE `nurses` (
  `nid` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `nurse_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nurses`
--

INSERT INTO `nurses` (`nid`, `email`, `nurse_name`) VALUES
(1, '123@gmail.com', '123'),
(2, 'buu@gmail.com', 'masqui'),
(3, 'Sharmadamini093@gmail.com', 'abc'),
(4, 'Sharmadamini093@gmail.com', '123');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `pid` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `slot` varchar(50) NOT NULL,
  `disease` varchar(50) NOT NULL,
  `time` time NOT NULL,
  `date` date NOT NULL,
  `mobile` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`pid`, `name`, `email`, `gender`, `slot`, `disease`, `time`, `date`, `mobile`) VALUES
(1, 'qwe', 'qwe@gmail.com', 'Male', 'morning', 'fever', '09:30:00', '2024-12-02', '123454566666'),
(2, 'qwe', 'qwe@gmail.com', 'Female', 'evening', 'fever', '00:59:00', '2024-12-22', '222222222222'),
(3, 'xyzas', 'xyz@gmail.com', 'Male', 'morning', 'fever', '08:03:00', '2024-12-25', '111111111111'),
(4, 'testsingh', 'testing@gmail.com', 'Male', 'morning', 'frvv', '06:31:00', '2025-01-08', '876799876633'),
(22, 'Harsimran', 'harsimran1472@gmail.com', 'Male', 'morningt', 'leg', '18:06:00', '2025-02-28', '7789861472'),
(23, 'buu', 'Sharmadamini093@gmail.com', 'Female', 'morning', 'leg broken', '23:56:00', '2025-02-27', '2368693649');

--
-- Triggers `patients`
--
DELIMITER $$
CREATE TRIGGER `patientdeleted` BEFORE DELETE ON `patients` FOR EACH ROW INSERT INTO `trigger` (tid, pid, email, name, action, timestamp) 
VALUES (NULL, OLD.pid, OLD.email, OLD.name, 'PATIENT DELETED', NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patientinsertion` AFTER INSERT ON `patients` FOR EACH ROW INSERT INTO `trigger` (tid, pid, email, name, action, timestamp) 
VALUES (NULL, NEW.pid, NEW.email, NEW.name, 'PATIENT INSERTED', NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patientupdate` AFTER UPDATE ON `patients` FOR EACH ROW INSERT INTO `trigger` (tid, pid, email, name, action, timestamp) 
VALUES (NULL, NEW.pid, NEW.email, NEW.name, 'PATIENT UPDATED', NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`id`, `name`, `email`) VALUES
(1, 'test', 'test@email.com');

-- --------------------------------------------------------

--
-- Table structure for table `trigger`
--

CREATE TABLE `trigger` (
  `tid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trigger`
--

INSERT INTO `trigger` (`tid`, `pid`, `email`, `name`, `action`, `timestamp`) VALUES
(1, 21, 'harsimran1472@gmail.com', 'Harsimran Singh', 'PATIENT INSERTED', '2025-02-27 17:30:57'),
(2, 21, 'harsimran1472@gmail.com', 'Harsimran', 'PATIENT UPDATED', '2025-02-27 17:35:53'),
(3, 21, 'harsimran1472@gmail.com', 'Harsimran', 'PATIENT DELETED', '2025-02-27 17:38:40'),
(4, 8, 'harsimran1472@gmail.com', 'Harsimran Singh', 'PATIENT DELETED', '2025-02-27 17:39:52'),
(5, 10, 'harsimran1472@gmail.com', 'Harsimran Singh', 'PATIENT DELETED', '2025-02-27 17:39:53'),
(6, 11, 'harsimran1472@gmail.com', 'Harsimran Singh', 'PATIENT DELETED', '2025-02-27 17:39:54'),
(7, 12, 'harsimran1472@gmail.com', 'Harsimran Singh', 'PATIENT DELETED', '2025-02-27 17:39:55'),
(8, 13, 'harsimran1472@gmail.com', 'Harsimran Singh', 'PATIENT DELETED', '2025-02-27 17:39:55'),
(9, 14, 'harsimran1472@gmail.com', 'Harsimran Singh', 'PATIENT DELETED', '2025-02-27 17:39:56'),
(10, 15, 'harsimran1472@gmail.com', 'Harsimran Singh', 'PATIENT DELETED', '2025-02-27 17:39:56'),
(11, 9, 'harsimran1472@gmail.com', 'Harsimran Singh', 'PATIENT DELETED', '2025-02-27 17:39:57'),
(12, 22, 'harsimran1472@gmail.com', 'Harsimran Singh', 'PATIENT INSERTED', '2025-02-27 18:01:32'),
(13, 23, 'Sharmadamini093@gmail.com', 'buu', 'PATIENT INSERTED', '2025-02-27 18:57:01'),
(14, 22, 'harsimran1472@gmail.com', 'Harsimran', 'PATIENT UPDATED', '2025-03-01 15:46:09');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(60) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`) VALUES
(2, 'someoe', 'soem@gmsil.com', 'scrypt:32768:8:1$BiPvnshT6LcwXQmt$4e9833e342c4c7dbc5a585c8cf73f67a3093146b3be7c0826176a81c2bf33da5de5263a02175ce2e13046e8a495de6fb3befd135734706c927f6f218a574109e'),
(3, 'someone', 'some@gmail.com', 'scrypt:32768:8:1$eB4sAcW1kPRKm9Ar$7855503903bfbd0710f1031e09b2dde6eab846e8415a03144b8f3b3858edd9ee63e24b70a8f1a5a2c82f108677711161010e42a4f2a0a05a786c3d31bcca9028'),
(4, 'test', 'test@gmail.com', 'scrypt:32768:8:1$iY73AemgTz1VILHn$ac0960b0dce3bae911f72232f6fe097746074978d18c2a726c2213e46fcac68e0c7fc3842942ea152e93af30c850755dda5ff45dc1940b8e8b468211b89244a0'),
(5, 'abc', 'abc@gmail.com', 'scrypt:32768:8:1$mcxQmTkXHMEoKTor$dc435087660f50fb74b15e85e8e217b53935adbe2abd1b16555df23283040a530bdd299f7bf0a51588125346e4849c3881b7347671e1429f7d51d78459fd9945'),
(6, 'buchi', 'buchisharma1715@gmail.com', 'scrypt:32768:8:1$fDLEotgf9p5La3hj$a1c0c277d791629d84bbfb78d49d486d594a8bb1fe64cf067e4b1df1adfccd93350a7701725ebf3c5943e0d87a4ab13e023501af15f19c9140016668ef54efa7'),
(7, 'dh', 'simple1234@gmail.com', 'scrypt:32768:8:1$NcCU5Bq9NUQbHo0q$0d4beaf6f810fdc0aa2cd0e32e00205fe705155de6c62915bf8fd917c387bda6256a80af5f7b0e814b716f3eb3bb97069e39a0593790ffeb3aac3a6d528ecd7a'),
(8, 'qwe', 'qwe@gmail.com', 'scrypt:32768:8:1$lIgMda4G0R9imb2P$e338a4c272bfc52a7aa403f0b2738668567996317d38cdc9685fec895b3d6b4327c648444263d6c54ca3eb974a82a4534e680e1ececdf00ffaf92bef9590d9cb'),
(9, 'Mp', 'MP@GMAIL.COM', 'scrypt:32768:8:1$QjrwzKHlbi6clkSP$7b783cb4a1f455e9097af26aedb083411a1980cfbdcafb9a2e3a885855e684ad228db383f2e6a80449eb782d39a2eab027ce4059a9b698164663f81c4fde901f'),
(10, 'xyz', 'xyz@gmail.com', 'scrypt:32768:8:1$lsYex1gJpywppX6r$f103b2eb032c5aaa6022fd0b57518d196e01e1c9b1b6189364f364876d7c77f0887d9d941b76d9f2dd70c04e903971141584ac91b0196f8285a3190b850f716e'),
(11, 'testing', 'testing@gmail.com', 'scrypt:32768:8:1$ZAnZWV9NUjErtRAT$8f8c9877f8258382a10f30c7e487a3049d63632f85a950b638fc65ff3042b89a00b659cf13a55effc83e82cad72861909fe8b955ab2041a7863005132582ea58'),
(12, '123', '123@gmail.com', 'scrypt:32768:8:1$BmIvRDkNfgaQPX6U$ce35e015f8b833327c76fe57a407b33f59107350bf33f689192eef4aab5387ae61bbf3da0eccf9a3812551c3e60a3f0e4550d60b7b0f568e4dd363e32050bd87'),
(13, 'hassi', 'harsimran1472@gmail.com', 'scrypt:32768:8:1$3fg6jFrtWDavAtBf$69c97710ea124bf15e994f511ff4a54181cd3e2c76481d28d72b411e8285540fb20a510b44efd0330f0eb36ad93b0f422b1fe49ac8d931510f41a3a57db48483'),
(14, 'buu', 'Sharmadamini093@gmail.com', 'scrypt:32768:8:1$ICWvFx995CTTGc56$117f16539b23471c616c6c4a0b84e64a5bc7df1a38ed589e887349ce318e293318203a63fc1d9f683ef450390a8961e161b6fb10847bad24664eb241aee5d910');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `nurses`
--
ALTER TABLE `nurses`
  ADD PRIMARY KEY (`nid`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trigger`
--
ALTER TABLE `trigger`
  ADD PRIMARY KEY (`tid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `nurses`
--
ALTER TABLE `nurses`
  MODIFY `nid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `trigger`
--
ALTER TABLE `trigger`
  MODIFY `tid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
