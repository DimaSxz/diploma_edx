-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Май 29 2016 г., 22:56
-- Версия сервера: 10.1.13-MariaDB
-- Версия PHP: 5.6.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `edxapp`
--

-- --------------------------------------------------------

--
-- Структура таблицы `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `auth_user`
--

INSERT INTO `auth_user` (`id`, `username`, `first_name`, `last_name`, `email`, `password`, `is_staff`, `is_active`, `is_superuser`, `last_login`, `date_joined`) VALUES
(1, 'honor', '', '', 'honor@example.com', 'pbkdf2_sha256$10000$8nodD5Ib39wi$GW0NGcHAUnCWpVvtcA8qxKvYeAWmKbiTDU4nfRzSSng=', 0, 1, 0, '2015-08-07 16:44:05', '2015-08-07 16:44:05'),
(2, 'audit', '', '', 'audit@example.com', 'pbkdf2_sha256$10000$AG8JLGg9bBok$yKIOjlHKqdJ+oqM4tCo3EnRSu8YA4ixgIdbW6TVc3/o=', 0, 1, 0, '2015-08-07 16:44:07', '2015-08-07 16:44:07'),
(3, 'verified', '', '', 'verified@example.com', 'pbkdf2_sha256$10000$j6SdZGn6QiP4$JaJGq0SidkUM7HrQwr6ckB/kO8zKn1WiDG6xH4E/O2k=', 0, 1, 0, '2015-08-07 16:44:10', '2015-08-07 16:44:10'),
(4, 'staff', '', '', 'staff@example.com', 'pbkdf2_sha256$10000$r9JtUMyhGFhc$QmrlzLP3GeAvDmPnAdWCFRZ/Fc9hJ0ZzCwGtZAZk794=', 1, 1, 0, '2016-04-18 14:19:18', '2015-08-07 16:44:12'),
(5, 'DimaSxz', '', '', 'DimaS300i@yandex.ru', 'pbkdf2_sha256$10000$r9JtUMyhGFhc$QmrlzLP3GeAvDmPnAdWCFRZ/Fc9hJ0ZzCwGtZAZk794=', 1, 1, 1, '2015-10-21 10:55:08', '2015-10-21 10:55:05'),
(6, 'test', '', '', 'twst@wad.rfth', 'pbkdf2_sha256$10000$4MnKUWgBc3AA$dltTjhgmR0l6BML9eh+LUv+1VLlEzki1vmFteI4UeIU=', 1, 0, 1, '2016-05-02 18:50:47', '2016-05-02 18:50:45'),
(7, 'stnkvld', '', '', 'stnkvld@gmail.com', 'edx', 1, 1, 1, '2016-05-29 14:00:00', '2016-05-29 00:00:00'),
(8, 'poketonos', '', '', 'poketonos@gmail.com', 'edx', 0, 1, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(9, 'nasty', '', '', 'perep@gmail.com', 'edx', 1, 1, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(10, 'nataxa_mos', '', '', 'natalimos96@gmail.com', 'edx', 0, 1, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Структура таблицы `auth_userprofile`
--

DROP TABLE IF EXISTS `auth_userprofile`;
CREATE TABLE `auth_userprofile` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `language` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `meta` longtext NOT NULL,
  `courseware` varchar(255) NOT NULL,
  `gender` varchar(6) DEFAULT NULL,
  `mailing_address` longtext,
  `year_of_birth` int(11) DEFAULT NULL,
  `level_of_education` varchar(6) DEFAULT NULL,
  `goals` longtext,
  `allow_certificate` tinyint(1) NOT NULL,
  `country` varchar(2) DEFAULT NULL,
  `city` longtext,
  `bio` varchar(3000) DEFAULT NULL,
  `profile_image_uploaded_at` datetime DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL COMMENT 'Изображение профиля',
  `crop` varchar(32) DEFAULT NULL COMMENT 'Параметры обрезки исходного изображения',
  `angle` int(3) NOT NULL DEFAULT '0' COMMENT 'Угол поворота изображения',
  `rank` int(11) DEFAULT NULL COMMENT ' Положение пользователя в рейтинге по успеваемости на площадке'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `auth_userprofile`
--

INSERT INTO `auth_userprofile` (`id`, `user_id`, `name`, `language`, `location`, `meta`, `courseware`, `gender`, `mailing_address`, `year_of_birth`, `level_of_education`, `goals`, `allow_certificate`, `country`, `city`, `bio`, `profile_image_uploaded_at`, `profile_image`, `crop`, `angle`, `rank`) VALUES
(1, 1, 'honor', '', '', '', 'course.xml', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(2, 2, 'audit', '', '', '', 'course.xml', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(3, 3, 'verified', '', '', '', 'course.xml', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(4, 4, 'staff', '', '', '{"session_id": "43f29137f3c125c4e9eaa27158e9dc53"}', 'course.xml', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(5, 5, 'Петров Дмитрий Владимирович', 'RU', '', '{"session_id": "93bb956a85d1036e4f9549962cc36776"}', 'course.xml', 'm', 'Индустриальный Проспект, Дом 23, Квартира 184', 1997, 'hs', 'Я АДМЕН!!!!!!111!1!1!1!', 1, 'RU', '', NULL, NULL, 'IMG_0077.JPG', '0 62 175 237 175 175', 270, NULL),
(6, 6, 'Дмитрий Петров', '', '', '{"session_id": null}', 'course.xml', 'm', '', 1997, '', 'фуакыпк', 1, '', '', NULL, NULL, NULL, NULL, 0, NULL),
(9, 7, 'Сотников Владислав Владимирович', 'Русский', 'Россия', '', '', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(15, 8, 'Тишков Иван Алексеевич', '', '', '', '', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(16, 9, 'Перепелюк Анастасия Вячеславовна', '', '', '', '', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(17, 10, 'Москаленко Наталья Александровна', '', '', '', '', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `auth_userprofile_extension`
--

DROP TABLE IF EXISTS `auth_userprofile_extension`;
CREATE TABLE `auth_userprofile_extension` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_number` int(3) DEFAULT NULL,
  `links_to_certificates` longtext CHARACTER SET utf8mb4
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `auth_userprofile_extension`
--

