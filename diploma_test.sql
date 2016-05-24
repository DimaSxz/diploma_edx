-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Ноя 20 2015 г., 01:30
-- Версия сервера: 10.1.8-MariaDB
-- Версия PHP: 5.6.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `diploma_test`
--
CREATE DATABASE IF NOT EXISTS `diploma_test` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `diploma_test`;

-- --------------------------------------------------------

--
-- Структура таблицы `auth_user`
--

CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `auth_userprofile`
--

CREATE TABLE IF NOT EXISTS `auth_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `crop` varchar(32) DEFAULT NULL,
  `angle` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `courses`
--

CREATE TABLE IF NOT EXISTS `courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `subject_id` int(11) NOT NULL,
  `description` varchar(3000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `subjects`
--

CREATE TABLE IF NOT EXISTS `subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_title` varchar(255) NOT NULL,
  `short_title` varchar(10) NOT NULL,
  `category` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `subjects`
--

INSERT INTO `subjects` (`id`, `full_title`, `short_title`, `category`) VALUES
(1, 'Математические методы', 'ММ', 1),
(2, 'Математические методы', 'ММ', 2),
(3, 'Англйиский язык', 'АЯ', 3),
(4, 'Программное обеспечение компьютерных сетей', 'ПОКС', 2),
(5, 'Теория вероятностей и математическая статистика', 'ТВ', 2),
(6, 'Численные методы', 'ЧМ', 1),
(7, 'Дискретная математика', 'ДМ', 1),
(8, 'Рсский язык', 'РЯ', 3),
(9, 'Элементы высшей математики', 'ЭВМ', 1),
(10, 'Физика', 'Ф', 2),
(11, 'Физическая культура', 'ФЗ', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `user_subjects`
--

CREATE TABLE IF NOT EXISTS `user_subjects` (
  `user_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
