-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Cze 01, 2024 at 08:14 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `surveys`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `answer`
--

CREATE TABLE `answer` (
  `id` int(11) NOT NULL,
  `answer_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `value` varchar(200) NOT NULL,
  `option_id` int(11) NOT NULL,
  `filling_questionary_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `creator`
--

CREATE TABLE `creator` (
  `login` varchar(20) NOT NULL,
  `password` varchar(30) NOT NULL,
  `name` varchar(20) NOT NULL,
  `surname` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `filling_questionaries`
--

CREATE TABLE `filling_questionaries` (
  `id` int(11) NOT NULL,
  `start_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `end_time` timestamp NULL DEFAULT NULL,
  `points` int(11) DEFAULT NULL,
  `user_login` varchar(20) NOT NULL,
  `questionary_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `option`
--

CREATE TABLE `option` (
  `id` int(11) NOT NULL,
  `value` varchar(50) DEFAULT NULL,
  `is_correct` tinyint(1) NOT NULL DEFAULT 0,
  `is_editable` tinyint(1) NOT NULL DEFAULT 0,
  `question_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `question`
--

CREATE TABLE `question` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `is_obligatory` tinyint(1) NOT NULL DEFAULT 0,
  `questionary_id` int(11) NOT NULL,
  `question_type_name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `questionary`
--

CREATE TABLE `questionary` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` text DEFAULT NULL,
  `create_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `category` varchar(20) DEFAULT NULL,
  `creator_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `question_type`
--

CREATE TABLE `question_type` (
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user`
--

CREATE TABLE `user` (
  `login` varchar(20) NOT NULL,
  `password` varchar(30) NOT NULL,
  `name` varchar(20) NOT NULL,
  `surname` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `answer`
--
ALTER TABLE `answer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `option_id` (`option_id`),
  ADD KEY `filling_questionary_id` (`filling_questionary_id`);

--
-- Indeksy dla tabeli `creator`
--
ALTER TABLE `creator`
  ADD PRIMARY KEY (`login`);

--
-- Indeksy dla tabeli `filling_questionaries`
--
ALTER TABLE `filling_questionaries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `questionary_id` (`questionary_id`),
  ADD KEY `user_login` (`user_login`);

--
-- Indeksy dla tabeli `option`
--
ALTER TABLE `option`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indeksy dla tabeli `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `questionary_id` (`questionary_id`),
  ADD KEY `question_type_name` (`question_type_name`);

--
-- Indeksy dla tabeli `questionary`
--
ALTER TABLE `questionary`
  ADD PRIMARY KEY (`id`),
  ADD KEY `creatorID` (`creator_id`);

--
-- Indeksy dla tabeli `question_type`
--
ALTER TABLE `question_type`
  ADD PRIMARY KEY (`name`);

--
-- Indeksy dla tabeli `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`login`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `answer`
--
ALTER TABLE `answer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `filling_questionaries`
--
ALTER TABLE `filling_questionaries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `option`
--
ALTER TABLE `option`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `questionary`
--
ALTER TABLE `questionary`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `answer`
--
ALTER TABLE `answer`
  ADD CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`option_id`) REFERENCES `option` (`id`),
  ADD CONSTRAINT `answer_ibfk_2` FOREIGN KEY (`filling_questionary_id`) REFERENCES `filling_questionaries` (`id`);

--
-- Constraints for table `filling_questionaries`
--
ALTER TABLE `filling_questionaries`
  ADD CONSTRAINT `filling_questionaries_ibfk_1` FOREIGN KEY (`questionary_id`) REFERENCES `questionary` (`id`),
  ADD CONSTRAINT `filling_questionaries_ibfk_2` FOREIGN KEY (`user_login`) REFERENCES `user` (`login`);

--
-- Constraints for table `option`
--
ALTER TABLE `option`
  ADD CONSTRAINT `option_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`);

--
-- Constraints for table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `question_ibfk_1` FOREIGN KEY (`questionary_id`) REFERENCES `questionary` (`id`),
  ADD CONSTRAINT `question_ibfk_2` FOREIGN KEY (`question_type_name`) REFERENCES `question_type` (`name`);

--
-- Constraints for table `questionary`
--
ALTER TABLE `questionary`
  ADD CONSTRAINT `questionary_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `creator` (`login`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