INSERT INTO `auth_userprofile_extension` (`id`, `user_id`, `group_number`, `links_to_certificates`) VALUES
(1, 1, 113, NULL),
(2, 2, 123, NULL),
(3, 3, 333, NULL),
(4, 4, 243, NULL),
(5, 5, 433, NULL),
(6, 6, 333, NULL),
(7, 7, 433, NULL),
(8, 8, 433, NULL),
(9, 9, 413, NULL),
(10, 10, 0, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `courseware_studentmodule`
--

DROP TABLE IF EXISTS `courseware_studentmodule`;
CREATE TABLE `courseware_studentmodule` (
  `id` int(11) NOT NULL,
  `module_type` varchar(32) NOT NULL,
  `module_id` varchar(255) NOT NULL,
  `student_id` int(11) NOT NULL,
  `state` longtext,
  `grade` double DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `max_grade` double DEFAULT NULL,
  `done` varchar(8) NOT NULL,
  `course_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `courseware_studentmodule`
--

INSERT INTO `courseware_studentmodule` (`id`, `module_type`, `module_id`, `student_id`, `state`, `grade`, `created`, `modified`, `max_grade`, `done`, `course_id`) VALUES
(1, 'course', 'block-v1:edX+DemoX+Demo_Course+type@course+block@course', 5, '{"position": 3}', NULL, '2015-10-21 11:16:47', '2015-10-21 11:20:05', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(2, 'chapter', 'block-v1:edX+DemoX+Demo_Course+type@chapter+block@d8a6192ade314473a78242dfeedfbf5b', 5, '{"position": 1}', NULL, '2015-10-21 11:16:47', '2015-10-21 11:16:47', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(3, 'sequential', 'block-v1:edX+DemoX+Demo_Course+type@sequential+block@edx_introduction', 5, '{"position": 1}', NULL, '2015-10-21 11:16:48', '2015-10-21 11:16:48', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(4, 'chapter', 'block-v1:edX+DemoX+Demo_Course+type@chapter+block@interactive_demonstrations', 5, '{"position": 2}', NULL, '2015-10-21 11:17:40', '2015-10-21 11:17:40', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(5, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@c554538a57664fac80783b99d9d6da7c', 5, '{"seed": 1, "input_state": {"c554538a57664fac80783b99d9d6da7c_2_1": {}}}', NULL, '2015-10-21 11:17:40', '2015-10-21 11:17:40', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(6, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@d2e35c1d294b4ba0b3b1048615605d2a', 5, '{"seed": 1, "input_state": {"d2e35c1d294b4ba0b3b1048615605d2a_2_1": {}}}', NULL, '2015-10-21 11:17:40', '2015-10-21 11:17:40', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(7, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@a0effb954cca4759994f1ac9e9434bf4', 5, '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:23Z", "attempts": 14, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_0", "choice_2"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 3, '2015-10-21 11:17:40', '2015-10-21 11:18:23', 3, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(8, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@Sample_Algebraic_Problem', 5, '{"correct_map": {"Sample_Algebraic_Problem_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"Sample_Algebraic_Problem_2_1": {}}, "last_submission_time": "2015-10-21T11:19:57Z", "attempts": 2, "seed": 1, "done": true, "student_answers": {"Sample_Algebraic_Problem_2_1": "A*x^2 + sqrt(y)", "Sample_Algebraic_Problem_2_1_dynamath": "<math xmlns=\\"http://www.w3.org/1998/Math/MathML\\">\\r\\n<mstyle displaystyle=\\"true\\">\\r\\n  <mi>A</mi>\\r\\n  <mo>&#x22C5;</mo>\\r\\n  <msup>\\r\\n    <mi>x</mi>\\r\\n    <mn>2</mn>\\r\\n  </msup>\\r\\n  <mo>+</mo>\\r\\n  <msqrt>\\r\\n    <mrow>\\r\\n      <mi>y</mi>\\r\\n    </mrow>\\r\\n  </msqrt>\\r\\n</mstyle>\\r\\n</math>"}}', 1, '2015-10-21 11:17:41', '2015-10-21 11:19:57', 1, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(9, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@Sample_ChemFormula_Problem', 5, '{"seed": 1, "input_state": {"Sample_ChemFormula_Problem_2_1": {}}}', NULL, '2015-10-21 11:17:41', '2015-10-21 11:17:41', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(10, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@75f9562c77bc4858b61f907bb810d974', 5, '{"seed": 1, "input_state": {"75f9562c77bc4858b61f907bb810d974_2_1": {}, "75f9562c77bc4858b61f907bb810d974_3_1": {}, "75f9562c77bc4858b61f907bb810d974_4_1": {}}}', NULL, '2015-10-21 11:17:41', '2015-10-21 11:17:41', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(11, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@0d759dee4f9d459c8956136dbde55f02', 5, '{"seed": 1, "input_state": {"0d759dee4f9d459c8956136dbde55f02_2_1": {}}}', NULL, '2015-10-21 11:17:41', '2015-10-21 11:17:41', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(12, 'sequential', 'block-v1:edX+DemoX+Demo_Course+type@sequential+block@basic_questions', 5, '{"position": 5}', NULL, '2015-10-21 11:17:41', '2015-10-21 11:20:02', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(13, 'video', 'block-v1:edX+DemoX+Demo_Course+type@video+block@0b9e39477cf34507a7a48f74be381fdd', 5, '{"saved_video_position": "00:01:45"}', NULL, '2015-10-21 11:17:42', '2015-10-21 11:17:42', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(14, 'chapter', 'block-v1:edX+DemoX+Demo_Course+type@chapter+block@graded_interactions', 5, '{"position": 3}', NULL, '2015-10-21 11:20:05', '2015-10-21 11:20:05', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(15, 'sequential', 'block-v1:edX+DemoX+Demo_Course+type@sequential+block@175e76c4951144a29d46211361266e0e', 5, '{"position": 1}', NULL, '2015-10-21 11:20:06', '2015-10-21 11:20:06', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(16, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@303034da25524878a2e66fb57c91cf85', 4, '{"seed": 1, "input_state": {"303034da25524878a2e66fb57c91cf85_2_1": {}}}', NULL, '2016-04-18 14:22:49', '2016-04-18 14:22:49', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(17, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@932e6f2ce8274072a355a94560216d1a', 4, '{"seed": 1, "input_state": {"932e6f2ce8274072a355a94560216d1a_2_1": {}}}', NULL, '2016-04-18 14:22:49', '2016-04-18 14:22:49', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(18, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@9cee77a606ea4c1aa5440e0ea5d0f618', 4, '{"seed": 1, "input_state": {"9cee77a606ea4c1aa5440e0ea5d0f618_2_1": {}}}', NULL, '2016-04-18 14:22:49', '2016-04-18 14:22:49', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(19, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@0d759dee4f9d459c8956136dbde55f02', 4, '{"seed": 1, "input_state": {"0d759dee4f9d459c8956136dbde55f02_2_1": {}}}', NULL, '2016-04-18 14:22:49', '2016-04-18 14:22:49', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(20, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@75f9562c77bc4858b61f907bb810d974', 4, '{"seed": 1, "input_state": {"75f9562c77bc4858b61f907bb810d974_2_1": {}, "75f9562c77bc4858b61f907bb810d974_3_1": {}, "75f9562c77bc4858b61f907bb810d974_4_1": {}}}', NULL, '2016-04-18 14:22:50', '2016-04-18 14:22:50', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(21, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@Sample_ChemFormula_Problem', 4, '{"seed": 1, "input_state": {"Sample_ChemFormula_Problem_2_1": {}}}', NULL, '2016-04-18 14:22:50', '2016-04-18 14:22:50', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(22, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@Sample_Algebraic_Problem', 4, '{"seed": 1, "input_state": {"Sample_Algebraic_Problem_2_1": {}}}', NULL, '2016-04-18 14:22:50', '2016-04-18 14:22:50', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(23, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@a0effb954cca4759994f1ac9e9434bf4', 4, '{"seed": 1, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}}', NULL, '2016-04-18 14:22:50', '2016-04-18 14:22:50', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(24, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@d2e35c1d294b4ba0b3b1048615605d2a', 4, '{"seed": 1, "input_state": {"d2e35c1d294b4ba0b3b1048615605d2a_2_1": {}}}', NULL, '2016-04-18 14:22:50', '2016-04-18 14:22:50', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(25, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@c554538a57664fac80783b99d9d6da7c', 4, '{"seed": 1, "input_state": {"c554538a57664fac80783b99d9d6da7c_2_1": {}}}', NULL, '2016-04-18 14:22:50', '2016-04-18 14:22:50', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(26, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@700x_proteinmake', 4, '{"seed": 1, "input_state": {"700x_proteinmake_2_1": {}}}', NULL, '2016-04-18 14:22:50', '2016-04-18 14:22:50', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(27, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@logic_gate_problem', 4, '{"seed": 1, "input_state": {"logic_gate_problem_2_1": {}}}', NULL, '2016-04-18 14:22:50', '2016-04-18 14:22:50', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(28, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@free_form_simulation', 4, '{"seed": 1, "input_state": {"free_form_simulation_2_1": {}}}', NULL, '2016-04-18 14:22:50', '2016-04-18 14:22:50', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(29, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@python_grader', 4, '{"seed": 1, "input_state": {"python_grader_2_1": {}}}', NULL, '2016-04-18 14:22:50', '2016-04-18 14:22:50', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(30, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@700x_editmolB', 4, '{"seed": 1, "input_state": {"700x_editmolB_2_1": {}}}', NULL, '2016-04-18 14:22:50', '2016-04-18 14:22:50', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(31, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@ex_practice_3', 4, '{"seed": 365, "input_state": {"ex_practice_3_2_1": {}}}', NULL, '2016-04-18 14:22:51', '2016-04-18 14:22:51', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(32, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@d1b84dcd39b0423d9e288f27f0f7f242', 4, '{"seed": 1, "input_state": {"d1b84dcd39b0423d9e288f27f0f7f242_2_1": {}}}', NULL, '2016-04-18 14:22:51', '2016-04-18 14:22:51', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(33, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@ex_practice_limited_checks', 4, '{"seed": 1, "input_state": {"ex_practice_limited_checks_2_1": {}}}', NULL, '2016-04-18 14:22:51', '2016-04-18 14:22:51', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(34, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@651e0945b77f42e0a4c89b8c3e6f5b3b', 4, '{"seed": 1, "input_state": {"651e0945b77f42e0a4c89b8c3e6f5b3b_2_1": {}}}', NULL, '2016-04-18 14:22:51', '2016-04-18 14:22:51', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(35, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@45d46192272c4f6db6b63586520bbdf4', 4, '{"seed": 1, "input_state": {"45d46192272c4f6db6b63586520bbdf4_2_1": {}}}', NULL, '2016-04-18 14:22:51', '2016-04-18 14:22:51', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(36, 'problem', 'block-v1:edX+DemoX+Demo_Course+type@problem+block@ex_practice_2', 4, '{"seed": 1, "input_state": {"ex_practice_2_2_1": {}}}', NULL, '2016-04-18 14:22:51', '2016-04-18 14:22:51', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(37, 'course', 'block-v1:edX+DemoX+Demo_Course+type@course+block@course', 4, '{"position": 1}', NULL, '2016-04-18 14:23:02', '2016-04-18 14:23:02', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(38, 'chapter', 'block-v1:edX+DemoX+Demo_Course+type@chapter+block@d8a6192ade314473a78242dfeedfbf5b', 4, '{"position": 1}', NULL, '2016-04-18 14:23:02', '2016-04-18 14:23:02', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(39, 'sequential', 'block-v1:edX+DemoX+Demo_Course+type@sequential+block@edx_introduction', 4, '{"position": 1}', NULL, '2016-04-18 14:23:02', '2016-04-18 14:23:02', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course'),
(40, 'problem', 'course-v1:FSPO+MyTestCourse+today', 1, NULL, 1, '0000-00-00 00:00:00', '2015-05-29 20:00:00', 15, '', 'course-v1:FSPO+MyTestCourse+today'),
(41, 'problem', 'course-v1:FSPO+MyTestCourse+today', 2, NULL, 2, '0000-00-00 00:00:00', '2016-05-28 00:00:00', 15, '', 'course-v1:FSPO+MyTestCourse+today'),
(42, 'problem', 'course-v1:FSPO+MyTestCourse+today', 3, NULL, 3, '0000-00-00 00:00:00', '2016-05-27 00:00:00', 15, '', 'course-v1:FSPO+MyTestCourse+today'),
(43, 'problem', 'course-v1:FSPO+MyTestCourse+today', 4, NULL, 4, '0000-00-00 00:00:00', '2015-05-28 23:59:59', 15, '', 'course-v1:FSPO+MyTestCourse+today'),
(44, 'problem', 'block-v1:FSPO+MyTestCourse+today+type@course+block@course', 5, NULL, 15, '0000-00-00 00:00:00', '2016-05-29 03:00:14', 15, '', 'course-v1:FSPO+MyTestCourse+today'),
(45, 'problem', 'course-v1:FSPO+MyTestCourse+today', 6, NULL, 5, '0000-00-00 00:00:00', '2015-05-29 03:00:00', 15, '', 'course-v1:FSPO+MyTestCourse+today'),
(46, 'problem', 'course-v1:FSPO+MyTestCourse+today', 7, NULL, 10, '0000-00-00 00:00:00', '2016-05-22 07:00:00', 15, '', 'course-v1:FSPO+MyTestCourse+today'),
(47, 'problem', 'course-v1:FSPO+MyTestCourse+today', 8, NULL, 7, '0000-00-00 00:00:00', '2016-05-15 00:17:00', 15, '', 'course-v1:FSPO+MyTestCourse+today'),
(48, 'problem', 'course-v1:FSPO+MyTestCourse+today', 9, NULL, 7, '0000-00-00 00:00:00', '2016-05-29 00:00:00', 15, '', 'course-v1:FSPO+MyTestCourse+today'),
(49, 'problem', 'course-v1:FSPO+MyTestCourse+today', 10, NULL, 1, '0000-00-00 00:00:00', '2016-05-29 00:00:00', 15, '', 'course-v1:FSPO+MyTestCourse+today');

-- --------------------------------------------------------

--
-- Структура таблицы `student_courseenrollment`
--

DROP TABLE IF EXISTS `student_courseenrollment`;
CREATE TABLE `student_courseenrollment` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `created` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `mode` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `student_courseenrollment`
--

INSERT INTO `student_courseenrollment` (`id`, `user_id`, `course_id`, `created`, `is_active`, `mode`) VALUES
(1, 1, 'edX/DemoX/Demo_Course', '2015-08-07 16:44:05', 1, 'honor'),
(2, 2, 'edX/DemoX/Demo_Course', '2015-08-07 16:44:08', 1, 'audit'),
(3, 3, 'edX/DemoX/Demo_Course', '2015-08-07 16:44:10', 1, 'verified'),
(4, 4, 'edX/DemoX/Demo_Course', '2015-08-07 16:44:12', 1, 'honor'),
(5, 5, 'course-v1:edX+DemoX+Demo_Course', '2015-10-21 11:16:33', 1, 'honor'),
(6, 4, 'course-v1:edX+DemoX+Demo_Course', '2016-04-18 14:21:11', 1, 'honor'),
(7, 4, 'course-v1:ITMO+1+today', '2016-04-18 14:24:22', 1, 'honor'),
(9, 5, 'course-v1:FSPO+MyTestCourse+today', '2016-05-29 00:00:00', 1, 'verified'),
(10, 6, 'course-v1:FSPO+MyTestCourse+today', '2015-05-29 23:59:59', 1, 'audit'),
(11, 7, 'course-v1:FSPO+MyTestCourse+today', '2016-05-22 00:00:00', 1, 'verified'),
(12, 8, 'course-v1:FSPO+MyTestCourse+today', '2015-05-15 00:00:00', 1, 'verified'),
(13, 9, 'course-v1:FSPO+MyTestCourse+today', '2016-05-29 10:01:11', 1, 'honor'),
(14, 10, 'course-v1:FSPO+MyTestCourse+today', '2016-05-29 22:22:22', 1, 'honor'),
(15, 1, 'course-v1:FSPO+MyTestCourse+today', '2015-05-29 00:00:00', 1, 'honor'),
(16, 2, 'course-v1:FSPO+MyTestCourse+today', '2015-05-29 00:00:00', 1, 'honor'),
(17, 3, 'course-v1:FSPO+MyTestCourse+today', '2015-05-29 00:00:00', 1, 'honor'),
(18, 4, 'course-v1:FSPO+MyTestCourse+today', '2015-05-29 00:00:00', 1, 'audit');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Индексы таблицы `auth_userprofile`
--
ALTER TABLE `auth_userprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `auth_userprofile_52094d6e` (`name`),
  ADD KEY `auth_userprofile_8a7ac9ab` (`language`),
  ADD KEY `auth_userprofile_b54954de` (`location`),
  ADD KEY `auth_userprofile_fca3d292` (`gender`),
  ADD KEY `auth_userprofile_d85587` (`year_of_birth`),
  ADD KEY `auth_userprofile_551e365c` (`level_of_education`);

--
-- Индексы таблицы `auth_userprofile_extension`
--
ALTER TABLE `auth_userprofile_extension`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Индексы таблицы `courseware_studentmodule`
--
ALTER TABLE `courseware_studentmodule`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `courseware_studentmodule_student_id_635d77aea1256de5_uniq` (`student_id`,`module_id`,`course_id`),
  ADD KEY `courseware_studentmodule_42ff452e` (`student_id`),
  ADD KEY `courseware_studentmodule_3216ff68` (`created`),
  ADD KEY `courseware_studentmodule_6dff86b5` (`grade`),
  ADD KEY `courseware_studentmodule_5436e97a` (`modified`),
  ADD KEY `courseware_studentmodule_2d8768ff` (`module_type`),
  ADD KEY `courseware_studentmodule_f53ed95e` (`module_id`),
  ADD KEY `courseware_studentmodule_1923c03f` (`done`),
  ADD KEY `courseware_studentmodule_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `student_courseenrollment`
--
ALTER TABLE `student_courseenrollment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_courseenrollment_user_id_2d2a572f07dd8e37_uniq` (`user_id`,`course_id`),
  ADD KEY `student_courseenrollment_fbfc09f1` (`user_id`),
  ADD KEY `student_courseenrollment_ff48d8e5` (`course_id`),
  ADD KEY `student_courseenrollment_3216ff68` (`created`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT для таблицы `auth_userprofile`
--
ALTER TABLE `auth_userprofile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT для таблицы `auth_userprofile_extension`
--
ALTER TABLE `auth_userprofile_extension`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT для таблицы `courseware_studentmodule`
--
ALTER TABLE `courseware_studentmodule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;
--
-- AUTO_INCREMENT для таблицы `student_courseenrollment`
--
ALTER TABLE `student_courseenrollment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `auth_userprofile`
--
ALTER TABLE `auth_userprofile`
  ADD CONSTRAINT `user_id_refs_id_628b4c11` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `courseware_studentmodule`
--
ALTER TABLE `courseware_studentmodule`
  ADD CONSTRAINT `student_id_refs_id_79ba2570` FOREIGN KEY (`student_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `student_courseenrollment`
--
ALTER TABLE `student_courseenrollment`
  ADD CONSTRAINT `user_id_refs_id_ed37bc9d` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
