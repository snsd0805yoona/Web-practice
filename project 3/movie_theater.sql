-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: May 09, 2021 at 07:26 PM
-- Server version: 5.7.24
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `movie_theater`
--

-- --------------------------------------------------------

--
-- Table structure for table `actor`
--

CREATE TABLE `actor` (
  `actorid` int(11) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `actor`
--

INSERT INTO `actor` (`actorid`, `name`) VALUES
(43, ' Ben Stiller'),
(28, ' Chris Evans'),
(51, ' Ming-Na Wen'),
(29, ' Scarlet Johnason'),
(52, 'Anna Kendrick'),
(38, 'Anne Hathaway'),
(50, 'BD Wong'),
(44, 'Blythe Danner'),
(34, 'Cate Blanchett'),
(46, 'Charlize Theron'),
(41, 'Chris Pine'),
(49, 'Eddie Murphy'),
(40, 'Gal Gadot'),
(33, 'Harrison Ford'),
(47, 'Jason Bateman'),
(53, 'Justin Timberlake'),
(35, 'Karen Allen'),
(48, 'Ming-Na Wen'),
(30, 'Reese Witherspoon'),
(39, 'Rene Russo'),
(37, 'Robert De Niro'),
(27, 'Robert Downey Jr.'),
(42, 'Robin Wright'),
(36, 'Shia LaBeouf'),
(31, 'Song Kang-ho'),
(32, 'Thomas Kretschmann'),
(45, 'Will Smith'),
(54, 'Zooey Deschanel');

-- --------------------------------------------------------

--
-- Table structure for table `cart_own_movie`
--

CREATE TABLE `cart_own_movie` (
  `userid` int(11) NOT NULL,
  `movieid` int(11) NOT NULL,
  `number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `CategoryID` int(11) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`CategoryID`, `name`) VALUES
(17, ' Romance'),
(18, 'Action'),
(21, 'Adventure'),
(24, 'Animation'),
(16, 'Comedy'),
(19, 'Drama'),
(25, 'Family'),
(23, 'Fantasy'),
(20, 'History'),
(26, 'Musical'),
(22, 'Romance'),
(15, 'Science Fiction'),
(27, 'War');

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE `movie` (
  `MovieID` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `ticket` int(11) NOT NULL,
  `image` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `movie`
--

INSERT INTO `movie` (`MovieID`, `title`, `description`, `price`, `ticket`, `image`) VALUES
(1, 'Avengers', 'Iron man establish the avengers to fight with Loki', 5, 193, 'Endgame.jpg'),
(2, 'Legally Blonde', 'Fashion merchandising student and sorority girl Elle Woods is taken to an expensive restaurant by her boyfriend, the governor\'s son, Warner Huntington III. She expects Warner to propose, but he breaks up with her instead.', 4, 93, 'Legally Blonde.jpg'),
(3, 'A Taxi Driver', 'The film centers around the Gwangju Uprising that occurred from May 18, 1980 to May 27, 1980 and it is estimated to have led to 2,000 people being killed. The plot in the film mirrors the historical background of the Gwangju Uprisings.', 5, 194, 'A Taxi Driver.jpg'),
(5, 'The intern', 'Seventy-year-old widower Ben Whittaker has discovered that retirement isn\'t all it\'s cracked up to be. Seizing an opportunity to get back in the game, he becomes a senior intern at an online fashion site, founded and run by Jules Ostin.', 5, 100, 'The Intern.jpg'),
(6, 'Wonder Woman', 'When a pilot crashes and tells of conflict in the outside world, Diana, an Amazonian warrior in training, leaves home to fight a war, discovering her full powers and true destiny.', 5, 250, 'Wonder Woman.jpg'),
(7, 'Meet The Fockers', 'All hell breaks loose when the Byrnes family meets the Focker family for the first time.', 2, 50, 'Meet the Fockers.jpg'),
(9, 'Hancock', 'Hancock is a superhero whose ill-considered behavior regularly causes damage in the millions. He changes when the person he saves helps him improve his public image.', 3, 100, 'Hancock.jpg'),
(10, 'Mulan', 'To save her father from death in the army, a young maiden secretly goes in his place and becomes one of China\'s greatest heroines in the process.', 2, 15, 'Mulan.jpg'),
(11, 'Trolls', 'After the Bergens invade Troll Village, Poppy, the happiest Troll ever born, and the curmudgeonly Branch set off on a journey to rescue her friends.', 4, 150, 'Trolls.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `movie_order`
--

CREATE TABLE `movie_order` (
  `orderID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `OrderDate` date NOT NULL,
  `Total_price` double NOT NULL,
  `movieid` int(11) NOT NULL,
  `number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `movie_order`
--

INSERT INTO `movie_order` (`orderID`, `UserID`, `OrderDate`, `Total_price`, `movieid`, `number`) VALUES
(1, 4, '2021-05-05', 36.75, 1, 3),
(2, 4, '2021-05-05', 36.75, 2, 5);

-- --------------------------------------------------------

--
-- Table structure for table `movie_own_actor`
--

CREATE TABLE `movie_own_actor` (
  `movieid` int(11) NOT NULL,
  `actorid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `movie_own_actor`
--

INSERT INTO `movie_own_actor` (`movieid`, `actorid`) VALUES
(1, 27),
(1, 28),
(1, 29),
(2, 30),
(3, 31),
(3, 32),
(5, 37),
(7, 37),
(5, 38),
(5, 39),
(6, 40),
(6, 41),
(6, 42),
(7, 43),
(7, 44),
(9, 45),
(9, 46),
(9, 47),
(10, 49),
(10, 50),
(10, 51),
(11, 52),
(11, 53),
(11, 54);

-- --------------------------------------------------------

--
-- Table structure for table `movie_own_category`
--

CREATE TABLE `movie_own_category` (
  `movieid` int(11) NOT NULL,
  `categoryid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `movie_own_category`
--

INSERT INTO `movie_own_category` (`movieid`, `categoryid`) VALUES
(1, 15),
(2, 16),
(5, 16),
(7, 16),
(11, 16),
(2, 17),
(3, 18),
(6, 18),
(9, 18),
(3, 19),
(5, 19),
(9, 19),
(3, 20),
(6, 21),
(10, 21),
(11, 21),
(7, 22),
(9, 23),
(10, 23),
(11, 23),
(10, 24),
(11, 24),
(10, 25),
(11, 25),
(10, 26),
(11, 26),
(10, 27);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userid` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(128) NOT NULL,
  `Admin_Or_User` tinyint(1) NOT NULL DEFAULT '0',
  `phone` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userid`, `username`, `email`, `password`, `Admin_Or_User`, `phone`) VALUES
(3, 'ad', 'admin1@gmail.com', '$2b$12$nwMilc.C9ZUhW/sU727VPOxh5gb.i9k42vnoauiJM13vubepi3O8S', 1, NULL),
(4, 'user1', 'user1@gmail.com', '$2b$12$baSx7zq/E4Ko/qszKA0Gz.69kHfaJOlrxVfmEX4ew970L6hx92nka', 0, NULL),
(5, 'user2', 'user2@gmail.com', '$2b$12$YrM6CMisOTQCxOZLLpcvEu3kVNHIRPu8DLgZMPL/zboKDyWe/L3pi', 0, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actor`
--
ALTER TABLE `actor`
  ADD PRIMARY KEY (`actorid`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `cart_own_movie`
--
ALTER TABLE `cart_own_movie`
  ADD PRIMARY KEY (`userid`,`movieid`),
  ADD KEY `cart_own_movie_ibfk_2` (`movieid`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`CategoryID`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`MovieID`);

--
-- Indexes for table `movie_order`
--
ALTER TABLE `movie_order`
  ADD PRIMARY KEY (`orderID`,`UserID`) USING BTREE,
  ADD KEY `movie_order_ibfk_1` (`UserID`),
  ADD KEY `movieid` (`movieid`);

--
-- Indexes for table `movie_own_actor`
--
ALTER TABLE `movie_own_actor`
  ADD PRIMARY KEY (`movieid`,`actorid`),
  ADD KEY `actorid` (`actorid`);

--
-- Indexes for table `movie_own_category`
--
ALTER TABLE `movie_own_category`
  ADD PRIMARY KEY (`movieid`,`categoryid`),
  ADD KEY `categoryid` (`categoryid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `actor`
--
ALTER TABLE `actor`
  MODIFY `actorid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `CategoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `movie`
--
ALTER TABLE `movie`
  MODIFY `MovieID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `movie_order`
--
ALTER TABLE `movie_order`
  MODIFY `orderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart_own_movie`
--
ALTER TABLE `cart_own_movie`
  ADD CONSTRAINT `cart_own_movie_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cart_own_movie_ibfk_2` FOREIGN KEY (`movieid`) REFERENCES `movie` (`MovieID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `movie_order`
--
ALTER TABLE `movie_order`
  ADD CONSTRAINT `movie_order_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `movie_order_ibfk_2` FOREIGN KEY (`movieid`) REFERENCES `movie` (`MovieID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `movie_own_actor`
--
ALTER TABLE `movie_own_actor`
  ADD CONSTRAINT `movie_own_actor_ibfk_1` FOREIGN KEY (`movieid`) REFERENCES `movie` (`MovieID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `movie_own_actor_ibfk_2` FOREIGN KEY (`actorid`) REFERENCES `actor` (`actorid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `movie_own_category`
--
ALTER TABLE `movie_own_category`
  ADD CONSTRAINT `movie_own_category_ibfk_1` FOREIGN KEY (`movieid`) REFERENCES `movie` (`MovieID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `movie_own_category_ibfk_2` FOREIGN KEY (`categoryid`) REFERENCES `category` (`CategoryID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
