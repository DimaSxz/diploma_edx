-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Май 24 2016 г., 16:49
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
CREATE DATABASE IF NOT EXISTS `edxapp` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `edxapp`;

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_aiclassifier`
--

CREATE TABLE `assessment_aiclassifier` (
  `id` int(11) NOT NULL,
  `classifier_set_id` int(11) NOT NULL,
  `criterion_id` int(11) NOT NULL,
  `classifier_data` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_aiclassifierset`
--

CREATE TABLE `assessment_aiclassifierset` (
  `id` int(11) NOT NULL,
  `rubric_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `algorithm_id` varchar(128) NOT NULL,
  `course_id` varchar(40) NOT NULL,
  `item_id` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_aigradingworkflow`
--

CREATE TABLE `assessment_aigradingworkflow` (
  `id` int(11) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `scheduled_at` datetime NOT NULL,
  `completed_at` datetime DEFAULT NULL,
  `submission_uuid` varchar(128) NOT NULL,
  `classifier_set_id` int(11) DEFAULT NULL,
  `algorithm_id` varchar(128) NOT NULL,
  `rubric_id` int(11) NOT NULL,
  `assessment_id` int(11) DEFAULT NULL,
  `student_id` varchar(40) NOT NULL,
  `item_id` varchar(128) NOT NULL,
  `course_id` varchar(40) NOT NULL,
  `essay_text` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_aitrainingworkflow`
--

CREATE TABLE `assessment_aitrainingworkflow` (
  `id` int(11) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `algorithm_id` varchar(128) NOT NULL,
  `classifier_set_id` int(11) DEFAULT NULL,
  `scheduled_at` datetime NOT NULL,
  `completed_at` datetime DEFAULT NULL,
  `item_id` varchar(128) NOT NULL,
  `course_id` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_aitrainingworkflow_training_examples`
--

CREATE TABLE `assessment_aitrainingworkflow_training_examples` (
  `id` int(11) NOT NULL,
  `aitrainingworkflow_id` int(11) NOT NULL,
  `trainingexample_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_assessment`
--

CREATE TABLE `assessment_assessment` (
  `id` int(11) NOT NULL,
  `submission_uuid` varchar(128) NOT NULL,
  `rubric_id` int(11) NOT NULL,
  `scored_at` datetime NOT NULL,
  `scorer_id` varchar(40) NOT NULL,
  `score_type` varchar(2) NOT NULL,
  `feedback` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_assessmentfeedback`
--

CREATE TABLE `assessment_assessmentfeedback` (
  `id` int(11) NOT NULL,
  `submission_uuid` varchar(128) NOT NULL,
  `feedback_text` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_assessmentfeedbackoption`
--

CREATE TABLE `assessment_assessmentfeedbackoption` (
  `id` int(11) NOT NULL,
  `text` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_assessmentfeedback_assessments`
--

CREATE TABLE `assessment_assessmentfeedback_assessments` (
  `id` int(11) NOT NULL,
  `assessmentfeedback_id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_assessmentfeedback_options`
--

CREATE TABLE `assessment_assessmentfeedback_options` (
  `id` int(11) NOT NULL,
  `assessmentfeedback_id` int(11) NOT NULL,
  `assessmentfeedbackoption_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_assessmentpart`
--

CREATE TABLE `assessment_assessmentpart` (
  `id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  `feedback` longtext NOT NULL,
  `criterion_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_criterion`
--

CREATE TABLE `assessment_criterion` (
  `id` int(11) NOT NULL,
  `rubric_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `order_num` int(10) UNSIGNED NOT NULL,
  `prompt` longtext NOT NULL,
  `label` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `assessment_criterion`
--

INSERT INTO `assessment_criterion` (`id`, `rubric_id`, `name`, `order_num`, `prompt`, `label`) VALUES
(1, 1, 'Content', 0, 'Did the response describe a meal and did it describe why someone should chose to eat it? ', 'Content'),
(2, 1, 'Organization & Clarity', 1, 'How well did the response use language?', 'Organization & Clarity'),
(3, 1, 'Persuasiveness', 2, 'How well did the response convince you to try the meal that it describes?', 'Persuasiveness');

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_criterionoption`
--

CREATE TABLE `assessment_criterionoption` (
  `id` int(11) NOT NULL,
  `criterion_id` int(11) NOT NULL,
  `order_num` int(10) UNSIGNED NOT NULL,
  `points` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `explanation` longtext NOT NULL,
  `label` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `assessment_criterionoption`
--

INSERT INTO `assessment_criterionoption` (`id`, `criterion_id`, `order_num`, `points`, `name`, `explanation`, `label`) VALUES
(1, 1, 0, 0, 'Off Topic', 'The essay is off-topic or does not answer all or part of the question.', 'Off Topic'),
(2, 1, 1, 5, 'No Explanation', 'A meal is described, but no argument is made to persuade the reader to try it.', 'No Explanation'),
(3, 1, 2, 5, 'Unclear recommendation', 'A meal is not described, but an argument is made to persuade the reader to try it.', 'Unclear recommendation'),
(4, 1, 3, 10, 'Persuasive recommendation', 'The essay give a good description of the meal and provides supporting reasons for trying the meal.', 'Persuasive recommendation'),
(5, 2, 0, 0, 'Confusing', 'It is difficult to identify the argument and main idea. ', 'Confusing'),
(6, 2, 1, 1, 'Basic Structure', 'The essay provides a main idea. Additional details are provided, and some support the main idea.', 'Basic Structure'),
(7, 2, 2, 2, 'Clear Structure', 'The essay provides a clear main idea supported by specific details.', 'Clear Structure'),
(8, 2, 3, 3, 'Complete Structure', 'The essay has a complete structure: an introduction, statement of main idea, supporting details and summary. \n', 'Complete Structure'),
(9, 3, 0, 0, 'Unconvincing', 'The author did not present a persuasive argument, and I have no interest in trying this meal.', 'Unconvincing'),
(10, 3, 1, 2, 'Interesting', 'The author’s argument was somewhat persuarsive. I need more information to consider trying this meal.', 'Interesting'),
(11, 3, 2, 4, 'Persuasive', 'The author’s argument was persuasive, and I will consider trying the meal.', 'Persuasive'),
(12, 3, 3, 6, 'Inspiring', 'The author presented an exceptionally strong case and has convinced me to try the meal. \n', 'Inspiring');

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_peerworkflow`
--

CREATE TABLE `assessment_peerworkflow` (
  `id` int(11) NOT NULL,
  `student_id` varchar(40) NOT NULL,
  `item_id` varchar(128) NOT NULL,
  `course_id` varchar(40) NOT NULL,
  `submission_uuid` varchar(128) NOT NULL,
  `created_at` datetime NOT NULL,
  `completed_at` datetime DEFAULT NULL,
  `grading_completed_at` datetime DEFAULT NULL,
  `cancelled_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_peerworkflowitem`
--

CREATE TABLE `assessment_peerworkflowitem` (
  `id` int(11) NOT NULL,
  `scorer_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `submission_uuid` varchar(128) NOT NULL,
  `started_at` datetime NOT NULL,
  `assessment_id` int(11) DEFAULT NULL,
  `scored` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_rubric`
--

CREATE TABLE `assessment_rubric` (
  `id` int(11) NOT NULL,
  `content_hash` varchar(40) NOT NULL,
  `structure_hash` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `assessment_rubric`
--

INSERT INTO `assessment_rubric` (`id`, `content_hash`, `structure_hash`) VALUES
(1, 'b2783932b715f500b0af5f2e0d80757e54301353', 'ab95e8c199881793b6999c5efb1a5754fd7417d5');

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_studenttrainingworkflow`
--

CREATE TABLE `assessment_studenttrainingworkflow` (
  `id` int(11) NOT NULL,
  `submission_uuid` varchar(128) NOT NULL,
  `student_id` varchar(40) NOT NULL,
  `item_id` varchar(128) NOT NULL,
  `course_id` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_studenttrainingworkflowitem`
--

CREATE TABLE `assessment_studenttrainingworkflowitem` (
  `id` int(11) NOT NULL,
  `workflow_id` int(11) NOT NULL,
  `order_num` int(10) UNSIGNED NOT NULL,
  `started_at` datetime NOT NULL,
  `completed_at` datetime DEFAULT NULL,
  `training_example_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_trainingexample`
--

CREATE TABLE `assessment_trainingexample` (
  `id` int(11) NOT NULL,
  `raw_answer` longtext NOT NULL,
  `rubric_id` int(11) NOT NULL,
  `content_hash` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `assessment_trainingexample_options_selected`
--

CREATE TABLE `assessment_trainingexample_options_selected` (
  `id` int(11) NOT NULL,
  `trainingexample_id` int(11) NOT NULL,
  `criterionoption_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add permission', 1, 'add_permission'),
(2, 'Can change permission', 1, 'change_permission'),
(3, 'Can delete permission', 1, 'delete_permission'),
(4, 'Can add group', 2, 'add_group'),
(5, 'Can change group', 2, 'change_group'),
(6, 'Can delete group', 2, 'delete_group'),
(7, 'Can add user', 3, 'add_user'),
(8, 'Can change user', 3, 'change_user'),
(9, 'Can delete user', 3, 'delete_user'),
(10, 'Can add content type', 4, 'add_contenttype'),
(11, 'Can change content type', 4, 'change_contenttype'),
(12, 'Can delete content type', 4, 'delete_contenttype'),
(13, 'Can add session', 5, 'add_session'),
(14, 'Can change session', 5, 'change_session'),
(15, 'Can delete session', 5, 'delete_session'),
(16, 'Can add site', 6, 'add_site'),
(17, 'Can change site', 6, 'change_site'),
(18, 'Can delete site', 6, 'delete_site'),
(19, 'Can add task state', 7, 'add_taskmeta'),
(20, 'Can change task state', 7, 'change_taskmeta'),
(21, 'Can delete task state', 7, 'delete_taskmeta'),
(22, 'Can add saved group result', 8, 'add_tasksetmeta'),
(23, 'Can change saved group result', 8, 'change_tasksetmeta'),
(24, 'Can delete saved group result', 8, 'delete_tasksetmeta'),
(25, 'Can add interval', 9, 'add_intervalschedule'),
(26, 'Can change interval', 9, 'change_intervalschedule'),
(27, 'Can delete interval', 9, 'delete_intervalschedule'),
(28, 'Can add crontab', 10, 'add_crontabschedule'),
(29, 'Can change crontab', 10, 'change_crontabschedule'),
(30, 'Can delete crontab', 10, 'delete_crontabschedule'),
(31, 'Can add periodic tasks', 11, 'add_periodictasks'),
(32, 'Can change periodic tasks', 11, 'change_periodictasks'),
(33, 'Can delete periodic tasks', 11, 'delete_periodictasks'),
(34, 'Can add periodic task', 12, 'add_periodictask'),
(35, 'Can change periodic task', 12, 'change_periodictask'),
(36, 'Can delete periodic task', 12, 'delete_periodictask'),
(37, 'Can add worker', 13, 'add_workerstate'),
(38, 'Can change worker', 13, 'change_workerstate'),
(39, 'Can delete worker', 13, 'delete_workerstate'),
(40, 'Can add task', 14, 'add_taskstate'),
(41, 'Can change task', 14, 'change_taskstate'),
(42, 'Can delete task', 14, 'delete_taskstate'),
(43, 'Can add migration history', 15, 'add_migrationhistory'),
(44, 'Can change migration history', 15, 'change_migrationhistory'),
(45, 'Can delete migration history', 15, 'delete_migrationhistory'),
(46, 'Can add server circuit', 16, 'add_servercircuit'),
(47, 'Can change server circuit', 16, 'change_servercircuit'),
(48, 'Can delete server circuit', 16, 'delete_servercircuit'),
(49, 'Can add psychometric data', 17, 'add_psychometricdata'),
(50, 'Can change psychometric data', 17, 'change_psychometricdata'),
(51, 'Can delete psychometric data', 17, 'delete_psychometricdata'),
(52, 'Can add nonce', 18, 'add_nonce'),
(53, 'Can change nonce', 18, 'change_nonce'),
(54, 'Can delete nonce', 18, 'delete_nonce'),
(55, 'Can add association', 19, 'add_association'),
(56, 'Can change association', 19, 'change_association'),
(57, 'Can delete association', 19, 'delete_association'),
(58, 'Can add user open id', 20, 'add_useropenid'),
(59, 'Can change user open id', 20, 'change_useropenid'),
(60, 'Can delete user open id', 20, 'delete_useropenid'),
(61, 'Can add log entry', 21, 'add_logentry'),
(62, 'Can change log entry', 21, 'change_logentry'),
(63, 'Can delete log entry', 21, 'delete_logentry'),
(64, 'Can add cors model', 22, 'add_corsmodel'),
(65, 'Can change cors model', 22, 'change_corsmodel'),
(66, 'Can delete cors model', 22, 'delete_corsmodel'),
(67, 'Can add student module', 23, 'add_studentmodule'),
(68, 'Can change student module', 23, 'change_studentmodule'),
(69, 'Can delete student module', 23, 'delete_studentmodule'),
(70, 'Can add student module history', 24, 'add_studentmodulehistory'),
(71, 'Can change student module history', 24, 'change_studentmodulehistory'),
(72, 'Can delete student module history', 24, 'delete_studentmodulehistory'),
(73, 'Can add x module user state summary field', 25, 'add_xmoduleuserstatesummaryfield'),
(74, 'Can change x module user state summary field', 25, 'change_xmoduleuserstatesummaryfield'),
(75, 'Can delete x module user state summary field', 25, 'delete_xmoduleuserstatesummaryfield'),
(76, 'Can add x module student prefs field', 26, 'add_xmodulestudentprefsfield'),
(77, 'Can change x module student prefs field', 26, 'change_xmodulestudentprefsfield'),
(78, 'Can delete x module student prefs field', 26, 'delete_xmodulestudentprefsfield'),
(79, 'Can add x module student info field', 27, 'add_xmodulestudentinfofield'),
(80, 'Can change x module student info field', 27, 'change_xmodulestudentinfofield'),
(81, 'Can delete x module student info field', 27, 'delete_xmodulestudentinfofield'),
(82, 'Can add offline computed grade', 28, 'add_offlinecomputedgrade'),
(83, 'Can change offline computed grade', 28, 'change_offlinecomputedgrade'),
(84, 'Can delete offline computed grade', 28, 'delete_offlinecomputedgrade'),
(85, 'Can add offline computed grade log', 29, 'add_offlinecomputedgradelog'),
(86, 'Can change offline computed grade log', 29, 'change_offlinecomputedgradelog'),
(87, 'Can delete offline computed grade log', 29, 'delete_offlinecomputedgradelog'),
(88, 'Can add student field override', 30, 'add_studentfieldoverride'),
(89, 'Can change student field override', 30, 'change_studentfieldoverride'),
(90, 'Can delete student field override', 30, 'delete_studentfieldoverride'),
(91, 'Can add x block disable config', 31, 'add_xblockdisableconfig'),
(92, 'Can change x block disable config', 31, 'change_xblockdisableconfig'),
(93, 'Can delete x block disable config', 31, 'delete_xblockdisableconfig'),
(94, 'Can add anonymous user id', 32, 'add_anonymoususerid'),
(95, 'Can change anonymous user id', 32, 'change_anonymoususerid'),
(96, 'Can delete anonymous user id', 32, 'delete_anonymoususerid'),
(97, 'Can add user standing', 33, 'add_userstanding'),
(98, 'Can change user standing', 33, 'change_userstanding'),
(99, 'Can delete user standing', 33, 'delete_userstanding'),
(100, 'Can add user profile', 34, 'add_userprofile'),
(101, 'Can change user profile', 34, 'change_userprofile'),
(102, 'Can delete user profile', 34, 'delete_userprofile'),
(103, 'Can add user signup source', 35, 'add_usersignupsource'),
(104, 'Can change user signup source', 35, 'change_usersignupsource'),
(105, 'Can delete user signup source', 35, 'delete_usersignupsource'),
(106, 'Can add user test group', 36, 'add_usertestgroup'),
(107, 'Can change user test group', 36, 'change_usertestgroup'),
(108, 'Can delete user test group', 36, 'delete_usertestgroup'),
(109, 'Can add registration', 37, 'add_registration'),
(110, 'Can change registration', 37, 'change_registration'),
(111, 'Can delete registration', 37, 'delete_registration'),
(112, 'Can add pending name change', 38, 'add_pendingnamechange'),
(113, 'Can change pending name change', 38, 'change_pendingnamechange'),
(114, 'Can delete pending name change', 38, 'delete_pendingnamechange'),
(115, 'Can add pending email change', 39, 'add_pendingemailchange'),
(116, 'Can change pending email change', 39, 'change_pendingemailchange'),
(117, 'Can delete pending email change', 39, 'delete_pendingemailchange'),
(118, 'Can add password history', 40, 'add_passwordhistory'),
(119, 'Can change password history', 40, 'change_passwordhistory'),
(120, 'Can delete password history', 40, 'delete_passwordhistory'),
(121, 'Can add login failures', 41, 'add_loginfailures'),
(122, 'Can change login failures', 41, 'change_loginfailures'),
(123, 'Can delete login failures', 41, 'delete_loginfailures'),
(124, 'Can add course enrollment', 42, 'add_courseenrollment'),
(125, 'Can change course enrollment', 42, 'change_courseenrollment'),
(126, 'Can delete course enrollment', 42, 'delete_courseenrollment'),
(127, 'Can add manual enrollment audit', 43, 'add_manualenrollmentaudit'),
(128, 'Can change manual enrollment audit', 43, 'change_manualenrollmentaudit'),
(129, 'Can delete manual enrollment audit', 43, 'delete_manualenrollmentaudit'),
(130, 'Can add course enrollment allowed', 44, 'add_courseenrollmentallowed'),
(131, 'Can change course enrollment allowed', 44, 'change_courseenrollmentallowed'),
(132, 'Can delete course enrollment allowed', 44, 'delete_courseenrollmentallowed'),
(133, 'Can add course access role', 45, 'add_courseaccessrole'),
(134, 'Can change course access role', 45, 'change_courseaccessrole'),
(135, 'Can delete course access role', 45, 'delete_courseaccessrole'),
(136, 'Can add dashboard configuration', 46, 'add_dashboardconfiguration'),
(137, 'Can change dashboard configuration', 46, 'change_dashboardconfiguration'),
(138, 'Can delete dashboard configuration', 46, 'delete_dashboardconfiguration'),
(139, 'Can add linked in add to profile configuration', 47, 'add_linkedinaddtoprofileconfiguration'),
(140, 'Can change linked in add to profile configuration', 47, 'change_linkedinaddtoprofileconfiguration'),
(141, 'Can delete linked in add to profile configuration', 47, 'delete_linkedinaddtoprofileconfiguration'),
(142, 'Can add entrance exam configuration', 48, 'add_entranceexamconfiguration'),
(143, 'Can change entrance exam configuration', 48, 'change_entranceexamconfiguration'),
(144, 'Can delete entrance exam configuration', 48, 'delete_entranceexamconfiguration'),
(145, 'Can add language proficiency', 49, 'add_languageproficiency'),
(146, 'Can change language proficiency', 49, 'change_languageproficiency'),
(147, 'Can delete language proficiency', 49, 'delete_languageproficiency'),
(148, 'Can add course enrollment attribute', 50, 'add_courseenrollmentattribute'),
(149, 'Can change course enrollment attribute', 50, 'change_courseenrollmentattribute'),
(150, 'Can delete course enrollment attribute', 50, 'delete_courseenrollmentattribute'),
(151, 'Can add tracking log', 51, 'add_trackinglog'),
(152, 'Can change tracking log', 51, 'change_trackinglog'),
(153, 'Can delete tracking log', 51, 'delete_trackinglog'),
(154, 'Can add rate limit configuration', 52, 'add_ratelimitconfiguration'),
(155, 'Can change rate limit configuration', 52, 'change_ratelimitconfiguration'),
(156, 'Can delete rate limit configuration', 52, 'delete_ratelimitconfiguration'),
(157, 'Can add certificate whitelist', 53, 'add_certificatewhitelist'),
(158, 'Can change certificate whitelist', 53, 'change_certificatewhitelist'),
(159, 'Can delete certificate whitelist', 53, 'delete_certificatewhitelist'),
(160, 'Can add generated certificate', 54, 'add_generatedcertificate'),
(161, 'Can change generated certificate', 54, 'change_generatedcertificate'),
(162, 'Can delete generated certificate', 54, 'delete_generatedcertificate'),
(163, 'Can add example certificate set', 55, 'add_examplecertificateset'),
(164, 'Can change example certificate set', 55, 'change_examplecertificateset'),
(165, 'Can delete example certificate set', 55, 'delete_examplecertificateset'),
(166, 'Can add example certificate', 56, 'add_examplecertificate'),
(167, 'Can change example certificate', 56, 'change_examplecertificate'),
(168, 'Can delete example certificate', 56, 'delete_examplecertificate'),
(169, 'Can add certificate generation course setting', 57, 'add_certificategenerationcoursesetting'),
(170, 'Can change certificate generation course setting', 57, 'change_certificategenerationcoursesetting'),
(171, 'Can delete certificate generation course setting', 57, 'delete_certificategenerationcoursesetting'),
(172, 'Can add certificate generation configuration', 58, 'add_certificategenerationconfiguration'),
(173, 'Can change certificate generation configuration', 58, 'change_certificategenerationconfiguration'),
(174, 'Can delete certificate generation configuration', 58, 'delete_certificategenerationconfiguration'),
(175, 'Can add certificate html view configuration', 59, 'add_certificatehtmlviewconfiguration'),
(176, 'Can change certificate html view configuration', 59, 'change_certificatehtmlviewconfiguration'),
(177, 'Can delete certificate html view configuration', 59, 'delete_certificatehtmlviewconfiguration'),
(178, 'Can add badge assertion', 60, 'add_badgeassertion'),
(179, 'Can change badge assertion', 60, 'change_badgeassertion'),
(180, 'Can delete badge assertion', 60, 'delete_badgeassertion'),
(181, 'Can add badge image configuration', 61, 'add_badgeimageconfiguration'),
(182, 'Can change badge image configuration', 61, 'change_badgeimageconfiguration'),
(183, 'Can delete badge image configuration', 61, 'delete_badgeimageconfiguration'),
(184, 'Can add instructor task', 62, 'add_instructortask'),
(185, 'Can change instructor task', 62, 'change_instructortask'),
(186, 'Can delete instructor task', 62, 'delete_instructortask'),
(187, 'Can add course software', 63, 'add_coursesoftware'),
(188, 'Can change course software', 63, 'change_coursesoftware'),
(189, 'Can delete course software', 63, 'delete_coursesoftware'),
(190, 'Can add user license', 64, 'add_userlicense'),
(191, 'Can change user license', 64, 'change_userlicense'),
(192, 'Can delete user license', 64, 'delete_userlicense'),
(193, 'Can add course user group', 65, 'add_courseusergroup'),
(194, 'Can change course user group', 65, 'change_courseusergroup'),
(195, 'Can delete course user group', 65, 'delete_courseusergroup'),
(196, 'Can add course user group partition group', 66, 'add_courseusergrouppartitiongroup'),
(197, 'Can change course user group partition group', 66, 'change_courseusergrouppartitiongroup'),
(198, 'Can delete course user group partition group', 66, 'delete_courseusergrouppartitiongroup'),
(199, 'Can add course cohorts settings', 67, 'add_coursecohortssettings'),
(200, 'Can change course cohorts settings', 67, 'change_coursecohortssettings'),
(201, 'Can delete course cohorts settings', 67, 'delete_coursecohortssettings'),
(202, 'Can add course cohort', 68, 'add_coursecohort'),
(203, 'Can change course cohort', 68, 'change_coursecohort'),
(204, 'Can delete course cohort', 68, 'delete_coursecohort'),
(205, 'Can add course email', 69, 'add_courseemail'),
(206, 'Can change course email', 69, 'change_courseemail'),
(207, 'Can delete course email', 69, 'delete_courseemail'),
(208, 'Can add optout', 70, 'add_optout'),
(209, 'Can change optout', 70, 'change_optout'),
(210, 'Can delete optout', 70, 'delete_optout'),
(211, 'Can add course email template', 71, 'add_courseemailtemplate'),
(212, 'Can change course email template', 71, 'change_courseemailtemplate'),
(213, 'Can delete course email template', 71, 'delete_courseemailtemplate'),
(214, 'Can add course authorization', 72, 'add_courseauthorization'),
(215, 'Can change course authorization', 72, 'change_courseauthorization'),
(216, 'Can delete course authorization', 72, 'delete_courseauthorization'),
(217, 'Can add branding info config', 73, 'add_brandinginfoconfig'),
(218, 'Can change branding info config', 73, 'change_brandinginfoconfig'),
(219, 'Can delete branding info config', 73, 'delete_brandinginfoconfig'),
(220, 'Can add branding api config', 74, 'add_brandingapiconfig'),
(221, 'Can change branding api config', 74, 'change_brandingapiconfig'),
(222, 'Can delete branding api config', 74, 'delete_brandingapiconfig'),
(223, 'Can add external auth map', 75, 'add_externalauthmap'),
(224, 'Can change external auth map', 75, 'change_externalauthmap'),
(225, 'Can delete external auth map', 75, 'delete_externalauthmap'),
(226, 'Can add client', 76, 'add_client'),
(227, 'Can change client', 76, 'change_client'),
(228, 'Can delete client', 76, 'delete_client'),
(229, 'Can add grant', 77, 'add_grant'),
(230, 'Can change grant', 77, 'change_grant'),
(231, 'Can delete grant', 77, 'delete_grant'),
(232, 'Can add access token', 78, 'add_accesstoken'),
(233, 'Can change access token', 78, 'change_accesstoken'),
(234, 'Can delete access token', 78, 'delete_accesstoken'),
(235, 'Can add refresh token', 79, 'add_refreshtoken'),
(236, 'Can change refresh token', 79, 'change_refreshtoken'),
(237, 'Can delete refresh token', 79, 'delete_refreshtoken'),
(238, 'Can add trusted client', 80, 'add_trustedclient'),
(239, 'Can change trusted client', 80, 'change_trustedclient'),
(240, 'Can delete trusted client', 80, 'delete_trustedclient'),
(241, 'Can add article', 81, 'add_article'),
(242, 'Can change article', 81, 'change_article'),
(243, 'Can delete article', 81, 'delete_article'),
(244, 'Can edit all articles and lock/unlock/restore', 81, 'moderate'),
(245, 'Can change ownership of any article', 81, 'assign'),
(246, 'Can assign permissions to other users', 81, 'grant'),
(247, 'Can add Article for object', 82, 'add_articleforobject'),
(248, 'Can change Article for object', 82, 'change_articleforobject'),
(249, 'Can delete Article for object', 82, 'delete_articleforobject'),
(250, 'Can add article revision', 83, 'add_articlerevision'),
(251, 'Can change article revision', 83, 'change_articlerevision'),
(252, 'Can delete article revision', 83, 'delete_articlerevision'),
(253, 'Can add URL path', 84, 'add_urlpath'),
(254, 'Can change URL path', 84, 'change_urlpath'),
(255, 'Can delete URL path', 84, 'delete_urlpath'),
(256, 'Can add article plugin', 85, 'add_articleplugin'),
(257, 'Can change article plugin', 85, 'change_articleplugin'),
(258, 'Can delete article plugin', 85, 'delete_articleplugin'),
(259, 'Can add reusable plugin', 86, 'add_reusableplugin'),
(260, 'Can change reusable plugin', 86, 'change_reusableplugin'),
(261, 'Can delete reusable plugin', 86, 'delete_reusableplugin'),
(262, 'Can add simple plugin', 87, 'add_simpleplugin'),
(263, 'Can change simple plugin', 87, 'change_simpleplugin'),
(264, 'Can delete simple plugin', 87, 'delete_simpleplugin'),
(265, 'Can add revision plugin', 88, 'add_revisionplugin'),
(266, 'Can change revision plugin', 88, 'change_revisionplugin'),
(267, 'Can delete revision plugin', 88, 'delete_revisionplugin'),
(268, 'Can add revision plugin revision', 89, 'add_revisionpluginrevision'),
(269, 'Can change revision plugin revision', 89, 'change_revisionpluginrevision'),
(270, 'Can delete revision plugin revision', 89, 'delete_revisionpluginrevision'),
(271, 'Can add article subscription', 90, 'add_articlesubscription'),
(272, 'Can change article subscription', 90, 'change_articlesubscription'),
(273, 'Can delete article subscription', 90, 'delete_articlesubscription'),
(274, 'Can add type', 91, 'add_notificationtype'),
(275, 'Can change type', 91, 'change_notificationtype'),
(276, 'Can delete type', 91, 'delete_notificationtype'),
(277, 'Can add settings', 92, 'add_settings'),
(278, 'Can change settings', 92, 'change_settings'),
(279, 'Can delete settings', 92, 'delete_settings'),
(280, 'Can add subscription', 93, 'add_subscription'),
(281, 'Can change subscription', 93, 'change_subscription'),
(282, 'Can delete subscription', 93, 'delete_subscription'),
(283, 'Can add notification', 94, 'add_notification'),
(284, 'Can change notification', 94, 'change_notification'),
(285, 'Can delete notification', 94, 'delete_notification'),
(286, 'Can add score', 95, 'add_score'),
(287, 'Can change score', 95, 'change_score'),
(288, 'Can delete score', 95, 'delete_score'),
(289, 'Can add puzzle complete', 96, 'add_puzzlecomplete'),
(290, 'Can change puzzle complete', 96, 'change_puzzlecomplete'),
(291, 'Can delete puzzle complete', 96, 'delete_puzzlecomplete'),
(292, 'Can add note', 97, 'add_note'),
(293, 'Can change note', 97, 'change_note'),
(294, 'Can delete note', 97, 'delete_note'),
(295, 'Can add splash config', 98, 'add_splashconfig'),
(296, 'Can change splash config', 98, 'change_splashconfig'),
(297, 'Can delete splash config', 98, 'delete_splashconfig'),
(298, 'Can add user preference', 99, 'add_userpreference'),
(299, 'Can change user preference', 99, 'change_userpreference'),
(300, 'Can delete user preference', 99, 'delete_userpreference'),
(301, 'Can add user course tag', 100, 'add_usercoursetag'),
(302, 'Can change user course tag', 100, 'change_usercoursetag'),
(303, 'Can delete user course tag', 100, 'delete_usercoursetag'),
(304, 'Can add user org tag', 101, 'add_userorgtag'),
(305, 'Can change user org tag', 101, 'change_userorgtag'),
(306, 'Can delete user org tag', 101, 'delete_userorgtag'),
(307, 'Can add course team', 102, 'add_courseteam'),
(308, 'Can change course team', 102, 'change_courseteam'),
(309, 'Can delete course team', 102, 'delete_courseteam'),
(310, 'Can add course team membership', 103, 'add_courseteammembership'),
(311, 'Can change course team membership', 103, 'change_courseteammembership'),
(312, 'Can delete course team membership', 103, 'delete_courseteammembership'),
(313, 'Can add order', 104, 'add_order'),
(314, 'Can change order', 104, 'change_order'),
(315, 'Can delete order', 104, 'delete_order'),
(316, 'Can add order item', 105, 'add_orderitem'),
(317, 'Can change order item', 105, 'change_orderitem'),
(318, 'Can delete order item', 105, 'delete_orderitem'),
(319, 'Can add invoice', 106, 'add_invoice'),
(320, 'Can change invoice', 106, 'change_invoice'),
(321, 'Can delete invoice', 106, 'delete_invoice'),
(322, 'Can add invoice transaction', 107, 'add_invoicetransaction'),
(323, 'Can change invoice transaction', 107, 'change_invoicetransaction'),
(324, 'Can delete invoice transaction', 107, 'delete_invoicetransaction'),
(325, 'Can add invoice item', 108, 'add_invoiceitem'),
(326, 'Can change invoice item', 108, 'change_invoiceitem'),
(327, 'Can delete invoice item', 108, 'delete_invoiceitem'),
(328, 'Can add course registration code invoice item', 109, 'add_courseregistrationcodeinvoiceitem'),
(329, 'Can change course registration code invoice item', 109, 'change_courseregistrationcodeinvoiceitem'),
(330, 'Can delete course registration code invoice item', 109, 'delete_courseregistrationcodeinvoiceitem'),
(331, 'Can add invoice history', 110, 'add_invoicehistory'),
(332, 'Can change invoice history', 110, 'change_invoicehistory'),
(333, 'Can delete invoice history', 110, 'delete_invoicehistory'),
(334, 'Can add course registration code', 111, 'add_courseregistrationcode'),
(335, 'Can change course registration code', 111, 'change_courseregistrationcode'),
(336, 'Can delete course registration code', 111, 'delete_courseregistrationcode'),
(337, 'Can add registration code redemption', 112, 'add_registrationcoderedemption'),
(338, 'Can change registration code redemption', 112, 'change_registrationcoderedemption'),
(339, 'Can delete registration code redemption', 112, 'delete_registrationcoderedemption'),
(340, 'Can add coupon', 113, 'add_coupon'),
(341, 'Can change coupon', 113, 'change_coupon'),
(342, 'Can delete coupon', 113, 'delete_coupon'),
(343, 'Can add coupon redemption', 114, 'add_couponredemption'),
(344, 'Can change coupon redemption', 114, 'change_couponredemption'),
(345, 'Can delete coupon redemption', 114, 'delete_couponredemption'),
(346, 'Can add paid course registration', 115, 'add_paidcourseregistration'),
(347, 'Can change paid course registration', 115, 'change_paidcourseregistration'),
(348, 'Can delete paid course registration', 115, 'delete_paidcourseregistration'),
(349, 'Can add course reg code item', 116, 'add_courseregcodeitem'),
(350, 'Can change course reg code item', 116, 'change_courseregcodeitem'),
(351, 'Can delete course reg code item', 116, 'delete_courseregcodeitem'),
(352, 'Can add course reg code item annotation', 117, 'add_courseregcodeitemannotation'),
(353, 'Can change course reg code item annotation', 117, 'change_courseregcodeitemannotation'),
(354, 'Can delete course reg code item annotation', 117, 'delete_courseregcodeitemannotation'),
(355, 'Can add paid course registration annotation', 118, 'add_paidcourseregistrationannotation'),
(356, 'Can change paid course registration annotation', 118, 'change_paidcourseregistrationannotation'),
(357, 'Can delete paid course registration annotation', 118, 'delete_paidcourseregistrationannotation'),
(358, 'Can add certificate item', 119, 'add_certificateitem'),
(359, 'Can change certificate item', 119, 'change_certificateitem'),
(360, 'Can delete certificate item', 119, 'delete_certificateitem'),
(361, 'Can add donation configuration', 120, 'add_donationconfiguration'),
(362, 'Can change donation configuration', 120, 'change_donationconfiguration'),
(363, 'Can delete donation configuration', 120, 'delete_donationconfiguration'),
(364, 'Can add donation', 121, 'add_donation'),
(365, 'Can change donation', 121, 'change_donation'),
(366, 'Can delete donation', 121, 'delete_donation'),
(367, 'Can add course mode', 122, 'add_coursemode'),
(368, 'Can change course mode', 122, 'change_coursemode'),
(369, 'Can delete course mode', 122, 'delete_coursemode'),
(370, 'Can add course modes archive', 123, 'add_coursemodesarchive'),
(371, 'Can change course modes archive', 123, 'change_coursemodesarchive'),
(372, 'Can delete course modes archive', 123, 'delete_coursemodesarchive'),
(373, 'Can add software secure photo verification', 124, 'add_softwaresecurephotoverification'),
(374, 'Can change software secure photo verification', 124, 'change_softwaresecurephotoverification'),
(375, 'Can delete software secure photo verification', 124, 'delete_softwaresecurephotoverification'),
(376, 'Can add verification checkpoint', 125, 'add_verificationcheckpoint'),
(377, 'Can change verification checkpoint', 125, 'change_verificationcheckpoint'),
(378, 'Can delete verification checkpoint', 125, 'delete_verificationcheckpoint'),
(379, 'Can add Verification Status', 126, 'add_verificationstatus'),
(380, 'Can change Verification Status', 126, 'change_verificationstatus'),
(381, 'Can delete Verification Status', 126, 'delete_verificationstatus'),
(382, 'Can add in course reverification configuration', 127, 'add_incoursereverificationconfiguration'),
(383, 'Can change in course reverification configuration', 127, 'change_incoursereverificationconfiguration'),
(384, 'Can delete in course reverification configuration', 127, 'delete_incoursereverificationconfiguration'),
(385, 'Can add skipped reverification', 128, 'add_skippedreverification'),
(386, 'Can change skipped reverification', 128, 'change_skippedreverification'),
(387, 'Can delete skipped reverification', 128, 'delete_skippedreverification'),
(388, 'Can add dark lang config', 129, 'add_darklangconfig'),
(389, 'Can change dark lang config', 129, 'change_darklangconfig'),
(390, 'Can delete dark lang config', 129, 'delete_darklangconfig'),
(391, 'Can add embargoed course', 130, 'add_embargoedcourse'),
(392, 'Can change embargoed course', 130, 'change_embargoedcourse'),
(393, 'Can delete embargoed course', 130, 'delete_embargoedcourse'),
(394, 'Can add embargoed state', 131, 'add_embargoedstate'),
(395, 'Can change embargoed state', 131, 'change_embargoedstate'),
(396, 'Can delete embargoed state', 131, 'delete_embargoedstate'),
(397, 'Can add restricted course', 132, 'add_restrictedcourse'),
(398, 'Can change restricted course', 132, 'change_restrictedcourse'),
(399, 'Can delete restricted course', 132, 'delete_restrictedcourse'),
(400, 'Can add country', 133, 'add_country'),
(401, 'Can change country', 133, 'change_country'),
(402, 'Can delete country', 133, 'delete_country'),
(403, 'Can add country access rule', 134, 'add_countryaccessrule'),
(404, 'Can change country access rule', 134, 'change_countryaccessrule'),
(405, 'Can delete country access rule', 134, 'delete_countryaccessrule'),
(406, 'Can add course access rule history', 135, 'add_courseaccessrulehistory'),
(407, 'Can change course access rule history', 135, 'change_courseaccessrulehistory'),
(408, 'Can delete course access rule history', 135, 'delete_courseaccessrulehistory'),
(409, 'Can add ip filter', 136, 'add_ipfilter'),
(410, 'Can change ip filter', 136, 'change_ipfilter'),
(411, 'Can delete ip filter', 136, 'delete_ipfilter'),
(412, 'Can add course rerun state', 137, 'add_coursererunstate'),
(413, 'Can change course rerun state', 137, 'change_coursererunstate'),
(414, 'Can delete course rerun state', 137, 'delete_coursererunstate'),
(415, 'Can add mobile api config', 138, 'add_mobileapiconfig'),
(416, 'Can change mobile api config', 138, 'change_mobileapiconfig'),
(417, 'Can delete mobile api config', 138, 'delete_mobileapiconfig'),
(418, 'Can add survey form', 139, 'add_surveyform'),
(419, 'Can change survey form', 139, 'change_surveyform'),
(420, 'Can delete survey form', 139, 'delete_surveyform'),
(421, 'Can add survey answer', 140, 'add_surveyanswer'),
(422, 'Can change survey answer', 140, 'change_surveyanswer'),
(423, 'Can delete survey answer', 140, 'delete_surveyanswer'),
(424, 'Can add x block asides config', 141, 'add_xblockasidesconfig'),
(425, 'Can change x block asides config', 141, 'change_xblockasidesconfig'),
(426, 'Can delete x block asides config', 141, 'delete_xblockasidesconfig'),
(427, 'Can add course overview', 142, 'add_courseoverview'),
(428, 'Can change course overview', 142, 'change_courseoverview'),
(429, 'Can delete course overview', 142, 'delete_courseoverview'),
(430, 'Can add course structure', 143, 'add_coursestructure'),
(431, 'Can change course structure', 143, 'change_coursestructure'),
(432, 'Can delete course structure', 143, 'delete_coursestructure'),
(433, 'Can add x domain proxy configuration', 144, 'add_xdomainproxyconfiguration'),
(434, 'Can change x domain proxy configuration', 144, 'change_xdomainproxyconfiguration'),
(435, 'Can delete x domain proxy configuration', 144, 'delete_xdomainproxyconfiguration'),
(436, 'Can add student item', 145, 'add_studentitem'),
(437, 'Can change student item', 145, 'change_studentitem'),
(438, 'Can delete student item', 145, 'delete_studentitem'),
(439, 'Can add submission', 146, 'add_submission'),
(440, 'Can change submission', 146, 'change_submission'),
(441, 'Can delete submission', 146, 'delete_submission'),
(442, 'Can add score', 147, 'add_score'),
(443, 'Can change score', 147, 'change_score'),
(444, 'Can delete score', 147, 'delete_score'),
(445, 'Can add score summary', 148, 'add_scoresummary'),
(446, 'Can change score summary', 148, 'change_scoresummary'),
(447, 'Can delete score summary', 148, 'delete_scoresummary'),
(448, 'Can add rubric', 149, 'add_rubric'),
(449, 'Can change rubric', 149, 'change_rubric'),
(450, 'Can delete rubric', 149, 'delete_rubric'),
(451, 'Can add criterion', 150, 'add_criterion'),
(452, 'Can change criterion', 150, 'change_criterion'),
(453, 'Can delete criterion', 150, 'delete_criterion'),
(454, 'Can add criterion option', 151, 'add_criterionoption'),
(455, 'Can change criterion option', 151, 'change_criterionoption'),
(456, 'Can delete criterion option', 151, 'delete_criterionoption'),
(457, 'Can add assessment', 152, 'add_assessment'),
(458, 'Can change assessment', 152, 'change_assessment'),
(459, 'Can delete assessment', 152, 'delete_assessment'),
(460, 'Can add assessment part', 153, 'add_assessmentpart'),
(461, 'Can change assessment part', 153, 'change_assessmentpart'),
(462, 'Can delete assessment part', 153, 'delete_assessmentpart'),
(463, 'Can add assessment feedback option', 154, 'add_assessmentfeedbackoption'),
(464, 'Can change assessment feedback option', 154, 'change_assessmentfeedbackoption'),
(465, 'Can delete assessment feedback option', 154, 'delete_assessmentfeedbackoption'),
(466, 'Can add assessment feedback', 155, 'add_assessmentfeedback'),
(467, 'Can change assessment feedback', 155, 'change_assessmentfeedback'),
(468, 'Can delete assessment feedback', 155, 'delete_assessmentfeedback'),
(469, 'Can add peer workflow', 156, 'add_peerworkflow'),
(470, 'Can change peer workflow', 156, 'change_peerworkflow'),
(471, 'Can delete peer workflow', 156, 'delete_peerworkflow'),
(472, 'Can add peer workflow item', 157, 'add_peerworkflowitem'),
(473, 'Can change peer workflow item', 157, 'change_peerworkflowitem'),
(474, 'Can delete peer workflow item', 157, 'delete_peerworkflowitem'),
(475, 'Can add training example', 158, 'add_trainingexample'),
(476, 'Can change training example', 158, 'change_trainingexample'),
(477, 'Can delete training example', 158, 'delete_trainingexample'),
(478, 'Can add student training workflow', 159, 'add_studenttrainingworkflow'),
(479, 'Can change student training workflow', 159, 'change_studenttrainingworkflow'),
(480, 'Can delete student training workflow', 159, 'delete_studenttrainingworkflow'),
(481, 'Can add student training workflow item', 160, 'add_studenttrainingworkflowitem'),
(482, 'Can change student training workflow item', 160, 'change_studenttrainingworkflowitem'),
(483, 'Can delete student training workflow item', 160, 'delete_studenttrainingworkflowitem'),
(484, 'Can add ai classifier set', 161, 'add_aiclassifierset'),
(485, 'Can change ai classifier set', 161, 'change_aiclassifierset'),
(486, 'Can delete ai classifier set', 161, 'delete_aiclassifierset'),
(487, 'Can add ai classifier', 162, 'add_aiclassifier'),
(488, 'Can change ai classifier', 162, 'change_aiclassifier'),
(489, 'Can delete ai classifier', 162, 'delete_aiclassifier'),
(490, 'Can add ai training workflow', 163, 'add_aitrainingworkflow'),
(491, 'Can change ai training workflow', 163, 'change_aitrainingworkflow'),
(492, 'Can delete ai training workflow', 163, 'delete_aitrainingworkflow'),
(493, 'Can add ai grading workflow', 164, 'add_aigradingworkflow'),
(494, 'Can change ai grading workflow', 164, 'change_aigradingworkflow'),
(495, 'Can delete ai grading workflow', 164, 'delete_aigradingworkflow'),
(496, 'Can add assessment workflow', 165, 'add_assessmentworkflow'),
(497, 'Can change assessment workflow', 165, 'change_assessmentworkflow'),
(498, 'Can delete assessment workflow', 165, 'delete_assessmentworkflow'),
(499, 'Can add assessment workflow step', 166, 'add_assessmentworkflowstep'),
(500, 'Can change assessment workflow step', 166, 'change_assessmentworkflowstep'),
(501, 'Can delete assessment workflow step', 166, 'delete_assessmentworkflowstep'),
(502, 'Can add assessment workflow cancellation', 167, 'add_assessmentworkflowcancellation'),
(503, 'Can change assessment workflow cancellation', 167, 'change_assessmentworkflowcancellation'),
(504, 'Can delete assessment workflow cancellation', 167, 'delete_assessmentworkflowcancellation'),
(505, 'Can add profile', 168, 'add_profile'),
(506, 'Can change profile', 168, 'change_profile'),
(507, 'Can delete profile', 168, 'delete_profile'),
(508, 'Can add video', 169, 'add_video'),
(509, 'Can change video', 169, 'change_video'),
(510, 'Can delete video', 169, 'delete_video'),
(511, 'Can add course video', 170, 'add_coursevideo'),
(512, 'Can change course video', 170, 'change_coursevideo'),
(513, 'Can delete course video', 170, 'delete_coursevideo'),
(514, 'Can add encoded video', 171, 'add_encodedvideo'),
(515, 'Can change encoded video', 171, 'change_encodedvideo'),
(516, 'Can delete encoded video', 171, 'delete_encodedvideo'),
(517, 'Can add subtitle', 172, 'add_subtitle'),
(518, 'Can change subtitle', 172, 'change_subtitle'),
(519, 'Can delete subtitle', 172, 'delete_subtitle'),
(520, 'Can add milestone', 173, 'add_milestone'),
(521, 'Can change milestone', 173, 'change_milestone'),
(522, 'Can delete milestone', 173, 'delete_milestone'),
(523, 'Can add milestone relationship type', 174, 'add_milestonerelationshiptype'),
(524, 'Can change milestone relationship type', 174, 'change_milestonerelationshiptype'),
(525, 'Can delete milestone relationship type', 174, 'delete_milestonerelationshiptype'),
(526, 'Can add course milestone', 175, 'add_coursemilestone'),
(527, 'Can change course milestone', 175, 'change_coursemilestone'),
(528, 'Can delete course milestone', 175, 'delete_coursemilestone'),
(529, 'Can add course content milestone', 176, 'add_coursecontentmilestone'),
(530, 'Can change course content milestone', 176, 'change_coursecontentmilestone'),
(531, 'Can delete course content milestone', 176, 'delete_coursecontentmilestone'),
(532, 'Can add user milestone', 177, 'add_usermilestone'),
(533, 'Can change user milestone', 177, 'change_usermilestone'),
(534, 'Can delete user milestone', 177, 'delete_usermilestone'),
(535, 'Can add credit provider', 178, 'add_creditprovider'),
(536, 'Can change credit provider', 178, 'change_creditprovider'),
(537, 'Can delete credit provider', 178, 'delete_creditprovider'),
(538, 'Can add credit course', 179, 'add_creditcourse'),
(539, 'Can change credit course', 179, 'change_creditcourse'),
(540, 'Can delete credit course', 179, 'delete_creditcourse'),
(541, 'Can add credit requirement', 180, 'add_creditrequirement'),
(542, 'Can change credit requirement', 180, 'change_creditrequirement'),
(543, 'Can delete credit requirement', 180, 'delete_creditrequirement'),
(544, 'Can add historical credit requirement status', 181, 'add_historicalcreditrequirementstatus'),
(545, 'Can change historical credit requirement status', 181, 'change_historicalcreditrequirementstatus'),
(546, 'Can delete historical credit requirement status', 181, 'delete_historicalcreditrequirementstatus'),
(547, 'Can add credit requirement status', 182, 'add_creditrequirementstatus'),
(548, 'Can change credit requirement status', 182, 'change_creditrequirementstatus'),
(549, 'Can delete credit requirement status', 182, 'delete_creditrequirementstatus'),
(550, 'Can add credit eligibility', 183, 'add_crediteligibility'),
(551, 'Can change credit eligibility', 183, 'change_crediteligibility'),
(552, 'Can delete credit eligibility', 183, 'delete_crediteligibility'),
(553, 'Can add historical credit request', 184, 'add_historicalcreditrequest'),
(554, 'Can change historical credit request', 184, 'change_historicalcreditrequest'),
(555, 'Can delete historical credit request', 184, 'delete_historicalcreditrequest'),
(556, 'Can add credit request', 185, 'add_creditrequest'),
(557, 'Can change credit request', 185, 'change_creditrequest'),
(558, 'Can delete credit request', 185, 'delete_creditrequest'),
(559, 'Can add video upload config', 186, 'add_videouploadconfig'),
(560, 'Can change video upload config', 186, 'change_videouploadconfig'),
(561, 'Can delete video upload config', 186, 'delete_videouploadconfig'),
(562, 'Can add push notification config', 187, 'add_pushnotificationconfig'),
(563, 'Can change push notification config', 187, 'change_pushnotificationconfig'),
(564, 'Can delete push notification config', 187, 'delete_pushnotificationconfig'),
(565, 'Can add course creator', 188, 'add_coursecreator'),
(566, 'Can change course creator', 188, 'change_coursecreator'),
(567, 'Can delete course creator', 188, 'delete_coursecreator'),
(568, 'Can add studio config', 189, 'add_studioconfig'),
(569, 'Can change studio config', 189, 'change_studioconfig'),
(570, 'Can delete studio config', 189, 'delete_studioconfig');

-- --------------------------------------------------------

--
-- Структура таблицы `auth_registration`
--

CREATE TABLE `auth_registration` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `activation_key` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `auth_registration`
--

INSERT INTO `auth_registration` (`id`, `user_id`, `activation_key`) VALUES
(1, 1, '3795be3f0fc7404285c77206486d2679'),
(2, 2, '453521887a2747319237aa8f4dc4894e'),
(3, 3, '28d575880aef4dc69fd8023aaf622f42'),
(4, 4, '3e5aeb263cbc43809f47e05976874503'),
(5, 5, '50792c6d57904cfd8ed7e0b72bc38bfe'),
(6, 6, 'b7f3e7bea0e9426d8f16f0b6920af4b7');

-- --------------------------------------------------------

--
-- Структура таблицы `auth_user`
--

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
(6, 'test', '', '', 'twst@wad.rfth', 'pbkdf2_sha256$10000$4MnKUWgBc3AA$dltTjhgmR0l6BML9eh+LUv+1VLlEzki1vmFteI4UeIU=', 0, 0, 0, '2016-05-02 18:50:47', '2016-05-02 18:50:45');

-- --------------------------------------------------------

--
-- Структура таблицы `auth_userprofile`
--

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
  `angle` int(3) NOT NULL DEFAULT '0' COMMENT 'Угол поворота изображения'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `auth_userprofile`
--

INSERT INTO `auth_userprofile` (`id`, `user_id`, `name`, `language`, `location`, `meta`, `courseware`, `gender`, `mailing_address`, `year_of_birth`, `level_of_education`, `goals`, `allow_certificate`, `country`, `city`, `bio`, `profile_image_uploaded_at`, `profile_image`, `crop`, `angle`) VALUES
(1, 1, 'honor', '', '', '', 'course.xml', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2, 2, 'audit', '', '', '', 'course.xml', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(3, 3, 'verified', '', '', '', 'course.xml', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(4, 4, 'staff', '', '', '{"session_id": "43f29137f3c125c4e9eaa27158e9dc53"}', 'course.xml', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(5, 5, 'Петров Дмитрий Владимирович', 'RU', '', '{"session_id": "93bb956a85d1036e4f9549962cc36776"}', 'course.xml', 'm', 'Индустриальный Проспект, Дом 23, Квартира 184', 1997, 'hs', 'Я АДМЕН!!!!!!111!1!1!1!', 1, 'RU', '', NULL, NULL, 'IMG_0077.JPG', '0 62 175 237 175 175', 270),
(6, 6, 'Дмитрий Петров', '', '', '{"session_id": null}', 'course.xml', 'm', '', 1997, '', 'фуакыпк', 1, '', '', NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `branding_brandingapiconfig`
--

CREATE TABLE `branding_brandingapiconfig` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `branding_brandinginfoconfig`
--

CREATE TABLE `branding_brandinginfoconfig` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `configuration` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `bulk_email_courseauthorization`
--

CREATE TABLE `bulk_email_courseauthorization` (
  `id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `email_enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `bulk_email_courseemail`
--

CREATE TABLE `bulk_email_courseemail` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) DEFAULT NULL,
  `slug` varchar(128) NOT NULL,
  `subject` varchar(128) NOT NULL,
  `html_message` longtext,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `to_option` varchar(64) NOT NULL,
  `text_message` longtext,
  `template_name` varchar(255) DEFAULT NULL,
  `from_addr` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `bulk_email_courseemailtemplate`
--

CREATE TABLE `bulk_email_courseemailtemplate` (
  `id` int(11) NOT NULL,
  `html_template` longtext,
  `plain_template` longtext,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `bulk_email_optout`
--

CREATE TABLE `bulk_email_optout` (
  `id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `celery_taskmeta`
--

CREATE TABLE `celery_taskmeta` (
  `id` int(11) NOT NULL,
  `task_id` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `result` longtext,
  `date_done` datetime NOT NULL,
  `traceback` longtext,
  `hidden` tinyint(1) NOT NULL,
  `meta` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `celery_tasksetmeta`
--

CREATE TABLE `celery_tasksetmeta` (
  `id` int(11) NOT NULL,
  `taskset_id` varchar(255) NOT NULL,
  `result` longtext NOT NULL,
  `date_done` datetime NOT NULL,
  `hidden` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `certificates_badgeassertion`
--

CREATE TABLE `certificates_badgeassertion` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `mode` varchar(100) NOT NULL,
  `data` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `certificates_badgeimageconfiguration`
--

CREATE TABLE `certificates_badgeimageconfiguration` (
  `id` int(11) NOT NULL,
  `mode` varchar(125) NOT NULL,
  `icon` varchar(100) NOT NULL,
  `default` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `certificates_badgeimageconfiguration`
--

INSERT INTO `certificates_badgeimageconfiguration` (`id`, `mode`, `icon`, `default`) VALUES
(1, 'honor', './honor.png', 0),
(2, 'verified', './verified.png', 0),
(3, 'professional', './professional.png', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `certificates_certificategenerationconfiguration`
--

CREATE TABLE `certificates_certificategenerationconfiguration` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `certificates_certificategenerationcoursesetting`
--

CREATE TABLE `certificates_certificategenerationcoursesetting` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `course_key` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `certificates_certificatehtmlviewconfiguration`
--

CREATE TABLE `certificates_certificatehtmlviewconfiguration` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `configuration` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `certificates_certificatehtmlviewconfiguration`
--

INSERT INTO `certificates_certificatehtmlviewconfiguration` (`id`, `change_date`, `changed_by_id`, `enabled`, `configuration`) VALUES
(1, '2015-08-07 16:32:44', NULL, 0, '{"default": {"accomplishment_class_append": "accomplishment-certificate", "platform_name": "Your Platform Name Here", "logo_src": "/static/certificates/images/logo.png", "logo_url": "http://www.example.com", "company_verified_certificate_url": "http://www.example.com/verified-certificate", "company_privacy_url": "http://www.example.com/privacy-policy", "company_tos_url": "http://www.example.com/terms-service", "company_about_url": "http://www.example.com/about-us"}, "base": {"certificate_type": "base", "certificate_title": "Certificate of Achievement", "document_body_class_append": "is-base"}, "distinguished": {"certificate_type": "distinguished", "certificate_title": "Distinguished Certificate of Achievement", "document_body_class_append": "is-distinguished"}}');

-- --------------------------------------------------------

--
-- Структура таблицы `certificates_certificatewhitelist`
--

CREATE TABLE `certificates_certificatewhitelist` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `whitelist` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `certificates_certificatewhitelist`
--

INSERT INTO `certificates_certificatewhitelist` (`id`, `user_id`, `course_id`, `whitelist`) VALUES
(1, 1, 'edX/DemoX/Demo_Course', 1),
(2, 2, 'edX/DemoX/Demo_Course', 1),
(3, 3, 'edX/DemoX/Demo_Course', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `certificates_examplecertificate`
--

CREATE TABLE `certificates_examplecertificate` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `example_cert_set_id` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `access_key` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `template` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `error_reason` longtext,
  `download_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `certificates_examplecertificateset`
--

CREATE TABLE `certificates_examplecertificateset` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `course_key` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `certificates_generatedcertificate`
--

CREATE TABLE `certificates_generatedcertificate` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `download_url` varchar(128) NOT NULL,
  `grade` varchar(5) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `key` varchar(32) NOT NULL,
  `distinction` tinyint(1) NOT NULL,
  `status` varchar(32) NOT NULL,
  `verify_uuid` varchar(32) NOT NULL,
  `download_uuid` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `error_reason` varchar(512) NOT NULL,
  `mode` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `circuit_servercircuit`
--

CREATE TABLE `circuit_servercircuit` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `schematic` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `contentstore_pushnotificationconfig`
--

CREATE TABLE `contentstore_pushnotificationconfig` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `contentstore_videouploadconfig`
--

CREATE TABLE `contentstore_videouploadconfig` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `profile_whitelist` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `contentstore_videouploadconfig`
--

INSERT INTO `contentstore_videouploadconfig` (`id`, `change_date`, `changed_by_id`, `enabled`, `profile_whitelist`) VALUES
(1, '2015-08-07 16:33:22', NULL, 0, 'desktop_mp4,desktop_webm,mobile_low,youtube');

-- --------------------------------------------------------

--
-- Структура таблицы `corsheaders_corsmodel`
--

CREATE TABLE `corsheaders_corsmodel` (
  `id` int(11) NOT NULL,
  `cors` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `cors_csrf_xdomainproxyconfiguration`
--

CREATE TABLE `cors_csrf_xdomainproxyconfiguration` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `whitelist` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `courseware_offlinecomputedgrade`
--

CREATE TABLE `courseware_offlinecomputedgrade` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime NOT NULL,
  `gradeset` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `courseware_offlinecomputedgradelog`
--

CREATE TABLE `courseware_offlinecomputedgradelog` (
  `id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `created` datetime DEFAULT NULL,
  `seconds` int(11) NOT NULL,
  `nstudents` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `courseware_studentfieldoverride`
--

CREATE TABLE `courseware_studentfieldoverride` (
  `id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `student_id` int(11) NOT NULL,
  `field` varchar(255) NOT NULL,
  `value` longtext NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `courseware_studentmodule`
--

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
(39, 'sequential', 'block-v1:edX+DemoX+Demo_Course+type@sequential+block@edx_introduction', 4, '{"position": 1}', NULL, '2016-04-18 14:23:02', '2016-04-18 14:23:02', NULL, 'na', 'course-v1:edX+DemoX+Demo_Course');

-- --------------------------------------------------------

--
-- Структура таблицы `courseware_studentmodulehistory`
--

CREATE TABLE `courseware_studentmodulehistory` (
  `id` int(11) NOT NULL,
  `student_module_id` int(11) NOT NULL,
  `version` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  `state` longtext,
  `grade` double DEFAULT NULL,
  `max_grade` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `courseware_studentmodulehistory`
--

INSERT INTO `courseware_studentmodulehistory` (`id`, `student_module_id`, `version`, `created`, `state`, `grade`, `max_grade`) VALUES
(1, 5, NULL, '2015-10-21 11:17:40', '{"seed": 1, "input_state": {"c554538a57664fac80783b99d9d6da7c_2_1": {}}}', NULL, NULL),
(2, 6, NULL, '2015-10-21 11:17:40', '{"seed": 1, "input_state": {"d2e35c1d294b4ba0b3b1048615605d2a_2_1": {}}}', NULL, NULL),
(3, 7, NULL, '2015-10-21 11:17:40', '{"seed": 1, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}}', NULL, NULL),
(4, 8, NULL, '2015-10-21 11:17:41', '{"seed": 1, "input_state": {"Sample_Algebraic_Problem_2_1": {}}}', NULL, NULL),
(5, 9, NULL, '2015-10-21 11:17:41', '{"seed": 1, "input_state": {"Sample_ChemFormula_Problem_2_1": {}}}', NULL, NULL),
(6, 10, NULL, '2015-10-21 11:17:41', '{"seed": 1, "input_state": {"75f9562c77bc4858b61f907bb810d974_2_1": {}, "75f9562c77bc4858b61f907bb810d974_3_1": {}, "75f9562c77bc4858b61f907bb810d974_4_1": {}}}', NULL, NULL),
(7, 11, NULL, '2015-10-21 11:17:41', '{"seed": 1, "input_state": {"0d759dee4f9d459c8956136dbde55f02_2_1": {}}}', NULL, NULL),
(8, 7, NULL, '2015-10-21 11:17:57', '{"seed": 1, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}}', 2, 3),
(9, 7, NULL, '2015-10-21 11:17:57', '{"attempts": 1, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}, "correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:17:57Z"}', 2, 3),
(10, 7, NULL, '2015-10-21 11:18:00', '{"attempts": 1, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}, "correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:17:57Z"}', 2, 3),
(11, 7, NULL, '2015-10-21 11:18:00', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:00Z", "attempts": 2, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_0"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(12, 7, NULL, '2015-10-21 11:18:02', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:00Z", "attempts": 2, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_0"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(13, 7, NULL, '2015-10-21 11:18:02', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:02Z", "attempts": 3, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_0", "choice_1"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(14, 7, NULL, '2015-10-21 11:18:03', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:02Z", "attempts": 3, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_0", "choice_1"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(15, 7, NULL, '2015-10-21 11:18:03', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:03Z", "attempts": 4, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_0", "choice_1", "choice_2"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(16, 7, NULL, '2015-10-21 11:18:04', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:03Z", "attempts": 4, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_0", "choice_1", "choice_2"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(17, 7, NULL, '2015-10-21 11:18:04', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:04Z", "attempts": 5, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_0", "choice_1", "choice_2", "choice_3"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(18, 7, NULL, '2015-10-21 11:18:06', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:04Z", "attempts": 5, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_0", "choice_1", "choice_2", "choice_3"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(19, 7, NULL, '2015-10-21 11:18:06', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:06Z", "attempts": 6, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_1", "choice_2", "choice_3"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(20, 7, NULL, '2015-10-21 11:18:12', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:06Z", "attempts": 6, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_1", "choice_2", "choice_3"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(21, 7, NULL, '2015-10-21 11:18:12', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:12Z", "attempts": 7, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_2", "choice_3"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(22, 7, NULL, '2015-10-21 11:18:14', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:12Z", "attempts": 7, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_2", "choice_3"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(23, 7, NULL, '2015-10-21 11:18:14', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:14Z", "attempts": 8, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_2"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(24, 7, NULL, '2015-10-21 11:18:16', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:14Z", "attempts": 8, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_2"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(25, 7, NULL, '2015-10-21 11:18:16', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:16Z", "attempts": 9, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(26, 7, NULL, '2015-10-21 11:18:16', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:16Z", "attempts": 9, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(27, 7, NULL, '2015-10-21 11:18:17', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:16Z", "attempts": 10, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(28, 7, NULL, '2015-10-21 11:18:19', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:16Z", "attempts": 10, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(29, 7, NULL, '2015-10-21 11:18:19', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:19Z", "attempts": 11, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_0"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(30, 7, NULL, '2015-10-21 11:18:20', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:19Z", "attempts": 11, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_0"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(31, 7, NULL, '2015-10-21 11:18:20', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:20Z", "attempts": 12, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_0", "choice_1"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 2, 3),
(32, 7, NULL, '2015-10-21 11:18:22', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:20Z", "attempts": 12, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_0", "choice_1"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 3, 3),
(33, 7, NULL, '2015-10-21 11:18:22', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:22Z", "attempts": 13, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_0", "choice_2"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 3, 3),
(34, 7, NULL, '2015-10-21 11:18:23', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:22Z", "attempts": 13, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_0", "choice_2"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 3, 3),
(35, 7, NULL, '2015-10-21 11:18:23', '{"correct_map": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {"hint": "", "hintmode": null, "correctness": "correct", "npoints": null, "answervariable": null, "msg": "", "queuestate": null}}, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}, "last_submission_time": "2015-10-21T11:18:23Z", "attempts": 14, "seed": 1, "done": true, "student_answers": {"a0effb954cca4759994f1ac9e9434bf4_4_1": ["choice_0", "choice_2"], "a0effb954cca4759994f1ac9e9434bf4_2_1": "blue", "a0effb954cca4759994f1ac9e9434bf4_3_1": "choice_2"}}', 3, 3),
(36, 8, NULL, '2015-10-21 11:19:50', '{"seed": 1, "input_state": {"Sample_Algebraic_Problem_2_1": {}}}', 0, 1),
(37, 8, NULL, '2015-10-21 11:19:50', '{"attempts": 1, "seed": 1, "done": true, "student_answers": {"Sample_Algebraic_Problem_2_1": "", "Sample_Algebraic_Problem_2_1_dynamath": "<math xmlns=\\"http://www.w3.org/1998/Math/MathML\\">\\r\\n<mstyle displaystyle=\\"true\\">\\r\\n  <mo></mo>\\r\\n</mstyle>\\r\\n</math>"}, "correct_map": {"Sample_Algebraic_Problem_2_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"Sample_Algebraic_Problem_2_1": {}}, "last_submission_time": "2015-10-21T11:19:50Z"}', 0, 1),
(38, 8, NULL, '2015-10-21 11:19:57', '{"attempts": 1, "seed": 1, "done": true, "student_answers": {"Sample_Algebraic_Problem_2_1": "", "Sample_Algebraic_Problem_2_1_dynamath": "<math xmlns=\\"http://www.w3.org/1998/Math/MathML\\">\\r\\n<mstyle displaystyle=\\"true\\">\\r\\n  <mo></mo>\\r\\n</mstyle>\\r\\n</math>"}, "correct_map": {"Sample_Algebraic_Problem_2_1": {"hint": "", "hintmode": null, "correctness": "incorrect", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"Sample_Algebraic_Problem_2_1": {}}, "last_submission_time": "2015-10-21T11:19:50Z"}', 1, 1),
(39, 8, NULL, '2015-10-21 11:19:57', '{"correct_map": {"Sample_Algebraic_Problem_2_1": {"hint": "", "hintmode": null, "correctness": "correct", "msg": "", "answervariable": null, "npoints": null, "queuestate": null}}, "input_state": {"Sample_Algebraic_Problem_2_1": {}}, "last_submission_time": "2015-10-21T11:19:57Z", "attempts": 2, "seed": 1, "done": true, "student_answers": {"Sample_Algebraic_Problem_2_1": "A*x^2 + sqrt(y)", "Sample_Algebraic_Problem_2_1_dynamath": "<math xmlns=\\"http://www.w3.org/1998/Math/MathML\\">\\r\\n<mstyle displaystyle=\\"true\\">\\r\\n  <mi>A</mi>\\r\\n  <mo>&#x22C5;</mo>\\r\\n  <msup>\\r\\n    <mi>x</mi>\\r\\n    <mn>2</mn>\\r\\n  </msup>\\r\\n  <mo>+</mo>\\r\\n  <msqrt>\\r\\n    <mrow>\\r\\n      <mi>y</mi>\\r\\n    </mrow>\\r\\n  </msqrt>\\r\\n</mstyle>\\r\\n</math>"}}', 1, 1),
(40, 16, NULL, '2016-04-18 14:22:49', '{"seed": 1, "input_state": {"303034da25524878a2e66fb57c91cf85_2_1": {}}}', NULL, NULL),
(41, 17, NULL, '2016-04-18 14:22:49', '{"seed": 1, "input_state": {"932e6f2ce8274072a355a94560216d1a_2_1": {}}}', NULL, NULL),
(42, 18, NULL, '2016-04-18 14:22:49', '{"seed": 1, "input_state": {"9cee77a606ea4c1aa5440e0ea5d0f618_2_1": {}}}', NULL, NULL),
(43, 19, NULL, '2016-04-18 14:22:49', '{"seed": 1, "input_state": {"0d759dee4f9d459c8956136dbde55f02_2_1": {}}}', NULL, NULL),
(44, 20, NULL, '2016-04-18 14:22:50', '{"seed": 1, "input_state": {"75f9562c77bc4858b61f907bb810d974_2_1": {}, "75f9562c77bc4858b61f907bb810d974_3_1": {}, "75f9562c77bc4858b61f907bb810d974_4_1": {}}}', NULL, NULL),
(45, 21, NULL, '2016-04-18 14:22:50', '{"seed": 1, "input_state": {"Sample_ChemFormula_Problem_2_1": {}}}', NULL, NULL),
(46, 22, NULL, '2016-04-18 14:22:50', '{"seed": 1, "input_state": {"Sample_Algebraic_Problem_2_1": {}}}', NULL, NULL),
(47, 23, NULL, '2016-04-18 14:22:50', '{"seed": 1, "input_state": {"a0effb954cca4759994f1ac9e9434bf4_4_1": {}, "a0effb954cca4759994f1ac9e9434bf4_2_1": {}, "a0effb954cca4759994f1ac9e9434bf4_3_1": {}}}', NULL, NULL),
(48, 24, NULL, '2016-04-18 14:22:50', '{"seed": 1, "input_state": {"d2e35c1d294b4ba0b3b1048615605d2a_2_1": {}}}', NULL, NULL),
(49, 25, NULL, '2016-04-18 14:22:50', '{"seed": 1, "input_state": {"c554538a57664fac80783b99d9d6da7c_2_1": {}}}', NULL, NULL),
(50, 26, NULL, '2016-04-18 14:22:50', '{"seed": 1, "input_state": {"700x_proteinmake_2_1": {}}}', NULL, NULL),
(51, 27, NULL, '2016-04-18 14:22:50', '{"seed": 1, "input_state": {"logic_gate_problem_2_1": {}}}', NULL, NULL),
(52, 28, NULL, '2016-04-18 14:22:50', '{"seed": 1, "input_state": {"free_form_simulation_2_1": {}}}', NULL, NULL),
(53, 29, NULL, '2016-04-18 14:22:50', '{"seed": 1, "input_state": {"python_grader_2_1": {}}}', NULL, NULL),
(54, 30, NULL, '2016-04-18 14:22:50', '{"seed": 1, "input_state": {"700x_editmolB_2_1": {}}}', NULL, NULL),
(55, 31, NULL, '2016-04-18 14:22:51', '{"seed": 365, "input_state": {"ex_practice_3_2_1": {}}}', NULL, NULL),
(56, 32, NULL, '2016-04-18 14:22:51', '{"seed": 1, "input_state": {"d1b84dcd39b0423d9e288f27f0f7f242_2_1": {}}}', NULL, NULL),
(57, 33, NULL, '2016-04-18 14:22:51', '{"seed": 1, "input_state": {"ex_practice_limited_checks_2_1": {}}}', NULL, NULL),
(58, 34, NULL, '2016-04-18 14:22:51', '{"seed": 1, "input_state": {"651e0945b77f42e0a4c89b8c3e6f5b3b_2_1": {}}}', NULL, NULL),
(59, 35, NULL, '2016-04-18 14:22:51', '{"seed": 1, "input_state": {"45d46192272c4f6db6b63586520bbdf4_2_1": {}}}', NULL, NULL),
(60, 36, NULL, '2016-04-18 14:22:51', '{"seed": 1, "input_state": {"ex_practice_2_2_1": {}}}', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `courseware_xmodulestudentinfofield`
--

CREATE TABLE `courseware_xmodulestudentinfofield` (
  `id` int(11) NOT NULL,
  `field_name` varchar(64) NOT NULL,
  `value` longtext NOT NULL,
  `student_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `courseware_xmodulestudentinfofield`
--

INSERT INTO `courseware_xmodulestudentinfofield` (`id`, `field_name`, `value`, `student_id`, `created`, `modified`) VALUES
(1, 'youtube_is_available', 'true', 5, '2015-10-21 11:16:50', '2015-10-21 11:16:50');

-- --------------------------------------------------------

--
-- Структура таблицы `courseware_xmodulestudentprefsfield`
--

CREATE TABLE `courseware_xmodulestudentprefsfield` (
  `id` int(11) NOT NULL,
  `field_name` varchar(64) NOT NULL,
  `module_type` varchar(64) NOT NULL,
  `value` longtext NOT NULL,
  `student_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `courseware_xmoduleuserstatesummaryfield`
--

CREATE TABLE `courseware_xmoduleuserstatesummaryfield` (
  `id` int(11) NOT NULL,
  `field_name` varchar(64) NOT NULL,
  `usage_id` varchar(255) NOT NULL,
  `value` longtext NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `course_action_state_coursererunstate`
--

CREATE TABLE `course_action_state_coursererunstate` (
  `id` int(11) NOT NULL,
  `created_time` datetime NOT NULL,
  `updated_time` datetime NOT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  `course_key` varchar(255) NOT NULL,
  `action` varchar(100) NOT NULL,
  `state` varchar(50) NOT NULL,
  `should_display` tinyint(1) NOT NULL,
  `message` varchar(1000) NOT NULL,
  `source_course_key` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `course_creators_coursecreator`
--

CREATE TABLE `course_creators_coursecreator` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `state_changed` datetime NOT NULL,
  `state` varchar(24) NOT NULL,
  `note` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `course_groups_coursecohort`
--

CREATE TABLE `course_groups_coursecohort` (
  `id` int(11) NOT NULL,
  `course_user_group_id` int(11) NOT NULL,
  `assignment_type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `course_groups_coursecohortssettings`
--

CREATE TABLE `course_groups_coursecohortssettings` (
  `id` int(11) NOT NULL,
  `is_cohorted` tinyint(1) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `cohorted_discussions` longtext,
  `always_cohort_inline_discussions` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `course_groups_coursecohortssettings`
--

INSERT INTO `course_groups_coursecohortssettings` (`id`, `is_cohorted`, `course_id`, `cohorted_discussions`, `always_cohort_inline_discussions`) VALUES
(1, 0, 'course-v1:edX+DemoX+Demo_Course', '[]', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `course_groups_courseusergroup`
--

CREATE TABLE `course_groups_courseusergroup` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `group_type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `course_groups_courseusergrouppartitiongroup`
--

CREATE TABLE `course_groups_courseusergrouppartitiongroup` (
  `id` int(11) NOT NULL,
  `course_user_group_id` int(11) NOT NULL,
  `partition_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `course_groups_courseusergroup_users`
--

CREATE TABLE `course_groups_courseusergroup_users` (
  `id` int(11) NOT NULL,
  `courseusergroup_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `course_modes_coursemode`
--

CREATE TABLE `course_modes_coursemode` (
  `id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `mode_slug` varchar(100) NOT NULL,
  `mode_display_name` varchar(255) NOT NULL,
  `min_price` int(11) NOT NULL,
  `suggested_prices` varchar(255) NOT NULL,
  `currency` varchar(8) NOT NULL,
  `expiration_date` date DEFAULT NULL,
  `expiration_datetime` datetime DEFAULT NULL,
  `description` longtext,
  `sku` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `course_modes_coursemodesarchive`
--

CREATE TABLE `course_modes_coursemodesarchive` (
  `id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `mode_slug` varchar(100) NOT NULL,
  `mode_display_name` varchar(255) NOT NULL,
  `min_price` int(11) NOT NULL,
  `suggested_prices` varchar(255) NOT NULL,
  `currency` varchar(8) NOT NULL,
  `expiration_date` date DEFAULT NULL,
  `expiration_datetime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `course_overviews_courseoverview`
--

CREATE TABLE `course_overviews_courseoverview` (
  `id` varchar(255) NOT NULL,
  `_location` varchar(255) NOT NULL,
  `display_name` longtext,
  `display_number_with_default` longtext NOT NULL,
  `display_org_with_default` longtext NOT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `advertised_start` longtext,
  `course_image_url` longtext NOT NULL,
  `facebook_url` longtext,
  `social_sharing_url` longtext,
  `end_of_course_survey_url` longtext,
  `certificates_display_behavior` longtext,
  `certificates_show_before_end` tinyint(1) NOT NULL,
  `has_any_active_web_certificate` tinyint(1) NOT NULL,
  `cert_name_short` longtext NOT NULL,
  `cert_name_long` longtext NOT NULL,
  `lowest_passing_grade` decimal(5,2) NOT NULL,
  `mobile_available` tinyint(1) NOT NULL,
  `visible_to_staff_only` tinyint(1) NOT NULL,
  `_pre_requisite_courses_json` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `course_structures_coursestructure`
--

CREATE TABLE `course_structures_coursestructure` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `structure_json` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `course_structures_coursestructure`
--

INSERT INTO `course_structures_coursestructure` (`id`, `created`, `modified`, `course_id`, `structure_json`) VALUES
(1, '2016-04-18 14:24:22', '2016-04-18 14:25:21', 'course-v1:ITMO+1+today', 'H4sIAFHuFFcC/8VUTWvDMAz9K8XXdGA3Tmz31OsOY4ftNkaRbbkLTZMucQah9L/PaQtlW78yAr1Z\nsvX09CR5Q3RemmVNpqPN/vjwxaaPr0/PEYt8aaGNfLvGmfmAtccq2j2ZcaEkjVmsE805TBIlER23\nkoKhkDJ2RJt30cEkBwAyHpFFBRZtcDrIawwOV1Yr8MFRNHke7KaGBc6X2HaBw5Eadyyy3FZYBOC3\nS8g1fjZY+AzyAzik1lKZxlwgcstRW5oYZ0CgdE7ymLwHdJvV6xzaeQGrXc0ea8/IdnyxiP6p/op7\nxBhU3/7Ufkl8TpTJNVF+dlZTtFYLJgxNuJBGS8acUYrHTqfI4C7jdpXUDVq8oPFZWfRTwyZcThRK\n4A45ZVJro2wYeZEqFtpzn+W7SmpANcqmqvGQd2+cKnl/MWjFJxL3+FP6/1aDzuJwrTy31WTbda4q\nS/8PIbffNlA1jooGAAA=\n');

-- --------------------------------------------------------

--
-- Структура таблицы `credit_creditcourse`
--

CREATE TABLE `credit_creditcourse` (
  `id` int(11) NOT NULL,
  `course_key` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `credit_crediteligibility`
--

CREATE TABLE `credit_crediteligibility` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `username` varchar(255) NOT NULL,
  `course_id` int(11) NOT NULL,
  `deadline` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `credit_creditprovider`
--

CREATE TABLE `credit_creditprovider` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `provider_id` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `provider_url` varchar(200) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `enable_integration` tinyint(1) NOT NULL,
  `provider_status_url` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `credit_creditrequest`
--

CREATE TABLE `credit_creditrequest` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `uuid` varchar(32) NOT NULL,
  `username` varchar(255) NOT NULL,
  `course_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `parameters` longtext NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `credit_creditrequirement`
--

CREATE TABLE `credit_creditrequirement` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `course_id` int(11) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `criteria` longtext NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `order` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `credit_creditrequirementstatus`
--

CREATE TABLE `credit_creditrequirementstatus` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `username` varchar(255) NOT NULL,
  `requirement_id` int(11) NOT NULL,
  `status` varchar(32) NOT NULL,
  `reason` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `credit_historicalcreditrequest`
--

CREATE TABLE `credit_historicalcreditrequest` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `uuid` varchar(32) NOT NULL,
  `username` varchar(255) NOT NULL,
  `parameters` longtext NOT NULL,
  `status` varchar(255) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `provider_id` int(11) DEFAULT NULL,
  `history_id` int(11) NOT NULL,
  `history_date` datetime NOT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `credit_historicalcreditrequirementstatus`
--

CREATE TABLE `credit_historicalcreditrequirementstatus` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `username` varchar(255) NOT NULL,
  `status` varchar(32) NOT NULL,
  `reason` longtext NOT NULL,
  `requirement_id` int(11) DEFAULT NULL,
  `history_id` int(11) NOT NULL,
  `history_date` datetime NOT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `dark_lang_darklangconfig`
--

CREATE TABLE `dark_lang_darklangconfig` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `released_languages` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `dark_lang_darklangconfig`
--

INSERT INTO `dark_lang_darklangconfig` (`id`, `change_date`, `changed_by_id`, `enabled`, `released_languages`) VALUES
(1, '2015-08-07 16:33:04', NULL, 1, '');

-- --------------------------------------------------------

--
-- Структура таблицы `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `django_comment_client_permission`
--

CREATE TABLE `django_comment_client_permission` (
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `django_comment_client_permission`
--

INSERT INTO `django_comment_client_permission` (`name`) VALUES
('create_comment'),
('create_sub_comment'),
('create_thread'),
('delete_comment'),
('delete_thread'),
('edit_content'),
('endorse_comment'),
('follow_commentable'),
('follow_thread'),
('manage_moderator'),
('openclose_thread'),
('see_all_cohorts'),
('unfollow_commentable'),
('unfollow_thread'),
('unvote'),
('update_comment'),
('update_thread'),
('vote');

-- --------------------------------------------------------

--
-- Структура таблицы `django_comment_client_permission_roles`
--

CREATE TABLE `django_comment_client_permission_roles` (
  `id` int(11) NOT NULL,
  `permission_id` varchar(30) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `django_comment_client_permission_roles`
--

INSERT INTO `django_comment_client_permission_roles` (`id`, `permission_id`, `role_id`) VALUES
(47, 'create_comment', 1),
(29, 'create_comment', 2),
(30, 'create_comment', 3),
(11, 'create_comment', 4),
(74, 'create_comment', 5),
(110, 'create_comment', 6),
(92, 'create_comment', 7),
(93, 'create_comment', 8),
(173, 'create_comment', 9),
(155, 'create_comment', 10),
(156, 'create_comment', 11),
(137, 'create_comment', 12),
(48, 'create_sub_comment', 1),
(24, 'create_sub_comment', 2),
(31, 'create_sub_comment', 3),
(6, 'create_sub_comment', 4),
(69, 'create_sub_comment', 5),
(111, 'create_sub_comment', 6),
(87, 'create_sub_comment', 7),
(94, 'create_sub_comment', 8),
(174, 'create_sub_comment', 9),
(150, 'create_sub_comment', 10),
(157, 'create_sub_comment', 11),
(132, 'create_sub_comment', 12),
(49, 'create_thread', 1),
(26, 'create_thread', 2),
(32, 'create_thread', 3),
(8, 'create_thread', 4),
(71, 'create_thread', 5),
(112, 'create_thread', 6),
(89, 'create_thread', 7),
(95, 'create_thread', 8),
(175, 'create_thread', 9),
(152, 'create_thread', 10),
(158, 'create_thread', 11),
(134, 'create_thread', 12),
(50, 'delete_comment', 1),
(16, 'delete_comment', 2),
(33, 'delete_comment', 3),
(113, 'delete_comment', 6),
(79, 'delete_comment', 7),
(96, 'delete_comment', 8),
(176, 'delete_comment', 9),
(142, 'delete_comment', 10),
(159, 'delete_comment', 11),
(51, 'delete_thread', 1),
(13, 'delete_thread', 2),
(34, 'delete_thread', 3),
(114, 'delete_thread', 6),
(76, 'delete_thread', 7),
(97, 'delete_thread', 8),
(177, 'delete_thread', 9),
(139, 'delete_thread', 10),
(160, 'delete_thread', 11),
(52, 'edit_content', 1),
(12, 'edit_content', 2),
(35, 'edit_content', 3),
(115, 'edit_content', 6),
(75, 'edit_content', 7),
(98, 'edit_content', 8),
(178, 'edit_content', 9),
(138, 'edit_content', 10),
(161, 'edit_content', 11),
(53, 'endorse_comment', 1),
(15, 'endorse_comment', 2),
(36, 'endorse_comment', 3),
(116, 'endorse_comment', 6),
(78, 'endorse_comment', 7),
(99, 'endorse_comment', 8),
(179, 'endorse_comment', 9),
(141, 'endorse_comment', 10),
(162, 'endorse_comment', 11),
(54, 'follow_commentable', 1),
(27, 'follow_commentable', 2),
(37, 'follow_commentable', 3),
(9, 'follow_commentable', 4),
(72, 'follow_commentable', 5),
(117, 'follow_commentable', 6),
(90, 'follow_commentable', 7),
(100, 'follow_commentable', 8),
(180, 'follow_commentable', 9),
(153, 'follow_commentable', 10),
(163, 'follow_commentable', 11),
(135, 'follow_commentable', 12),
(55, 'follow_thread', 1),
(21, 'follow_thread', 2),
(38, 'follow_thread', 3),
(3, 'follow_thread', 4),
(66, 'follow_thread', 5),
(118, 'follow_thread', 6),
(84, 'follow_thread', 7),
(101, 'follow_thread', 8),
(181, 'follow_thread', 9),
(147, 'follow_thread', 10),
(164, 'follow_thread', 11),
(129, 'follow_thread', 12),
(18, 'manage_moderator', 1),
(81, 'manage_moderator', 6),
(144, 'manage_moderator', 9),
(56, 'openclose_thread', 1),
(14, 'openclose_thread', 2),
(39, 'openclose_thread', 3),
(119, 'openclose_thread', 6),
(77, 'openclose_thread', 7),
(102, 'openclose_thread', 8),
(182, 'openclose_thread', 9),
(140, 'openclose_thread', 10),
(165, 'openclose_thread', 11),
(57, 'see_all_cohorts', 1),
(17, 'see_all_cohorts', 2),
(40, 'see_all_cohorts', 3),
(120, 'see_all_cohorts', 6),
(80, 'see_all_cohorts', 7),
(103, 'see_all_cohorts', 8),
(183, 'see_all_cohorts', 9),
(143, 'see_all_cohorts', 10),
(166, 'see_all_cohorts', 11),
(58, 'unfollow_commentable', 1),
(28, 'unfollow_commentable', 2),
(41, 'unfollow_commentable', 3),
(10, 'unfollow_commentable', 4),
(73, 'unfollow_commentable', 5),
(121, 'unfollow_commentable', 6),
(91, 'unfollow_commentable', 7),
(104, 'unfollow_commentable', 8),
(184, 'unfollow_commentable', 9),
(154, 'unfollow_commentable', 10),
(167, 'unfollow_commentable', 11),
(136, 'unfollow_commentable', 12),
(59, 'unfollow_thread', 1),
(22, 'unfollow_thread', 2),
(42, 'unfollow_thread', 3),
(4, 'unfollow_thread', 4),
(67, 'unfollow_thread', 5),
(122, 'unfollow_thread', 6),
(85, 'unfollow_thread', 7),
(105, 'unfollow_thread', 8),
(185, 'unfollow_thread', 9),
(148, 'unfollow_thread', 10),
(168, 'unfollow_thread', 11),
(130, 'unfollow_thread', 12),
(60, 'unvote', 1),
(25, 'unvote', 2),
(43, 'unvote', 3),
(7, 'unvote', 4),
(70, 'unvote', 5),
(123, 'unvote', 6),
(88, 'unvote', 7),
(106, 'unvote', 8),
(186, 'unvote', 9),
(151, 'unvote', 10),
(169, 'unvote', 11),
(133, 'unvote', 12),
(61, 'update_comment', 1),
(23, 'update_comment', 2),
(44, 'update_comment', 3),
(5, 'update_comment', 4),
(68, 'update_comment', 5),
(124, 'update_comment', 6),
(86, 'update_comment', 7),
(107, 'update_comment', 8),
(187, 'update_comment', 9),
(149, 'update_comment', 10),
(170, 'update_comment', 11),
(131, 'update_comment', 12),
(62, 'update_thread', 1),
(20, 'update_thread', 2),
(45, 'update_thread', 3),
(2, 'update_thread', 4),
(65, 'update_thread', 5),
(125, 'update_thread', 6),
(83, 'update_thread', 7),
(108, 'update_thread', 8),
(188, 'update_thread', 9),
(146, 'update_thread', 10),
(171, 'update_thread', 11),
(128, 'update_thread', 12),
(63, 'vote', 1),
(19, 'vote', 2),
(46, 'vote', 3),
(1, 'vote', 4),
(64, 'vote', 5),
(126, 'vote', 6),
(82, 'vote', 7),
(109, 'vote', 8),
(189, 'vote', 9),
(145, 'vote', 10),
(172, 'vote', 11),
(127, 'vote', 12);

-- --------------------------------------------------------

--
-- Структура таблицы `django_comment_client_role`
--

CREATE TABLE `django_comment_client_role` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `course_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `django_comment_client_role`
--

INSERT INTO `django_comment_client_role` (`id`, `name`, `course_id`) VALUES
(1, 'Administrator', 'course-v1:edX+DemoX+Demo_Course'),
(2, 'Moderator', 'course-v1:edX+DemoX+Demo_Course'),
(3, 'Community TA', 'course-v1:edX+DemoX+Demo_Course'),
(4, 'Student', 'course-v1:edX+DemoX+Demo_Course'),
(5, 'Student', 'edX/DemoX/Demo_Course'),
(6, 'Administrator', 'edX/DemoX/Demo_Course'),
(7, 'Moderator', 'edX/DemoX/Demo_Course'),
(8, 'Community TA', 'edX/DemoX/Demo_Course'),
(9, 'Administrator', 'course-v1:ITMO+1+today'),
(10, 'Moderator', 'course-v1:ITMO+1+today'),
(11, 'Community TA', 'course-v1:ITMO+1+today'),
(12, 'Student', 'course-v1:ITMO+1+today');

-- --------------------------------------------------------

--
-- Структура таблицы `django_comment_client_role_users`
--

CREATE TABLE `django_comment_client_role_users` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `django_comment_client_role_users`
--

INSERT INTO `django_comment_client_role_users` (`id`, `role_id`, `user_id`) VALUES
(6, 4, 4),
(5, 4, 5),
(1, 5, 1),
(2, 5, 2),
(3, 5, 3),
(4, 5, 4),
(7, 12, 4);

-- --------------------------------------------------------

--
-- Структура таблицы `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `name`, `app_label`, `model`) VALUES
(1, 'permission', 'auth', 'permission'),
(2, 'group', 'auth', 'group'),
(3, 'user', 'auth', 'user'),
(4, 'content type', 'contenttypes', 'contenttype'),
(5, 'session', 'sessions', 'session'),
(6, 'site', 'sites', 'site'),
(7, 'task state', 'djcelery', 'taskmeta'),
(8, 'saved group result', 'djcelery', 'tasksetmeta'),
(9, 'interval', 'djcelery', 'intervalschedule'),
(10, 'crontab', 'djcelery', 'crontabschedule'),
(11, 'periodic tasks', 'djcelery', 'periodictasks'),
(12, 'periodic task', 'djcelery', 'periodictask'),
(13, 'worker', 'djcelery', 'workerstate'),
(14, 'task', 'djcelery', 'taskstate'),
(15, 'migration history', 'south', 'migrationhistory'),
(16, 'server circuit', 'circuit', 'servercircuit'),
(17, 'psychometric data', 'psychometrics', 'psychometricdata'),
(18, 'nonce', 'django_openid_auth', 'nonce'),
(19, 'association', 'django_openid_auth', 'association'),
(20, 'user open id', 'django_openid_auth', 'useropenid'),
(21, 'log entry', 'admin', 'logentry'),
(22, 'cors model', 'corsheaders', 'corsmodel'),
(23, 'student module', 'courseware', 'studentmodule'),
(24, 'student module history', 'courseware', 'studentmodulehistory'),
(25, 'x module user state summary field', 'courseware', 'xmoduleuserstatesummaryfield'),
(26, 'x module student prefs field', 'courseware', 'xmodulestudentprefsfield'),
(27, 'x module student info field', 'courseware', 'xmodulestudentinfofield'),
(28, 'offline computed grade', 'courseware', 'offlinecomputedgrade'),
(29, 'offline computed grade log', 'courseware', 'offlinecomputedgradelog'),
(30, 'student field override', 'courseware', 'studentfieldoverride'),
(31, 'x block disable config', 'xblock_django', 'xblockdisableconfig'),
(32, 'anonymous user id', 'student', 'anonymoususerid'),
(33, 'user standing', 'student', 'userstanding'),
(34, 'user profile', 'student', 'userprofile'),
(35, 'user signup source', 'student', 'usersignupsource'),
(36, 'user test group', 'student', 'usertestgroup'),
(37, 'registration', 'student', 'registration'),
(38, 'pending name change', 'student', 'pendingnamechange'),
(39, 'pending email change', 'student', 'pendingemailchange'),
(40, 'password history', 'student', 'passwordhistory'),
(41, 'login failures', 'student', 'loginfailures'),
(42, 'course enrollment', 'student', 'courseenrollment'),
(43, 'manual enrollment audit', 'student', 'manualenrollmentaudit'),
(44, 'course enrollment allowed', 'student', 'courseenrollmentallowed'),
(45, 'course access role', 'student', 'courseaccessrole'),
(46, 'dashboard configuration', 'student', 'dashboardconfiguration'),
(47, 'linked in add to profile configuration', 'student', 'linkedinaddtoprofileconfiguration'),
(48, 'entrance exam configuration', 'student', 'entranceexamconfiguration'),
(49, 'language proficiency', 'student', 'languageproficiency'),
(50, 'course enrollment attribute', 'student', 'courseenrollmentattribute'),
(51, 'tracking log', 'track', 'trackinglog'),
(52, 'rate limit configuration', 'util', 'ratelimitconfiguration'),
(53, 'certificate whitelist', 'certificates', 'certificatewhitelist'),
(54, 'generated certificate', 'certificates', 'generatedcertificate'),
(55, 'example certificate set', 'certificates', 'examplecertificateset'),
(56, 'example certificate', 'certificates', 'examplecertificate'),
(57, 'certificate generation course setting', 'certificates', 'certificategenerationcoursesetting'),
(58, 'certificate generation configuration', 'certificates', 'certificategenerationconfiguration'),
(59, 'certificate html view configuration', 'certificates', 'certificatehtmlviewconfiguration'),
(60, 'badge assertion', 'certificates', 'badgeassertion'),
(61, 'badge image configuration', 'certificates', 'badgeimageconfiguration'),
(62, 'instructor task', 'instructor_task', 'instructortask'),
(63, 'course software', 'licenses', 'coursesoftware'),
(64, 'user license', 'licenses', 'userlicense'),
(65, 'course user group', 'course_groups', 'courseusergroup'),
(66, 'course user group partition group', 'course_groups', 'courseusergrouppartitiongroup'),
(67, 'course cohorts settings', 'course_groups', 'coursecohortssettings'),
(68, 'course cohort', 'course_groups', 'coursecohort'),
(69, 'course email', 'bulk_email', 'courseemail'),
(70, 'optout', 'bulk_email', 'optout'),
(71, 'course email template', 'bulk_email', 'courseemailtemplate'),
(72, 'course authorization', 'bulk_email', 'courseauthorization'),
(73, 'branding info config', 'branding', 'brandinginfoconfig'),
(74, 'branding api config', 'branding', 'brandingapiconfig'),
(75, 'external auth map', 'external_auth', 'externalauthmap'),
(76, 'client', 'oauth2', 'client'),
(77, 'grant', 'oauth2', 'grant'),
(78, 'access token', 'oauth2', 'accesstoken'),
(79, 'refresh token', 'oauth2', 'refreshtoken'),
(80, 'trusted client', 'oauth2_provider', 'trustedclient'),
(81, 'article', 'wiki', 'article'),
(82, 'Article for object', 'wiki', 'articleforobject'),
(83, 'article revision', 'wiki', 'articlerevision'),
(84, 'URL path', 'wiki', 'urlpath'),
(85, 'article plugin', 'wiki', 'articleplugin'),
(86, 'reusable plugin', 'wiki', 'reusableplugin'),
(87, 'simple plugin', 'wiki', 'simpleplugin'),
(88, 'revision plugin', 'wiki', 'revisionplugin'),
(89, 'revision plugin revision', 'wiki', 'revisionpluginrevision'),
(90, 'article subscription', 'wiki', 'articlesubscription'),
(91, 'type', 'django_notify', 'notificationtype'),
(92, 'settings', 'django_notify', 'settings'),
(93, 'subscription', 'django_notify', 'subscription'),
(94, 'notification', 'django_notify', 'notification'),
(95, 'score', 'foldit', 'score'),
(96, 'puzzle complete', 'foldit', 'puzzlecomplete'),
(97, 'note', 'notes', 'note'),
(98, 'splash config', 'splash', 'splashconfig'),
(99, 'user preference', 'user_api', 'userpreference'),
(100, 'user course tag', 'user_api', 'usercoursetag'),
(101, 'user org tag', 'user_api', 'userorgtag'),
(102, 'course team', 'teams', 'courseteam'),
(103, 'course team membership', 'teams', 'courseteammembership'),
(104, 'order', 'shoppingcart', 'order'),
(105, 'order item', 'shoppingcart', 'orderitem'),
(106, 'invoice', 'shoppingcart', 'invoice'),
(107, 'invoice transaction', 'shoppingcart', 'invoicetransaction'),
(108, 'invoice item', 'shoppingcart', 'invoiceitem'),
(109, 'course registration code invoice item', 'shoppingcart', 'courseregistrationcodeinvoiceitem'),
(110, 'invoice history', 'shoppingcart', 'invoicehistory'),
(111, 'course registration code', 'shoppingcart', 'courseregistrationcode'),
(112, 'registration code redemption', 'shoppingcart', 'registrationcoderedemption'),
(113, 'coupon', 'shoppingcart', 'coupon'),
(114, 'coupon redemption', 'shoppingcart', 'couponredemption'),
(115, 'paid course registration', 'shoppingcart', 'paidcourseregistration'),
(116, 'course reg code item', 'shoppingcart', 'courseregcodeitem'),
(117, 'course reg code item annotation', 'shoppingcart', 'courseregcodeitemannotation'),
(118, 'paid course registration annotation', 'shoppingcart', 'paidcourseregistrationannotation'),
(119, 'certificate item', 'shoppingcart', 'certificateitem'),
(120, 'donation configuration', 'shoppingcart', 'donationconfiguration'),
(121, 'donation', 'shoppingcart', 'donation'),
(122, 'course mode', 'course_modes', 'coursemode'),
(123, 'course modes archive', 'course_modes', 'coursemodesarchive'),
(124, 'software secure photo verification', 'verify_student', 'softwaresecurephotoverification'),
(125, 'verification checkpoint', 'verify_student', 'verificationcheckpoint'),
(126, 'Verification Status', 'verify_student', 'verificationstatus'),
(127, 'in course reverification configuration', 'verify_student', 'incoursereverificationconfiguration'),
(128, 'skipped reverification', 'verify_student', 'skippedreverification'),
(129, 'dark lang config', 'dark_lang', 'darklangconfig'),
(130, 'embargoed course', 'embargo', 'embargoedcourse'),
(131, 'embargoed state', 'embargo', 'embargoedstate'),
(132, 'restricted course', 'embargo', 'restrictedcourse'),
(133, 'country', 'embargo', 'country'),
(134, 'country access rule', 'embargo', 'countryaccessrule'),
(135, 'course access rule history', 'embargo', 'courseaccessrulehistory'),
(136, 'ip filter', 'embargo', 'ipfilter'),
(137, 'course rerun state', 'course_action_state', 'coursererunstate'),
(138, 'mobile api config', 'mobile_api', 'mobileapiconfig'),
(139, 'survey form', 'survey', 'surveyform'),
(140, 'survey answer', 'survey', 'surveyanswer'),
(141, 'x block asides config', 'lms_xblock', 'xblockasidesconfig'),
(142, 'course overview', 'course_overviews', 'courseoverview'),
(143, 'course structure', 'course_structures', 'coursestructure'),
(144, 'x domain proxy configuration', 'cors_csrf', 'xdomainproxyconfiguration'),
(145, 'student item', 'submissions', 'studentitem'),
(146, 'submission', 'submissions', 'submission'),
(147, 'score', 'submissions', 'score'),
(148, 'score summary', 'submissions', 'scoresummary'),
(149, 'rubric', 'assessment', 'rubric'),
(150, 'criterion', 'assessment', 'criterion'),
(151, 'criterion option', 'assessment', 'criterionoption'),
(152, 'assessment', 'assessment', 'assessment'),
(153, 'assessment part', 'assessment', 'assessmentpart'),
(154, 'assessment feedback option', 'assessment', 'assessmentfeedbackoption'),
(155, 'assessment feedback', 'assessment', 'assessmentfeedback'),
(156, 'peer workflow', 'assessment', 'peerworkflow'),
(157, 'peer workflow item', 'assessment', 'peerworkflowitem'),
(158, 'training example', 'assessment', 'trainingexample'),
(159, 'student training workflow', 'assessment', 'studenttrainingworkflow'),
(160, 'student training workflow item', 'assessment', 'studenttrainingworkflowitem'),
(161, 'ai classifier set', 'assessment', 'aiclassifierset'),
(162, 'ai classifier', 'assessment', 'aiclassifier'),
(163, 'ai training workflow', 'assessment', 'aitrainingworkflow'),
(164, 'ai grading workflow', 'assessment', 'aigradingworkflow'),
(165, 'assessment workflow', 'workflow', 'assessmentworkflow'),
(166, 'assessment workflow step', 'workflow', 'assessmentworkflowstep'),
(167, 'assessment workflow cancellation', 'workflow', 'assessmentworkflowcancellation'),
(168, 'profile', 'edxval', 'profile'),
(169, 'video', 'edxval', 'video'),
(170, 'course video', 'edxval', 'coursevideo'),
(171, 'encoded video', 'edxval', 'encodedvideo'),
(172, 'subtitle', 'edxval', 'subtitle'),
(173, 'milestone', 'milestones', 'milestone'),
(174, 'milestone relationship type', 'milestones', 'milestonerelationshiptype'),
(175, 'course milestone', 'milestones', 'coursemilestone'),
(176, 'course content milestone', 'milestones', 'coursecontentmilestone'),
(177, 'user milestone', 'milestones', 'usermilestone'),
(178, 'credit provider', 'credit', 'creditprovider'),
(179, 'credit course', 'credit', 'creditcourse'),
(180, 'credit requirement', 'credit', 'creditrequirement'),
(181, 'historical credit requirement status', 'credit', 'historicalcreditrequirementstatus'),
(182, 'credit requirement status', 'credit', 'creditrequirementstatus'),
(183, 'credit eligibility', 'credit', 'crediteligibility'),
(184, 'historical credit request', 'credit', 'historicalcreditrequest'),
(185, 'credit request', 'credit', 'creditrequest'),
(186, 'video upload config', 'contentstore', 'videouploadconfig'),
(187, 'push notification config', 'contentstore', 'pushnotificationconfig'),
(188, 'course creator', 'course_creators', 'coursecreator'),
(189, 'studio config', 'xblock_config', 'studioconfig');

-- --------------------------------------------------------

--
-- Структура таблицы `django_openid_auth_association`
--

CREATE TABLE `django_openid_auth_association` (
  `id` int(11) NOT NULL,
  `server_url` longtext NOT NULL,
  `handle` varchar(255) NOT NULL,
  `secret` longtext NOT NULL,
  `issued` int(11) NOT NULL,
  `lifetime` int(11) NOT NULL,
  `assoc_type` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `django_openid_auth_nonce`
--

CREATE TABLE `django_openid_auth_nonce` (
  `id` int(11) NOT NULL,
  `server_url` varchar(2047) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `salt` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `django_openid_auth_useropenid`
--

CREATE TABLE `django_openid_auth_useropenid` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `claimed_id` longtext NOT NULL,
  `display_id` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `django_site`
--

CREATE TABLE `django_site` (
  `id` int(11) NOT NULL,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `django_site`
--

INSERT INTO `django_site` (`id`, `domain`, `name`) VALUES
(1, 'example.com', 'example.com');

-- --------------------------------------------------------

--
-- Структура таблицы `djcelery_crontabschedule`
--

CREATE TABLE `djcelery_crontabschedule` (
  `id` int(11) NOT NULL,
  `minute` varchar(64) NOT NULL,
  `hour` varchar(64) NOT NULL,
  `day_of_week` varchar(64) NOT NULL,
  `day_of_month` varchar(64) NOT NULL,
  `month_of_year` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `djcelery_intervalschedule`
--

CREATE TABLE `djcelery_intervalschedule` (
  `id` int(11) NOT NULL,
  `every` int(11) NOT NULL,
  `period` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `djcelery_periodictask`
--

CREATE TABLE `djcelery_periodictask` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `task` varchar(200) NOT NULL,
  `interval_id` int(11) DEFAULT NULL,
  `crontab_id` int(11) DEFAULT NULL,
  `args` longtext NOT NULL,
  `kwargs` longtext NOT NULL,
  `queue` varchar(200) DEFAULT NULL,
  `exchange` varchar(200) DEFAULT NULL,
  `routing_key` varchar(200) DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `last_run_at` datetime DEFAULT NULL,
  `total_run_count` int(10) UNSIGNED NOT NULL,
  `date_changed` datetime NOT NULL,
  `description` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `djcelery_periodictasks`
--

CREATE TABLE `djcelery_periodictasks` (
  `ident` smallint(6) NOT NULL,
  `last_update` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `djcelery_taskstate`
--

CREATE TABLE `djcelery_taskstate` (
  `id` int(11) NOT NULL,
  `state` varchar(64) NOT NULL,
  `task_id` varchar(36) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `tstamp` datetime NOT NULL,
  `args` longtext,
  `kwargs` longtext,
  `eta` datetime DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `result` longtext,
  `traceback` longtext,
  `runtime` double DEFAULT NULL,
  `retries` int(11) NOT NULL,
  `worker_id` int(11) DEFAULT NULL,
  `hidden` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `djcelery_workerstate`
--

CREATE TABLE `djcelery_workerstate` (
  `id` int(11) NOT NULL,
  `hostname` varchar(255) NOT NULL,
  `last_heartbeat` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `edxval_coursevideo`
--

CREATE TABLE `edxval_coursevideo` (
  `id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `video_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `edxval_encodedvideo`
--

CREATE TABLE `edxval_encodedvideo` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `url` varchar(200) NOT NULL,
  `file_size` int(10) UNSIGNED NOT NULL,
  `bitrate` int(10) UNSIGNED NOT NULL,
  `profile_id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `edxval_profile`
--

CREATE TABLE `edxval_profile` (
  `id` int(11) NOT NULL,
  `profile_name` varchar(50) NOT NULL,
  `extension` varchar(10) DEFAULT 'mp4',
  `width` int(10) UNSIGNED DEFAULT '1',
  `height` int(10) UNSIGNED DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `edxval_profile`
--

INSERT INTO `edxval_profile` (`id`, `profile_name`, `extension`, `width`, `height`) VALUES
(1, 'desktop_mp4', 'mp4', 1280, 720),
(2, 'desktop_webm', 'webm', 1280, 720),
(3, 'mobile_high', 'mp4', 960, 540),
(4, 'mobile_low', 'mp4', 640, 360),
(5, 'youtube', 'mp4', 1920, 1080);

-- --------------------------------------------------------

--
-- Структура таблицы `edxval_subtitle`
--

CREATE TABLE `edxval_subtitle` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `video_id` int(11) NOT NULL,
  `fmt` varchar(20) NOT NULL,
  `language` varchar(8) NOT NULL,
  `content` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `edxval_video`
--

CREATE TABLE `edxval_video` (
  `id` int(11) NOT NULL,
  `edx_video_id` varchar(100) NOT NULL,
  `client_video_id` varchar(255) NOT NULL,
  `duration` double NOT NULL,
  `created` datetime NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `embargo_country`
--

CREATE TABLE `embargo_country` (
  `id` int(11) NOT NULL,
  `country` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `embargo_country`
--

INSERT INTO `embargo_country` (`id`, `country`) VALUES
(6, 'AD'),
(234, 'AE'),
(1, 'AF'),
(10, 'AG'),
(8, 'AI'),
(3, 'AL'),
(12, 'AM'),
(7, 'AO'),
(9, 'AQ'),
(11, 'AR'),
(5, 'AS'),
(15, 'AT'),
(14, 'AU'),
(13, 'AW'),
(2, 'AX'),
(16, 'AZ'),
(29, 'BA'),
(20, 'BB'),
(19, 'BD'),
(22, 'BE'),
(36, 'BF'),
(35, 'BG'),
(18, 'BH'),
(37, 'BI'),
(24, 'BJ'),
(184, 'BL'),
(25, 'BM'),
(34, 'BN'),
(27, 'BO'),
(28, 'BQ'),
(32, 'BR'),
(17, 'BS'),
(26, 'BT'),
(31, 'BV'),
(30, 'BW'),
(21, 'BY'),
(23, 'BZ'),
(41, 'CA'),
(48, 'CC'),
(52, 'CD'),
(43, 'CF'),
(51, 'CG'),
(216, 'CH'),
(55, 'CI'),
(53, 'CK'),
(45, 'CL'),
(40, 'CM'),
(46, 'CN'),
(49, 'CO'),
(54, 'CR'),
(57, 'CU'),
(38, 'CV'),
(58, 'CW'),
(47, 'CX'),
(59, 'CY'),
(60, 'CZ'),
(83, 'DE'),
(62, 'DJ'),
(61, 'DK'),
(63, 'DM'),
(64, 'DO'),
(4, 'DZ'),
(65, 'EC'),
(70, 'EE'),
(66, 'EG'),
(246, 'EH'),
(69, 'ER'),
(209, 'ES'),
(71, 'ET'),
(75, 'FI'),
(74, 'FJ'),
(72, 'FK'),
(143, 'FM'),
(73, 'FO'),
(76, 'FR'),
(80, 'GA'),
(235, 'GB'),
(88, 'GD'),
(82, 'GE'),
(77, 'GF'),
(92, 'GG'),
(84, 'GH'),
(85, 'GI'),
(87, 'GL'),
(81, 'GM'),
(93, 'GN'),
(89, 'GP'),
(68, 'GQ'),
(86, 'GR'),
(206, 'GS'),
(91, 'GT'),
(90, 'GU'),
(94, 'GW'),
(95, 'GY'),
(100, 'HK'),
(97, 'HM'),
(99, 'HN'),
(56, 'HR'),
(96, 'HT'),
(101, 'HU'),
(104, 'ID'),
(107, 'IE'),
(109, 'IL'),
(108, 'IM'),
(103, 'IN'),
(33, 'IO'),
(106, 'IQ'),
(105, 'IR'),
(102, 'IS'),
(110, 'IT'),
(113, 'JE'),
(111, 'JM'),
(114, 'JO'),
(112, 'JP'),
(116, 'KE'),
(119, 'KG'),
(39, 'KH'),
(117, 'KI'),
(50, 'KM'),
(186, 'KN'),
(163, 'KP'),
(207, 'KR'),
(118, 'KW'),
(42, 'KY'),
(115, 'KZ'),
(120, 'LA'),
(122, 'LB'),
(187, 'LC'),
(126, 'LI'),
(210, 'LK'),
(124, 'LR'),
(123, 'LS'),
(127, 'LT'),
(128, 'LU'),
(121, 'LV'),
(125, 'LY'),
(149, 'MA'),
(145, 'MC'),
(144, 'MD'),
(147, 'ME'),
(188, 'MF'),
(131, 'MG'),
(137, 'MH'),
(130, 'MK'),
(135, 'ML'),
(151, 'MM'),
(146, 'MN'),
(129, 'MO'),
(164, 'MP'),
(138, 'MQ'),
(139, 'MR'),
(148, 'MS'),
(136, 'MT'),
(140, 'MU'),
(134, 'MV'),
(132, 'MW'),
(142, 'MX'),
(133, 'MY'),
(150, 'MZ'),
(152, 'NA'),
(156, 'NC'),
(159, 'NE'),
(162, 'NF'),
(160, 'NG'),
(158, 'NI'),
(155, 'NL'),
(165, 'NO'),
(154, 'NP'),
(153, 'NR'),
(161, 'NU'),
(157, 'NZ'),
(166, 'OM'),
(170, 'PA'),
(173, 'PE'),
(78, 'PF'),
(171, 'PG'),
(174, 'PH'),
(167, 'PK'),
(176, 'PL'),
(189, 'PM'),
(175, 'PN'),
(178, 'PR'),
(169, 'PS'),
(177, 'PT'),
(168, 'PW'),
(172, 'PY'),
(179, 'QA'),
(180, 'RE'),
(181, 'RO'),
(196, 'RS'),
(182, 'RU'),
(183, 'RW'),
(194, 'SA'),
(203, 'SB'),
(197, 'SC'),
(211, 'SD'),
(215, 'SE'),
(199, 'SG'),
(185, 'SH'),
(202, 'SI'),
(213, 'SJ'),
(201, 'SK'),
(198, 'SL'),
(192, 'SM'),
(195, 'SN'),
(204, 'SO'),
(212, 'SR'),
(208, 'SS'),
(193, 'ST'),
(67, 'SV'),
(200, 'SX'),
(217, 'SY'),
(214, 'SZ'),
(230, 'TC'),
(44, 'TD'),
(79, 'TF'),
(223, 'TG'),
(221, 'TH'),
(219, 'TJ'),
(224, 'TK'),
(222, 'TL'),
(229, 'TM'),
(227, 'TN'),
(225, 'TO'),
(228, 'TR'),
(226, 'TT'),
(231, 'TV'),
(218, 'TW'),
(220, 'TZ'),
(233, 'UA'),
(232, 'UG'),
(236, 'UM'),
(237, 'US'),
(238, 'UY'),
(239, 'UZ'),
(98, 'VA'),
(190, 'VC'),
(241, 'VE'),
(243, 'VG'),
(244, 'VI'),
(242, 'VN'),
(240, 'VU'),
(245, 'WF'),
(191, 'WS'),
(247, 'YE'),
(141, 'YT'),
(205, 'ZA'),
(248, 'ZM'),
(249, 'ZW');

-- --------------------------------------------------------

--
-- Структура таблицы `embargo_countryaccessrule`
--

CREATE TABLE `embargo_countryaccessrule` (
  `id` int(11) NOT NULL,
  `rule_type` varchar(255) NOT NULL,
  `restricted_course_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `embargo_courseaccessrulehistory`
--

CREATE TABLE `embargo_courseaccessrulehistory` (
  `id` int(11) NOT NULL,
  `timestamp` datetime NOT NULL,
  `course_key` varchar(255) NOT NULL,
  `snapshot` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `embargo_embargoedcourse`
--

CREATE TABLE `embargo_embargoedcourse` (
  `id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `embargoed` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `embargo_embargoedstate`
--

CREATE TABLE `embargo_embargoedstate` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `embargoed_countries` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `embargo_ipfilter`
--

CREATE TABLE `embargo_ipfilter` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `whitelist` longtext NOT NULL,
  `blacklist` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `embargo_restrictedcourse`
--

CREATE TABLE `embargo_restrictedcourse` (
  `id` int(11) NOT NULL,
  `course_key` varchar(255) NOT NULL,
  `enroll_msg_key` varchar(255) NOT NULL,
  `access_msg_key` varchar(255) NOT NULL,
  `disable_access_check` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `external_auth_externalauthmap`
--

CREATE TABLE `external_auth_externalauthmap` (
  `id` int(11) NOT NULL,
  `external_id` varchar(255) NOT NULL,
  `external_domain` varchar(255) NOT NULL,
  `external_credentials` longtext NOT NULL,
  `external_email` varchar(255) NOT NULL,
  `external_name` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `internal_password` varchar(31) NOT NULL,
  `dtcreated` datetime NOT NULL,
  `dtsignup` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `foldit_puzzlecomplete`
--

CREATE TABLE `foldit_puzzlecomplete` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `unique_user_id` varchar(50) NOT NULL,
  `puzzle_id` int(11) NOT NULL,
  `puzzle_set` int(11) NOT NULL,
  `puzzle_subset` int(11) NOT NULL,
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `foldit_score`
--

CREATE TABLE `foldit_score` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `unique_user_id` varchar(50) NOT NULL,
  `puzzle_id` int(11) NOT NULL,
  `best_score` double NOT NULL,
  `current_score` double NOT NULL,
  `score_version` int(11) NOT NULL,
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `instructor_task_instructortask`
--

CREATE TABLE `instructor_task_instructortask` (
  `id` int(11) NOT NULL,
  `task_type` varchar(50) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `task_key` varchar(255) NOT NULL,
  `task_input` varchar(255) NOT NULL,
  `task_id` varchar(255) NOT NULL,
  `task_state` varchar(50) DEFAULT NULL,
  `task_output` varchar(1024) DEFAULT NULL,
  `requester_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime NOT NULL,
  `subtasks` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `licenses_coursesoftware`
--

CREATE TABLE `licenses_coursesoftware` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `licenses_userlicense`
--

CREATE TABLE `licenses_userlicense` (
  `id` int(11) NOT NULL,
  `software_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `serial` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `lms_xblock_xblockasidesconfig`
--

CREATE TABLE `lms_xblock_xblockasidesconfig` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `disabled_blocks` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `milestones_coursecontentmilestone`
--

CREATE TABLE `milestones_coursecontentmilestone` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `content_id` varchar(255) NOT NULL,
  `milestone_id` int(11) NOT NULL,
  `milestone_relationship_type_id` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `milestones_coursemilestone`
--

CREATE TABLE `milestones_coursemilestone` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `milestone_id` int(11) NOT NULL,
  `milestone_relationship_type_id` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `milestones_milestone`
--

CREATE TABLE `milestones_milestone` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `milestones_milestonerelationshiptype`
--

CREATE TABLE `milestones_milestonerelationshiptype` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `name` varchar(25) NOT NULL,
  `description` longtext NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `milestones_milestonerelationshiptype`
--

INSERT INTO `milestones_milestonerelationshiptype` (`id`, `created`, `modified`, `name`, `description`, `active`) VALUES
(1, '2015-08-07 16:33:17', '2015-08-07 16:33:17', 'fulfills', 'Autogenerated milestone relationship type "fulfills"', 1),
(2, '2015-08-07 16:33:17', '2015-08-07 16:33:17', 'requires', 'Autogenerated milestone relationship type "requires"', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `milestones_usermilestone`
--

CREATE TABLE `milestones_usermilestone` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `milestone_id` int(11) NOT NULL,
  `source` longtext NOT NULL,
  `collected` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `mobile_api_mobileapiconfig`
--

CREATE TABLE `mobile_api_mobileapiconfig` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `video_profiles` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `mobile_api_mobileapiconfig`
--

INSERT INTO `mobile_api_mobileapiconfig` (`id`, `change_date`, `changed_by_id`, `enabled`, `video_profiles`) VALUES
(1, '2015-08-07 16:33:06', NULL, 0, 'mobile_low,mobile_high,youtube');

-- --------------------------------------------------------

--
-- Структура таблицы `notes_note`
--

CREATE TABLE `notes_note` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `uri` varchar(255) NOT NULL,
  `text` longtext NOT NULL,
  `quote` longtext NOT NULL,
  `range_start` varchar(2048) NOT NULL,
  `range_start_offset` int(11) NOT NULL,
  `range_end` varchar(2048) NOT NULL,
  `range_end_offset` int(11) NOT NULL,
  `tags` longtext NOT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `notifications_articlesubscription`
--

CREATE TABLE `notifications_articlesubscription` (
  `subscription_ptr_id` int(11) NOT NULL,
  `articleplugin_ptr_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `notify_notification`
--

CREATE TABLE `notify_notification` (
  `id` int(11) NOT NULL,
  `subscription_id` int(11) DEFAULT NULL,
  `message` longtext NOT NULL,
  `url` varchar(200) DEFAULT NULL,
  `is_viewed` tinyint(1) NOT NULL,
  `is_emailed` tinyint(1) NOT NULL,
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `notify_notificationtype`
--

CREATE TABLE `notify_notificationtype` (
  `key` varchar(128) NOT NULL,
  `label` varchar(128) DEFAULT NULL,
  `content_type_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `notify_settings`
--

CREATE TABLE `notify_settings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `interval` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `notify_subscription`
--

CREATE TABLE `notify_subscription` (
  `id` int(11) NOT NULL,
  `settings_id` int(11) NOT NULL,
  `notification_type_id` varchar(128) NOT NULL,
  `object_id` varchar(64) DEFAULT NULL,
  `send_emails` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `oauth2_accesstoken`
--

CREATE TABLE `oauth2_accesstoken` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `client_id` int(11) NOT NULL,
  `expires` datetime NOT NULL,
  `scope` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `oauth2_client`
--

CREATE TABLE `oauth2_client` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `url` varchar(200) NOT NULL,
  `redirect_uri` varchar(200) NOT NULL,
  `client_id` varchar(255) NOT NULL,
  `client_secret` varchar(255) NOT NULL,
  `client_type` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `oauth2_grant`
--

CREATE TABLE `oauth2_grant` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `expires` datetime NOT NULL,
  `redirect_uri` varchar(255) NOT NULL,
  `scope` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `oauth2_provider_trustedclient`
--

CREATE TABLE `oauth2_provider_trustedclient` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `oauth2_refreshtoken`
--

CREATE TABLE `oauth2_refreshtoken` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `access_token_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `expired` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `psychometrics_psychometricdata`
--

CREATE TABLE `psychometrics_psychometricdata` (
  `id` int(11) NOT NULL,
  `studentmodule_id` int(11) NOT NULL,
  `done` tinyint(1) NOT NULL,
  `attempts` int(11) NOT NULL,
  `checktimes` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `reverification_midcoursereverificationwindow`
--

CREATE TABLE `reverification_midcoursereverificationwindow` (
  `id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_certificateitem`
--

CREATE TABLE `shoppingcart_certificateitem` (
  `orderitem_ptr_id` int(11) NOT NULL,
  `course_id` varchar(128) NOT NULL,
  `course_enrollment_id` int(11) NOT NULL,
  `mode` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_coupon`
--

CREATE TABLE `shoppingcart_coupon` (
  `id` int(11) NOT NULL,
  `code` varchar(32) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `course_id` varchar(255) NOT NULL,
  `percentage_discount` int(11) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `expiration_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_couponredemption`
--

CREATE TABLE `shoppingcart_couponredemption` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `coupon_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_courseregcodeitem`
--

CREATE TABLE `shoppingcart_courseregcodeitem` (
  `orderitem_ptr_id` int(11) NOT NULL,
  `course_id` varchar(128) NOT NULL,
  `mode` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_courseregcodeitemannotation`
--

CREATE TABLE `shoppingcart_courseregcodeitemannotation` (
  `id` int(11) NOT NULL,
  `course_id` varchar(128) NOT NULL,
  `annotation` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_courseregistrationcode`
--

CREATE TABLE `shoppingcart_courseregistrationcode` (
  `id` int(11) NOT NULL,
  `code` varchar(32) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `mode_slug` varchar(100) DEFAULT NULL,
  `invoice_item_id` int(11) DEFAULT NULL,
  `is_valid` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_courseregistrationcodeinvoiceitem`
--

CREATE TABLE `shoppingcart_courseregistrationcodeinvoiceitem` (
  `invoiceitem_ptr_id` int(11) NOT NULL,
  `course_id` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_donation`
--

CREATE TABLE `shoppingcart_donation` (
  `orderitem_ptr_id` int(11) NOT NULL,
  `donation_type` varchar(32) NOT NULL,
  `course_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_donationconfiguration`
--

CREATE TABLE `shoppingcart_donationconfiguration` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_invoice`
--

CREATE TABLE `shoppingcart_invoice` (
  `id` int(11) NOT NULL,
  `total_amount` double NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `internal_reference` varchar(255) DEFAULT NULL,
  `is_valid` tinyint(1) NOT NULL,
  `address_line_1` varchar(255) NOT NULL,
  `address_line_2` varchar(255) DEFAULT NULL,
  `address_line_3` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(15) DEFAULT NULL,
  `country` varchar(64) DEFAULT NULL,
  `recipient_name` varchar(255) NOT NULL,
  `recipient_email` varchar(255) NOT NULL,
  `customer_reference_number` varchar(63) DEFAULT NULL,
  `company_contact_name` varchar(255) NOT NULL,
  `company_contact_email` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_invoicehistory`
--

CREATE TABLE `shoppingcart_invoicehistory` (
  `id` int(11) NOT NULL,
  `timestamp` datetime NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `snapshot` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_invoiceitem`
--

CREATE TABLE `shoppingcart_invoiceitem` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `unit_price` decimal(30,2) NOT NULL,
  `currency` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_invoicetransaction`
--

CREATE TABLE `shoppingcart_invoicetransaction` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `amount` decimal(30,2) NOT NULL,
  `currency` varchar(8) NOT NULL,
  `comments` longtext,
  `status` varchar(32) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `last_modified_by_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_order`
--

CREATE TABLE `shoppingcart_order` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `currency` varchar(8) NOT NULL,
  `status` varchar(32) NOT NULL,
  `purchase_time` datetime DEFAULT NULL,
  `bill_to_first` varchar(64) NOT NULL,
  `bill_to_last` varchar(64) NOT NULL,
  `bill_to_street1` varchar(128) NOT NULL,
  `bill_to_street2` varchar(128) NOT NULL,
  `bill_to_city` varchar(64) NOT NULL,
  `bill_to_state` varchar(8) NOT NULL,
  `bill_to_postalcode` varchar(16) NOT NULL,
  `bill_to_country` varchar(64) NOT NULL,
  `bill_to_ccnum` varchar(8) NOT NULL,
  `bill_to_cardtype` varchar(32) NOT NULL,
  `processor_reply_dump` longtext NOT NULL,
  `refunded_time` datetime DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `company_contact_name` varchar(255) DEFAULT NULL,
  `company_contact_email` varchar(255) DEFAULT NULL,
  `recipient_name` varchar(255) DEFAULT NULL,
  `recipient_email` varchar(255) DEFAULT NULL,
  `customer_reference_number` varchar(63) DEFAULT NULL,
  `order_type` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_orderitem`
--

CREATE TABLE `shoppingcart_orderitem` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` varchar(32) NOT NULL,
  `qty` int(11) NOT NULL,
  `unit_cost` decimal(30,2) NOT NULL,
  `line_desc` varchar(1024) NOT NULL,
  `currency` varchar(8) NOT NULL,
  `fulfilled_time` datetime DEFAULT NULL,
  `report_comments` longtext NOT NULL,
  `refund_requested_time` datetime DEFAULT NULL,
  `service_fee` decimal(30,2) NOT NULL,
  `list_price` decimal(30,2) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_paidcourseregistration`
--

CREATE TABLE `shoppingcart_paidcourseregistration` (
  `orderitem_ptr_id` int(11) NOT NULL,
  `course_id` varchar(128) NOT NULL,
  `mode` varchar(50) NOT NULL,
  `course_enrollment_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_paidcourseregistrationannotation`
--

CREATE TABLE `shoppingcart_paidcourseregistrationannotation` (
  `id` int(11) NOT NULL,
  `course_id` varchar(128) NOT NULL,
  `annotation` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart_registrationcoderedemption`
--

CREATE TABLE `shoppingcart_registrationcoderedemption` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `registration_code_id` int(11) NOT NULL,
  `redeemed_by_id` int(11) NOT NULL,
  `redeemed_at` datetime DEFAULT NULL,
  `course_enrollment_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `south_migrationhistory`
--

CREATE TABLE `south_migrationhistory` (
  `id` int(11) NOT NULL,
  `app_name` varchar(255) NOT NULL,
  `migration` varchar(255) NOT NULL,
  `applied` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `south_migrationhistory`
--

INSERT INTO `south_migrationhistory` (`id`, `app_name`, `migration`, `applied`) VALUES
(1, 'courseware', '0001_initial', '2015-08-07 16:32:29'),
(2, 'courseware', '0002_add_indexes', '2015-08-07 16:32:29'),
(3, 'courseware', '0003_done_grade_cache', '2015-08-07 16:32:30'),
(4, 'courseware', '0004_add_field_studentmodule_course_id', '2015-08-07 16:32:30'),
(5, 'courseware', '0005_auto__add_offlinecomputedgrade__add_unique_offlinecomputedgrade_user_c', '2015-08-07 16:32:30'),
(6, 'courseware', '0006_create_student_module_history', '2015-08-07 16:32:30'),
(7, 'courseware', '0007_allow_null_version_in_history', '2015-08-07 16:32:30'),
(8, 'courseware', '0008_add_xmodule_storage', '2015-08-07 16:32:31'),
(9, 'courseware', '0009_add_field_default', '2015-08-07 16:32:31'),
(10, 'courseware', '0010_rename_xblock_field_content_to_user_state_summary', '2015-08-07 16:32:31'),
(11, 'courseware', '0011_add_model_StudentFieldOverride', '2015-08-07 16:32:31'),
(12, 'courseware', '0012_auto__del_unique_studentfieldoverride_course_id_location_student__add_', '2015-08-07 16:32:31'),
(13, 'courseware', '0013_auto__add_field_studentfieldoverride_created__add_field_studentfieldov', '2015-08-07 16:32:32'),
(14, 'xblock_django', '0001_initial', '2015-08-07 16:32:32'),
(15, 'student', '0001_initial', '2015-08-07 16:32:32'),
(16, 'student', '0002_text_to_varchar_and_indexes', '2015-08-07 16:32:32'),
(17, 'student', '0003_auto__add_usertestgroup', '2015-08-07 16:32:32'),
(18, 'student', '0004_add_email_index', '2015-08-07 16:32:32'),
(19, 'student', '0005_name_change', '2015-08-07 16:32:33'),
(20, 'student', '0006_expand_meta_field', '2015-08-07 16:32:33'),
(21, 'student', '0007_convert_to_utf8', '2015-08-07 16:32:33'),
(22, 'student', '0008__auto__add_courseregistration', '2015-08-07 16:32:33'),
(23, 'student', '0009_auto__del_courseregistration__add_courseenrollment', '2015-08-07 16:32:33'),
(24, 'student', '0010_auto__chg_field_courseenrollment_course_id', '2015-08-07 16:32:33'),
(25, 'student', '0011_auto__chg_field_courseenrollment_user__del_unique_courseenrollment_use', '2015-08-07 16:32:33'),
(26, 'student', '0012_auto__add_field_userprofile_gender__add_field_userprofile_date_of_birt', '2015-08-07 16:32:33'),
(27, 'student', '0013_auto__chg_field_userprofile_meta', '2015-08-07 16:32:33'),
(28, 'student', '0014_auto__del_courseenrollment', '2015-08-07 16:32:33'),
(29, 'student', '0015_auto__add_courseenrollment__add_unique_courseenrollment_user_course_id', '2015-08-07 16:32:33'),
(30, 'student', '0016_auto__add_field_courseenrollment_date__chg_field_userprofile_country', '2015-08-07 16:32:34'),
(31, 'student', '0017_rename_date_to_created', '2015-08-07 16:32:34'),
(32, 'student', '0018_auto', '2015-08-07 16:32:34'),
(33, 'student', '0019_create_approved_demographic_fields_fall_2012', '2015-08-07 16:32:34'),
(34, 'student', '0020_add_test_center_user', '2015-08-07 16:32:35'),
(35, 'student', '0021_remove_askbot', '2015-08-07 16:32:35'),
(36, 'student', '0022_auto__add_courseenrollmentallowed__add_unique_courseenrollmentallowed_', '2015-08-07 16:32:35'),
(37, 'student', '0023_add_test_center_registration', '2015-08-07 16:32:36'),
(38, 'student', '0024_add_allow_certificate', '2015-08-07 16:32:36'),
(39, 'student', '0025_auto__add_field_courseenrollmentallowed_auto_enroll', '2015-08-07 16:32:36'),
(40, 'student', '0026_auto__remove_index_student_testcenterregistration_accommodation_request', '2015-08-07 16:32:36'),
(41, 'student', '0027_add_active_flag_and_mode_to_courseware_enrollment', '2015-08-07 16:32:36'),
(42, 'student', '0028_auto__add_userstanding', '2015-08-07 16:32:37'),
(43, 'student', '0029_add_lookup_table_between_user_and_anonymous_student_id', '2015-08-07 16:32:37'),
(44, 'student', '0029_remove_pearson', '2015-08-07 16:32:37'),
(45, 'student', '0030_auto__chg_field_anonymoususerid_anonymous_user_id', '2015-08-07 16:32:37'),
(46, 'student', '0031_drop_student_anonymoususerid_temp_archive', '2015-08-07 16:32:37'),
(47, 'student', '0032_add_field_UserProfile_country_add_field_UserProfile_city', '2015-08-07 16:32:37'),
(48, 'student', '0032_auto__add_loginfailures', '2015-08-07 16:32:37'),
(49, 'student', '0033_auto__add_passwordhistory', '2015-08-07 16:32:37'),
(50, 'student', '0034_auto__add_courseaccessrole', '2015-08-07 16:32:38'),
(51, 'student', '0035_access_roles', '2015-08-07 16:32:38'),
(52, 'student', '0036_access_roles_orgless', '2015-08-07 16:32:38'),
(53, 'student', '0037_auto__add_courseregistrationcode', '2015-08-07 16:32:38'),
(54, 'student', '0038_auto__add_usersignupsource', '2015-08-07 16:32:38'),
(55, 'student', '0039_auto__del_courseregistrationcode', '2015-08-07 16:32:39'),
(56, 'student', '0040_auto__del_field_usersignupsource_user_id__add_field_usersignupsource_u', '2015-08-07 16:32:39'),
(57, 'student', '0041_add_dashboard_config', '2015-08-07 16:32:39'),
(58, 'student', '0042_grant_sales_admin_roles', '2015-08-07 16:32:39'),
(59, 'student', '0043_auto__add_linkedinaddtoprofileconfiguration', '2015-08-07 16:32:39'),
(60, 'student', '0044_linkedin_add_company_identifier', '2015-08-07 16:32:39'),
(61, 'student', '0045_add_trk_partner_to_linkedin_config', '2015-08-07 16:32:39'),
(62, 'student', '0046_auto__add_entranceexamconfiguration__add_unique_entranceexamconfigurat', '2015-08-07 16:32:39'),
(63, 'student', '0047_add_bio_field', '2015-08-07 16:32:39'),
(64, 'student', '0048_add_profile_image_version', '2015-08-07 16:32:40'),
(65, 'student', '0049_auto__add_languageproficiency__add_unique_languageproficiency_code_use', '2015-08-07 16:32:40'),
(66, 'student', '0050_auto__add_manualenrollmentaudit', '2015-08-07 16:32:40'),
(67, 'student', '0051_auto__add_courseenrollmentattribute', '2015-08-07 16:32:40'),
(68, 'track', '0001_initial', '2015-08-07 16:32:40'),
(69, 'track', '0002_auto__add_field_trackinglog_host__chg_field_trackinglog_event_type__ch', '2015-08-07 16:32:41'),
(70, 'util', '0001_initial', '2015-08-07 16:32:41'),
(71, 'util', '0002_default_rate_limit_config', '2015-08-07 16:32:41'),
(72, 'certificates', '0001_added_generatedcertificates', '2015-08-07 16:32:41'),
(73, 'certificates', '0002_auto__add_field_generatedcertificate_download_url', '2015-08-07 16:32:41'),
(74, 'certificates', '0003_auto__add_field_generatedcertificate_enabled', '2015-08-07 16:32:41'),
(75, 'certificates', '0004_auto__add_field_generatedcertificate_graded_certificate_id__add_field_', '2015-08-07 16:32:41'),
(76, 'certificates', '0005_auto__add_field_generatedcertificate_name', '2015-08-07 16:32:41'),
(77, 'certificates', '0006_auto__chg_field_generatedcertificate_certificate_id', '2015-08-07 16:32:41'),
(78, 'certificates', '0007_auto__add_revokedcertificate', '2015-08-07 16:32:41'),
(79, 'certificates', '0008_auto__del_revokedcertificate__del_field_generatedcertificate_name__add', '2015-08-07 16:32:42'),
(80, 'certificates', '0009_auto__del_field_generatedcertificate_graded_download_url__del_field_ge', '2015-08-07 16:32:42'),
(81, 'certificates', '0010_auto__del_field_generatedcertificate_enabled__add_field_generatedcerti', '2015-08-07 16:32:42'),
(82, 'certificates', '0011_auto__del_field_generatedcertificate_certificate_id__add_field_generat', '2015-08-07 16:32:42'),
(83, 'certificates', '0012_auto__add_field_generatedcertificate_name__add_field_generatedcertific', '2015-08-07 16:32:43'),
(84, 'certificates', '0013_auto__add_field_generatedcertificate_error_reason', '2015-08-07 16:32:43'),
(85, 'certificates', '0014_adding_whitelist', '2015-08-07 16:32:43'),
(86, 'certificates', '0015_adding_mode_for_verified_certs', '2015-08-07 16:32:43'),
(87, 'certificates', '0016_change_course_key_fields', '2015-08-07 16:32:43'),
(88, 'certificates', '0017_auto__add_certificategenerationconfiguration', '2015-08-07 16:32:43'),
(89, 'certificates', '0018_add_example_cert_models', '2015-08-07 16:32:43'),
(90, 'certificates', '0019_auto__add_certificatehtmlviewconfiguration', '2015-08-07 16:32:44'),
(91, 'certificates', '0020_certificatehtmlviewconfiguration_data', '2015-08-07 16:32:44'),
(92, 'certificates', '0021_auto__add_badgeassertion__add_unique_badgeassertion_course_id_user__ad', '2015-08-07 16:32:44'),
(93, 'certificates', '0022_default_modes', '2015-08-07 16:32:44'),
(94, 'instructor_task', '0001_initial', '2015-08-07 16:32:44'),
(95, 'instructor_task', '0002_add_subtask_field', '2015-08-07 16:32:44'),
(96, 'licenses', '0001_initial', '2015-08-07 16:32:45'),
(97, 'course_groups', '0001_initial', '2015-08-07 16:32:45'),
(98, 'course_groups', '0002_add_model_CourseUserGroupPartitionGroup', '2015-08-07 16:32:45'),
(99, 'course_groups', '0003_auto__add_coursecohort__add_coursecohortssettings', '2015-08-07 16:32:45'),
(100, 'course_groups', '0004_auto__del_field_coursecohortssettings_cohorted_discussions__add_field_', '2015-08-07 16:32:45'),
(101, 'bulk_email', '0001_initial', '2015-08-07 16:32:46'),
(102, 'bulk_email', '0002_change_field_names', '2015-08-07 16:32:46'),
(103, 'bulk_email', '0003_add_optout_user', '2015-08-07 16:32:46'),
(104, 'bulk_email', '0004_migrate_optout_user', '2015-08-07 16:32:46'),
(105, 'bulk_email', '0005_remove_optout_email', '2015-08-07 16:32:46'),
(106, 'bulk_email', '0006_add_course_email_template', '2015-08-07 16:32:46'),
(107, 'bulk_email', '0007_load_course_email_template', '2015-08-07 16:32:46'),
(108, 'bulk_email', '0008_add_course_authorizations', '2015-08-07 16:32:46'),
(109, 'bulk_email', '0009_force_unique_course_ids', '2015-08-07 16:32:46'),
(110, 'bulk_email', '0010_auto__chg_field_optout_course_id__add_field_courseemail_template_name_', '2015-08-07 16:32:46'),
(111, 'branding', '0001_initial', '2015-08-07 16:32:47'),
(112, 'branding', '0002_auto__add_brandingapiconfig', '2015-08-07 16:32:47'),
(113, 'external_auth', '0001_initial', '2015-08-07 16:32:47'),
(114, 'oauth2', '0001_initial', '2015-08-07 16:32:48'),
(115, 'oauth2', '0002_auto__chg_field_client_user', '2015-08-07 16:32:48'),
(116, 'oauth2', '0003_auto__add_field_client_name', '2015-08-07 16:32:48'),
(117, 'oauth2', '0004_auto__add_index_accesstoken_token', '2015-08-07 16:32:48'),
(118, 'oauth2_provider', '0001_initial', '2015-08-07 16:32:48'),
(119, 'wiki', '0001_initial', '2015-08-07 16:32:50'),
(120, 'wiki', '0002_auto__add_field_articleplugin_created', '2015-08-07 16:32:50'),
(121, 'wiki', '0003_auto__add_field_urlpath_article', '2015-08-07 16:32:50'),
(122, 'wiki', '0004_populate_urlpath__article', '2015-08-07 16:32:50'),
(123, 'wiki', '0005_auto__chg_field_urlpath_article', '2015-08-07 16:32:50'),
(124, 'wiki', '0006_auto__add_attachmentrevision__add_image__add_attachment', '2015-08-07 16:32:50'),
(125, 'wiki', '0007_auto__add_articlesubscription', '2015-08-07 16:32:50'),
(126, 'wiki', '0008_auto__add_simpleplugin__add_revisionpluginrevision__add_imagerevision_', '2015-08-07 16:32:51'),
(127, 'wiki', '0009_auto__add_field_imagerevision_width__add_field_imagerevision_height', '2015-08-07 16:32:51'),
(128, 'wiki', '0010_auto__chg_field_imagerevision_image', '2015-08-07 16:32:51'),
(129, 'wiki', '0011_auto__chg_field_imagerevision_width__chg_field_imagerevision_height', '2015-08-07 16:32:51'),
(130, 'django_notify', '0001_initial', '2015-08-07 16:32:52'),
(131, 'notifications', '0001_initial', '2015-08-07 16:32:52'),
(132, 'foldit', '0001_initial', '2015-08-07 16:32:52'),
(133, 'django_comment_client', '0001_initial', '2015-08-07 16:32:53'),
(134, 'django_comment_common', '0001_initial', '2015-08-07 16:32:53'),
(135, 'notes', '0001_initial', '2015-08-07 16:32:53'),
(136, 'splash', '0001_initial', '2015-08-07 16:32:54'),
(137, 'splash', '0002_auto__add_field_splashconfig_unaffected_url_paths', '2015-08-07 16:32:54'),
(138, 'user_api', '0001_initial', '2015-08-07 16:32:54'),
(139, 'user_api', '0002_auto__add_usercoursetags__add_unique_usercoursetags_user_course_id_key', '2015-08-07 16:32:54'),
(140, 'user_api', '0003_rename_usercoursetags', '2015-08-07 16:32:54'),
(141, 'user_api', '0004_auto__add_userorgtag__add_unique_userorgtag_user_org_key__chg_field_us', '2015-08-07 16:32:54'),
(142, 'teams', '0001_initial', '2015-08-07 16:32:55'),
(143, 'shoppingcart', '0001_initial', '2015-08-07 16:32:55'),
(144, 'shoppingcart', '0002_auto__add_field_paidcourseregistration_mode', '2015-08-07 16:32:55'),
(145, 'shoppingcart', '0003_auto__del_field_orderitem_line_cost', '2015-08-07 16:32:55'),
(146, 'shoppingcart', '0004_auto__add_field_orderitem_fulfilled_time', '2015-08-07 16:32:55'),
(147, 'shoppingcart', '0005_auto__add_paidcourseregistrationannotation__add_field_orderitem_report', '2015-08-07 16:32:55'),
(148, 'shoppingcart', '0006_auto__add_field_order_refunded_time__add_field_orderitem_refund_reques', '2015-08-07 16:32:56'),
(149, 'shoppingcart', '0007_auto__add_field_orderitem_service_fee', '2015-08-07 16:32:56'),
(150, 'shoppingcart', '0008_auto__add_coupons__add_couponredemption__chg_field_certificateitem_cou', '2015-08-07 16:32:56'),
(151, 'shoppingcart', '0009_auto__del_coupons__add_courseregistrationcode__add_coupon__chg_field_c', '2015-08-07 16:32:57'),
(152, 'shoppingcart', '0010_auto__add_registrationcoderedemption__del_field_courseregistrationcode', '2015-08-07 16:32:57'),
(153, 'shoppingcart', '0011_auto__add_invoice__add_field_courseregistrationcode_invoice', '2015-08-07 16:32:57'),
(154, 'shoppingcart', '0012_auto__del_field_courseregistrationcode_transaction_group_name__del_fie', '2015-08-07 16:32:58'),
(155, 'shoppingcart', '0013_auto__add_field_invoice_is_valid', '2015-08-07 16:32:58'),
(156, 'shoppingcart', '0014_auto__del_field_invoice_tax_id__add_field_invoice_address_line_1__add_', '2015-08-07 16:32:59'),
(157, 'shoppingcart', '0015_auto__del_field_invoice_purchase_order_number__del_field_invoice_compa', '2015-08-07 16:32:59'),
(158, 'shoppingcart', '0016_auto__del_field_invoice_company_email__del_field_invoice_company_refer', '2015-08-07 16:32:59'),
(159, 'shoppingcart', '0017_auto__add_field_courseregistrationcode_order__chg_field_registrationco', '2015-08-07 16:33:00'),
(160, 'shoppingcart', '0018_auto__add_donation', '2015-08-07 16:33:00'),
(161, 'shoppingcart', '0019_auto__add_donationconfiguration', '2015-08-07 16:33:00'),
(162, 'shoppingcart', '0020_auto__add_courseregcodeitem__add_courseregcodeitemannotation__add_fiel', '2015-08-07 16:33:00'),
(163, 'shoppingcart', '0021_auto__add_field_orderitem_created__add_field_orderitem_modified', '2015-08-07 16:33:00'),
(164, 'shoppingcart', '0022_auto__add_field_registrationcoderedemption_course_enrollment__add_fiel', '2015-08-07 16:33:00'),
(165, 'shoppingcart', '0023_auto__add_field_coupon_expiration_date', '2015-08-07 16:33:01'),
(166, 'shoppingcart', '0024_auto__add_field_courseregistrationcode_mode_slug', '2015-08-07 16:33:01'),
(167, 'shoppingcart', '0025_update_invoice_models', '2015-08-07 16:33:01'),
(168, 'shoppingcart', '0026_migrate_invoices', '2015-08-07 16:33:01'),
(169, 'shoppingcart', '0027_add_invoice_history', '2015-08-07 16:33:01'),
(170, 'shoppingcart', '0028_auto__add_field_courseregistrationcode_is_valid', '2015-08-07 16:33:02'),
(171, 'course_modes', '0001_initial', '2015-08-07 16:33:02'),
(172, 'course_modes', '0002_auto__add_field_coursemode_currency', '2015-08-07 16:33:02'),
(173, 'course_modes', '0003_auto__add_unique_coursemode_course_id_currency_mode_slug', '2015-08-07 16:33:02'),
(174, 'course_modes', '0004_auto__add_field_coursemode_expiration_date', '2015-08-07 16:33:02'),
(175, 'course_modes', '0005_auto__add_field_coursemode_expiration_datetime', '2015-08-07 16:33:02'),
(176, 'course_modes', '0006_expiration_date_to_datetime', '2015-08-07 16:33:02'),
(177, 'course_modes', '0007_add_description', '2015-08-07 16:33:02'),
(178, 'course_modes', '0007_auto__add_coursemodesarchive__chg_field_coursemode_course_id', '2015-08-07 16:33:02'),
(179, 'course_modes', '0008_auto__del_field_coursemodesarchive_description__add_field_coursemode_s', '2015-08-07 16:33:02'),
(180, 'verify_student', '0001_initial', '2015-08-07 16:33:03'),
(181, 'verify_student', '0002_auto__add_field_softwaresecurephotoverification_window', '2015-08-07 16:33:03'),
(182, 'verify_student', '0003_auto__add_field_softwaresecurephotoverification_display', '2015-08-07 16:33:03'),
(183, 'verify_student', '0004_auto__add_verificationcheckpoint__add_unique_verificationcheckpoint_co', '2015-08-07 16:33:04'),
(184, 'verify_student', '0005_auto__add_incoursereverificationconfiguration', '2015-08-07 16:33:04'),
(185, 'verify_student', '0006_auto__add_skippedreverification__add_unique_skippedreverification_user', '2015-08-07 16:33:04'),
(186, 'verify_student', '0007_auto__add_field_verificationstatus_location_id', '2015-08-07 16:33:04'),
(187, 'verify_student', '0008_auto__del_field_verificationcheckpoint_checkpoint_name__add_field_veri', '2015-08-07 16:33:04'),
(188, 'verify_student', '0009_auto__change_softwaresecurephotoverification_window_id_default_none', '2015-08-07 16:33:04'),
(189, 'dark_lang', '0001_initial', '2015-08-07 16:33:04'),
(190, 'dark_lang', '0002_enable_on_install', '2015-08-07 16:33:04'),
(191, 'reverification', '0001_initial', '2015-08-07 16:33:05'),
(192, 'embargo', '0001_initial', '2015-08-07 16:33:05'),
(193, 'embargo', '0002_add_country_access_models', '2015-08-07 16:33:05'),
(194, 'embargo', '0003_add_countries', '2015-08-07 16:33:06'),
(195, 'embargo', '0004_migrate_embargo_config', '2015-08-07 16:33:06'),
(196, 'embargo', '0005_add_courseaccessrulehistory', '2015-08-07 16:33:06'),
(197, 'embargo', '0006_auto__add_field_restrictedcourse_disable_access_check', '2015-08-07 16:33:06'),
(198, 'course_action_state', '0001_initial', '2015-08-07 16:33:06'),
(199, 'course_action_state', '0002_add_rerun_display_name', '2015-08-07 16:33:06'),
(200, 'mobile_api', '0001_initial', '2015-08-07 16:33:06'),
(201, 'survey', '0001_initial', '2015-08-07 16:33:07'),
(202, 'lms_xblock', '0001_initial', '2015-08-07 16:33:07'),
(203, 'course_overviews', '0001_initial', '2015-08-07 16:33:07'),
(204, 'course_structures', '0001_initial', '2015-08-07 16:33:08'),
(205, 'cors_csrf', '0001_initial', '2015-08-07 16:33:08'),
(206, 'submissions', '0001_initial', '2015-08-07 16:33:09'),
(207, 'submissions', '0002_auto__add_scoresummary', '2015-08-07 16:33:09'),
(208, 'submissions', '0003_auto__del_field_submission_answer__add_field_submission_raw_answer', '2015-08-07 16:33:09'),
(209, 'submissions', '0004_auto__add_field_score_reset', '2015-08-07 16:33:09'),
(210, 'assessment', '0001_initial', '2015-08-07 16:33:10'),
(211, 'assessment', '0002_auto__add_assessmentfeedbackoption__del_field_assessmentfeedback_feedb', '2015-08-07 16:33:11'),
(212, 'assessment', '0003_add_index_pw_course_item_student', '2015-08-07 16:33:11'),
(213, 'assessment', '0004_auto__add_field_peerworkflow_graded_count', '2015-08-07 16:33:11'),
(214, 'assessment', '0005_auto__del_field_peerworkflow_graded_count__add_field_peerworkflow_grad', '2015-08-07 16:33:11'),
(215, 'assessment', '0006_auto__add_field_assessmentpart_feedback', '2015-08-07 16:33:11'),
(216, 'assessment', '0007_auto__chg_field_assessmentpart_feedback', '2015-08-07 16:33:11'),
(217, 'assessment', '0008_student_training', '2015-08-07 16:33:12'),
(218, 'assessment', '0009_auto__add_unique_studenttrainingworkflowitem_order_num_workflow', '2015-08-07 16:33:12'),
(219, 'assessment', '0010_auto__add_unique_studenttrainingworkflow_submission_uuid', '2015-08-07 16:33:12'),
(220, 'assessment', '0011_ai_training', '2015-08-07 16:33:13'),
(221, 'assessment', '0012_move_algorithm_id_to_classifier_set', '2015-08-07 16:33:13'),
(222, 'assessment', '0013_auto__add_field_aigradingworkflow_essay_text', '2015-08-07 16:33:13'),
(223, 'assessment', '0014_auto__add_field_aitrainingworkflow_item_id__add_field_aitrainingworkfl', '2015-08-07 16:33:14'),
(224, 'assessment', '0015_auto__add_unique_aitrainingworkflow_uuid__add_unique_aigradingworkflow', '2015-08-07 16:33:14'),
(225, 'assessment', '0016_auto__add_field_aiclassifierset_course_id__add_field_aiclassifierset_i', '2015-08-07 16:33:14'),
(226, 'assessment', '0016_auto__add_field_rubric_structure_hash', '2015-08-07 16:33:14'),
(227, 'assessment', '0017_rubric_structure_hash', '2015-08-07 16:33:14'),
(228, 'assessment', '0018_auto__add_field_assessmentpart_criterion', '2015-08-07 16:33:14'),
(229, 'assessment', '0019_assessmentpart_criterion_field', '2015-08-07 16:33:14'),
(230, 'assessment', '0020_assessmentpart_criterion_not_null', '2015-08-07 16:33:14'),
(231, 'assessment', '0021_assessmentpart_option_nullable', '2015-08-07 16:33:15'),
(232, 'assessment', '0022__add_label_fields', '2015-08-07 16:33:15'),
(233, 'assessment', '0023_assign_criteria_and_option_labels', '2015-08-07 16:33:15'),
(234, 'assessment', '0024_auto__chg_field_assessmentpart_criterion', '2015-08-07 16:33:15'),
(235, 'assessment', '0025_auto__add_field_peerworkflow_cancelled_at', '2015-08-07 16:33:15'),
(236, 'workflow', '0001_initial', '2015-08-07 16:33:15'),
(237, 'workflow', '0002_auto__add_field_assessmentworkflow_course_id__add_field_assessmentwork', '2015-08-07 16:33:15'),
(238, 'workflow', '0003_auto__add_assessmentworkflowstep', '2015-08-07 16:33:15'),
(239, 'workflow', '0004_auto__add_assessmentworkflowcancellation', '2015-08-07 16:33:16'),
(240, 'edxval', '0001_initial', '2015-08-07 16:33:16'),
(241, 'edxval', '0002_default_profiles', '2015-08-07 16:33:16'),
(242, 'edxval', '0003_status_and_created_fields', '2015-08-07 16:33:16'),
(243, 'edxval', '0004_remove_profile_fields', '2015-08-07 16:33:16'),
(244, 'milestones', '0001_initial', '2015-08-07 16:33:17'),
(245, 'milestones', '0002_seed_relationship_types', '2015-08-07 16:33:17'),
(246, 'credit', '0001_initial', '2015-08-07 16:33:18'),
(247, 'credit', '0002_rename_credit_requirement_criteria_field', '2015-08-07 16:33:18'),
(248, 'credit', '0003_add_creditrequirementstatus_reason', '2015-08-07 16:33:18'),
(249, 'credit', '0004_auto__add_field_creditrequirement_display_name', '2015-08-07 16:33:18'),
(250, 'credit', '0005_auto__add_field_creditprovider_provider_url__add_field_creditprovider_', '2015-08-07 16:33:19'),
(251, 'credit', '0006_auto__add_creditrequest__add_unique_creditrequest_username_course_prov', '2015-08-07 16:33:19'),
(252, 'credit', '0007_auto__add_field_creditprovider_enable_integration__chg_field_creditpro', '2015-08-07 16:33:19'),
(253, 'credit', '0008_delete_credit_provider_timestamp', '2015-08-07 16:33:20'),
(254, 'credit', '0009_auto__del_field_crediteligibility_provider', '2015-08-07 16:33:20'),
(255, 'credit', '0010_add_creditrequirementstatus_history', '2015-08-07 16:33:20'),
(256, 'credit', '0011_auto__add_field_creditrequirement_order', '2015-08-07 16:33:20'),
(257, 'credit', '0012_remove_m2m_course_and_provider', '2015-08-07 16:33:20'),
(258, 'credit', '0013_add_provider_status_url', '2015-08-07 16:33:20'),
(259, 'contentstore', '0001_initial', '2015-08-07 16:33:22'),
(260, 'contentstore', '0002_auto__del_field_videouploadconfig_status_whitelist', '2015-08-07 16:33:23'),
(261, 'contentstore', '0003_auto__add_pushnotificationconfig', '2015-08-07 16:33:23'),
(262, 'course_creators', '0001_initial', '2015-08-07 16:33:23'),
(263, 'xblock_config', '0001_initial', '2015-08-07 16:33:23');

-- --------------------------------------------------------

--
-- Структура таблицы `splash_splashconfig`
--

CREATE TABLE `splash_splashconfig` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `cookie_name` longtext NOT NULL,
  `cookie_allowed_values` longtext NOT NULL,
  `unaffected_usernames` longtext NOT NULL,
  `redirect_url` varchar(200) NOT NULL,
  `unaffected_url_paths` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `student_anonymoususerid`
--

CREATE TABLE `student_anonymoususerid` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `anonymous_user_id` varchar(32) NOT NULL,
  `course_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `student_anonymoususerid`
--

INSERT INTO `student_anonymoususerid` (`id`, `user_id`, `anonymous_user_id`, `course_id`) VALUES
(1, 5, 'e4da3b7fbbce2345d7772b0674a318d5', ''),
(2, 5, '7967e0b1df235021c493721ec2ef5829', 'course-v1:edX+DemoX+Demo_Course'),
(3, 4, 'a87ff679a2f3e71d9181a67b7542122c', ''),
(4, 4, '67493163c0cb0506332ea198c3d70e3c', 'course-v1:edX+DemoX+Demo_Course');

-- --------------------------------------------------------

--
-- Структура таблицы `student_courseaccessrole`
--

CREATE TABLE `student_courseaccessrole` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `org` varchar(64) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `role` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `student_courseaccessrole`
--

INSERT INTO `student_courseaccessrole` (`id`, `user_id`, `org`, `course_id`, `role`) VALUES
(1, 4, 'ITMO', 'course-v1:ITMO+1+today', 'instructor'),
(2, 4, 'ITMO', 'course-v1:ITMO+1+today', 'staff');

-- --------------------------------------------------------

--
-- Структура таблицы `student_courseenrollment`
--

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
(7, 4, 'course-v1:ITMO+1+today', '2016-04-18 14:24:22', 1, 'honor');

-- --------------------------------------------------------

--
-- Структура таблицы `student_courseenrollmentallowed`
--

CREATE TABLE `student_courseenrollmentallowed` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `created` datetime DEFAULT NULL,
  `auto_enroll` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `student_courseenrollmentattribute`
--

CREATE TABLE `student_courseenrollmentattribute` (
  `id` int(11) NOT NULL,
  `enrollment_id` int(11) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `student_dashboardconfiguration`
--

CREATE TABLE `student_dashboardconfiguration` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `recent_enrollment_time_delta` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `student_entranceexamconfiguration`
--

CREATE TABLE `student_entranceexamconfiguration` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime NOT NULL,
  `skip_entrance_exam` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `student_languageproficiency`
--

CREATE TABLE `student_languageproficiency` (
  `id` int(11) NOT NULL,
  `user_profile_id` int(11) NOT NULL,
  `code` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `student_languageproficiency`
--

INSERT INTO `student_languageproficiency` (`id`, `user_profile_id`, `code`) VALUES
(2, 5, 'ru');

-- --------------------------------------------------------

--
-- Структура таблицы `student_linkedinaddtoprofileconfiguration`
--

CREATE TABLE `student_linkedinaddtoprofileconfiguration` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `dashboard_tracking_code` longtext NOT NULL,
  `company_identifier` longtext NOT NULL,
  `trk_partner_name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `student_loginfailures`
--

CREATE TABLE `student_loginfailures` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `failure_count` int(11) NOT NULL,
  `lockout_until` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `student_manualenrollmentaudit`
--

CREATE TABLE `student_manualenrollmentaudit` (
  `id` int(11) NOT NULL,
  `enrollment_id` int(11) DEFAULT NULL,
  `enrolled_by_id` int(11) DEFAULT NULL,
  `enrolled_email` varchar(255) NOT NULL,
  `time_stamp` datetime DEFAULT NULL,
  `state_transition` varchar(255) NOT NULL,
  `reason` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `student_passwordhistory`
--

CREATE TABLE `student_passwordhistory` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `time_set` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `student_pendingemailchange`
--

CREATE TABLE `student_pendingemailchange` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `new_email` varchar(255) NOT NULL,
  `activation_key` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `student_pendingnamechange`
--

CREATE TABLE `student_pendingnamechange` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `new_name` varchar(255) NOT NULL,
  `rationale` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `student_usersignupsource`
--

CREATE TABLE `student_usersignupsource` (
  `id` int(11) NOT NULL,
  `site` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `student_userstanding`
--

CREATE TABLE `student_userstanding` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `account_status` varchar(31) NOT NULL,
  `changed_by_id` int(11) NOT NULL,
  `standing_last_changed_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `student_usertestgroup`
--

CREATE TABLE `student_usertestgroup` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `student_usertestgroup_users`
--

CREATE TABLE `student_usertestgroup_users` (
  `id` int(11) NOT NULL,
  `usertestgroup_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `submissions_score`
--

CREATE TABLE `submissions_score` (
  `id` int(11) NOT NULL,
  `student_item_id` int(11) NOT NULL,
  `submission_id` int(11) DEFAULT NULL,
  `points_earned` int(10) UNSIGNED NOT NULL,
  `points_possible` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL,
  `reset` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `submissions_scoresummary`
--

CREATE TABLE `submissions_scoresummary` (
  `id` int(11) NOT NULL,
  `student_item_id` int(11) NOT NULL,
  `highest_id` int(11) NOT NULL,
  `latest_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `submissions_studentitem`
--

CREATE TABLE `submissions_studentitem` (
  `id` int(11) NOT NULL,
  `student_id` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `item_id` varchar(255) NOT NULL,
  `item_type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `submissions_submission`
--

CREATE TABLE `submissions_submission` (
  `id` int(11) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `student_item_id` int(11) NOT NULL,
  `attempt_number` int(10) UNSIGNED NOT NULL,
  `submitted_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `raw_answer` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `survey_surveyanswer`
--

CREATE TABLE `survey_surveyanswer` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `form_id` int(11) NOT NULL,
  `field_name` varchar(255) NOT NULL,
  `field_value` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `survey_surveyform`
--

CREATE TABLE `survey_surveyform` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `form` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `teams_courseteam`
--

CREATE TABLE `teams_courseteam` (
  `id` int(11) NOT NULL,
  `team_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `topic_id` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  `description` varchar(300) NOT NULL,
  `country` varchar(2) NOT NULL,
  `language` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `teams_courseteammembership`
--

CREATE TABLE `teams_courseteammembership` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  `date_joined` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `track_trackinglog`
--

CREATE TABLE `track_trackinglog` (
  `id` int(11) NOT NULL,
  `dtcreated` datetime NOT NULL,
  `username` varchar(32) NOT NULL,
  `ip` varchar(32) NOT NULL,
  `event_source` varchar(32) NOT NULL,
  `event_type` varchar(512) NOT NULL,
  `event` longtext NOT NULL,
  `agent` varchar(256) NOT NULL,
  `page` varchar(512) DEFAULT NULL,
  `time` datetime NOT NULL,
  `host` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `user_api_usercoursetag`
--

CREATE TABLE `user_api_usercoursetag` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `key` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `value` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `user_api_userorgtag`
--

CREATE TABLE `user_api_userorgtag` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `key` varchar(255) NOT NULL,
  `org` varchar(255) NOT NULL,
  `value` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `user_api_userpreference`
--

CREATE TABLE `user_api_userpreference` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `user_api_userpreference`
--

INSERT INTO `user_api_userpreference` (`id`, `user_id`, `key`, `value`) VALUES
(1, 5, 'pref-lang', 'en'),
(2, 5, 'account_privacy', 'all_users'),
(3, 6, 'pref-lang', 'ru');

-- --------------------------------------------------------

--
-- Структура таблицы `util_ratelimitconfiguration`
--

CREATE TABLE `util_ratelimitconfiguration` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `util_ratelimitconfiguration`
--

INSERT INTO `util_ratelimitconfiguration` (`id`, `change_date`, `changed_by_id`, `enabled`) VALUES
(1, '2015-08-07 16:32:41', NULL, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `verify_student_incoursereverificationconfiguration`
--

CREATE TABLE `verify_student_incoursereverificationconfiguration` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `verify_student_skippedreverification`
--

CREATE TABLE `verify_student_skippedreverification` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `checkpoint_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `verify_student_softwaresecurephotoverification`
--

CREATE TABLE `verify_student_softwaresecurephotoverification` (
  `id` int(11) NOT NULL,
  `status` varchar(100) NOT NULL,
  `status_changed` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `face_image_url` varchar(255) NOT NULL,
  `photo_id_image_url` varchar(255) NOT NULL,
  `receipt_id` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `submitted_at` datetime DEFAULT NULL,
  `reviewing_user_id` int(11) DEFAULT NULL,
  `reviewing_service` varchar(255) NOT NULL,
  `error_msg` longtext NOT NULL,
  `error_code` varchar(50) NOT NULL,
  `photo_id_key` longtext NOT NULL,
  `window_id` int(11) DEFAULT NULL,
  `display` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `verify_student_verificationcheckpoint`
--

CREATE TABLE `verify_student_verificationcheckpoint` (
  `id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `checkpoint_location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `verify_student_verificationcheckpoint_photo_verification`
--

CREATE TABLE `verify_student_verificationcheckpoint_photo_verification` (
  `id` int(11) NOT NULL,
  `verificationcheckpoint_id` int(11) NOT NULL,
  `softwaresecurephotoverification_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `verify_student_verificationstatus`
--

CREATE TABLE `verify_student_verificationstatus` (
  `id` int(11) NOT NULL,
  `checkpoint_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` varchar(32) NOT NULL,
  `timestamp` datetime NOT NULL,
  `response` longtext,
  `error` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `wiki_article`
--

CREATE TABLE `wiki_article` (
  `id` int(11) NOT NULL,
  `current_revision_id` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `group_read` tinyint(1) NOT NULL,
  `group_write` tinyint(1) NOT NULL,
  `other_read` tinyint(1) NOT NULL,
  `other_write` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `wiki_article`
--

INSERT INTO `wiki_article` (`id`, `current_revision_id`, `created`, `modified`, `owner_id`, `group_id`, `group_read`, `group_write`, `other_read`, `other_write`) VALUES
(1, 1, '2016-04-18 14:21:24', '2016-04-18 14:21:24', NULL, NULL, 1, 0, 1, 0),
(2, 2, '2016-04-18 14:21:24', '2016-04-18 14:21:24', NULL, NULL, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `wiki_articleforobject`
--

CREATE TABLE `wiki_articleforobject` (
  `id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `object_id` int(10) UNSIGNED NOT NULL,
  `is_mptt` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `wiki_articleforobject`
--

INSERT INTO `wiki_articleforobject` (`id`, `article_id`, `content_type_id`, `object_id`, `is_mptt`) VALUES
(1, 1, 84, 1, 1),
(2, 2, 84, 2, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `wiki_articleplugin`
--

CREATE TABLE `wiki_articleplugin` (
  `id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `wiki_articlerevision`
--

CREATE TABLE `wiki_articlerevision` (
  `id` int(11) NOT NULL,
  `revision_number` int(11) NOT NULL,
  `user_message` longtext NOT NULL,
  `automatic_log` longtext NOT NULL,
  `ip_address` char(15) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `modified` datetime NOT NULL,
  `created` datetime NOT NULL,
  `previous_revision_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  `locked` tinyint(1) NOT NULL,
  `article_id` int(11) NOT NULL,
  `content` longtext NOT NULL,
  `title` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `wiki_articlerevision`
--

INSERT INTO `wiki_articlerevision` (`id`, `revision_number`, `user_message`, `automatic_log`, `ip_address`, `user_id`, `modified`, `created`, `previous_revision_id`, `deleted`, `locked`, `article_id`, `content`, `title`) VALUES
(1, 1, '', '', NULL, NULL, '2016-04-18 14:21:24', '2016-04-18 14:21:24', NULL, 0, 0, 1, 'Welcome to the Your Platform Name Here Wiki\n===\nVisit a course wiki to add an article.', 'Wiki'),
(2, 1, 'Course page automatically created.', '', NULL, NULL, '2016-04-18 14:21:24', '2016-04-18 14:21:24', NULL, 0, 0, 2, 'This is the wiki for **edX**''s _edX Demonstration Course_.', 'edX.DemoX.Demo_Course');

-- --------------------------------------------------------

--
-- Структура таблицы `wiki_articlesubscription`
--

CREATE TABLE `wiki_articlesubscription` (
  `subscription_ptr_id` int(11) NOT NULL,
  `articleplugin_ptr_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `wiki_attachment`
--

CREATE TABLE `wiki_attachment` (
  `reusableplugin_ptr_id` int(11) NOT NULL,
  `current_revision_id` int(11) DEFAULT NULL,
  `original_filename` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `wiki_attachmentrevision`
--

CREATE TABLE `wiki_attachmentrevision` (
  `id` int(11) NOT NULL,
  `revision_number` int(11) NOT NULL,
  `user_message` longtext NOT NULL,
  `automatic_log` longtext NOT NULL,
  `ip_address` char(15) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `modified` datetime NOT NULL,
  `created` datetime NOT NULL,
  `previous_revision_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  `locked` tinyint(1) NOT NULL,
  `attachment_id` int(11) NOT NULL,
  `file` varchar(100) NOT NULL,
  `description` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `wiki_image`
--

CREATE TABLE `wiki_image` (
  `revisionplugin_ptr_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `wiki_imagerevision`
--

CREATE TABLE `wiki_imagerevision` (
  `revisionpluginrevision_ptr_id` int(11) NOT NULL,
  `image` varchar(2000) DEFAULT NULL,
  `width` smallint(6) DEFAULT NULL,
  `height` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `wiki_reusableplugin`
--

CREATE TABLE `wiki_reusableplugin` (
  `articleplugin_ptr_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `wiki_reusableplugin_articles`
--

CREATE TABLE `wiki_reusableplugin_articles` (
  `id` int(11) NOT NULL,
  `reusableplugin_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `wiki_revisionplugin`
--

CREATE TABLE `wiki_revisionplugin` (
  `articleplugin_ptr_id` int(11) NOT NULL,
  `current_revision_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `wiki_revisionpluginrevision`
--

CREATE TABLE `wiki_revisionpluginrevision` (
  `id` int(11) NOT NULL,
  `revision_number` int(11) NOT NULL,
  `user_message` longtext NOT NULL,
  `automatic_log` longtext NOT NULL,
  `ip_address` char(15) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `modified` datetime NOT NULL,
  `created` datetime NOT NULL,
  `previous_revision_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  `locked` tinyint(1) NOT NULL,
  `plugin_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `wiki_simpleplugin`
--

CREATE TABLE `wiki_simpleplugin` (
  `articleplugin_ptr_id` int(11) NOT NULL,
  `article_revision_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `wiki_urlpath`
--

CREATE TABLE `wiki_urlpath` (
  `id` int(11) NOT NULL,
  `slug` varchar(50) DEFAULT NULL,
  `site_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(10) UNSIGNED NOT NULL,
  `rght` int(10) UNSIGNED NOT NULL,
  `tree_id` int(10) UNSIGNED NOT NULL,
  `level` int(10) UNSIGNED NOT NULL,
  `article_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `wiki_urlpath`
--

INSERT INTO `wiki_urlpath` (`id`, `slug`, `site_id`, `parent_id`, `lft`, `rght`, `tree_id`, `level`, `article_id`) VALUES
(1, NULL, 1, NULL, 1, 4, 1, 0, 1),
(2, 'edX.DemoX.Demo_Course', 1, 1, 2, 3, 1, 1, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `workflow_assessmentworkflow`
--

CREATE TABLE `workflow_assessmentworkflow` (
  `id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `status` varchar(100) NOT NULL,
  `status_changed` datetime NOT NULL,
  `submission_uuid` varchar(36) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `item_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `workflow_assessmentworkflowcancellation`
--

CREATE TABLE `workflow_assessmentworkflowcancellation` (
  `id` int(11) NOT NULL,
  `workflow_id` int(11) NOT NULL,
  `comments` longtext NOT NULL,
  `cancelled_by_id` varchar(40) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `workflow_assessmentworkflowstep`
--

CREATE TABLE `workflow_assessmentworkflowstep` (
  `id` int(11) NOT NULL,
  `workflow_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `submitter_completed_at` datetime DEFAULT NULL,
  `assessment_completed_at` datetime DEFAULT NULL,
  `order_num` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `xblock_config_studioconfig`
--

CREATE TABLE `xblock_config_studioconfig` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `disabled_blocks` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `xblock_django_xblockdisableconfig`
--

CREATE TABLE `xblock_django_xblockdisableconfig` (
  `id` int(11) NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `disabled_blocks` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `assessment_aiclassifier`
--
ALTER TABLE `assessment_aiclassifier`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assessment_aiclassifier_714175dc` (`classifier_set_id`),
  ADD KEY `assessment_aiclassifier_a36470e4` (`criterion_id`);

--
-- Индексы таблицы `assessment_aiclassifierset`
--
ALTER TABLE `assessment_aiclassifierset`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assessment_aiclassifierset_27cb9807` (`rubric_id`),
  ADD KEY `assessment_aiclassifierset_3b1c9c31` (`created_at`),
  ADD KEY `assessment_aiclassifierset_53012c1e` (`algorithm_id`),
  ADD KEY `assessment_aiclassifierset_ff48d8e5` (`course_id`),
  ADD KEY `assessment_aiclassifierset_67b70d25` (`item_id`);

--
-- Индексы таблицы `assessment_aigradingworkflow`
--
ALTER TABLE `assessment_aigradingworkflow`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `assessment_aigradingworkflow_uuid_492e936265ecbfd2_uniq` (`uuid`),
  ADD KEY `assessment_aigradingworkflow_2bbc74ae` (`uuid`),
  ADD KEY `assessment_aigradingworkflow_4bacaa90` (`scheduled_at`),
  ADD KEY `assessment_aigradingworkflow_a2fd3af6` (`completed_at`),
  ADD KEY `assessment_aigradingworkflow_39d020e6` (`submission_uuid`),
  ADD KEY `assessment_aigradingworkflow_714175dc` (`classifier_set_id`),
  ADD KEY `assessment_aigradingworkflow_53012c1e` (`algorithm_id`),
  ADD KEY `assessment_aigradingworkflow_27cb9807` (`rubric_id`),
  ADD KEY `assessment_aigradingworkflow_c168f2dc` (`assessment_id`),
  ADD KEY `assessment_aigradingworkflow_42ff452e` (`student_id`),
  ADD KEY `assessment_aigradingworkflow_67b70d25` (`item_id`),
  ADD KEY `assessment_aigradingworkflow_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `assessment_aitrainingworkflow`
--
ALTER TABLE `assessment_aitrainingworkflow`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `assessment_aitrainingworkflow_uuid_284fdaa93019f8ef_uniq` (`uuid`),
  ADD KEY `assessment_aitrainingworkflow_2bbc74ae` (`uuid`),
  ADD KEY `assessment_aitrainingworkflow_53012c1e` (`algorithm_id`),
  ADD KEY `assessment_aitrainingworkflow_714175dc` (`classifier_set_id`),
  ADD KEY `assessment_aitrainingworkflow_4bacaa90` (`scheduled_at`),
  ADD KEY `assessment_aitrainingworkflow_a2fd3af6` (`completed_at`),
  ADD KEY `assessment_aitrainingworkflow_67b70d25` (`item_id`),
  ADD KEY `assessment_aitrainingworkflow_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `assessment_aitrainingworkflow_training_examples`
--
ALTER TABLE `assessment_aitrainingworkflow_training_examples`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `assessment_aitraini_aitrainingworkflow_id_4b50cfbece05470a_uniq` (`aitrainingworkflow_id`,`trainingexample_id`),
  ADD KEY `assessment_aitrainingworkflow_training_examples_a57f9195` (`aitrainingworkflow_id`),
  ADD KEY `assessment_aitrainingworkflow_training_examples_ea4da31f` (`trainingexample_id`);

--
-- Индексы таблицы `assessment_assessment`
--
ALTER TABLE `assessment_assessment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assessment_assessment_39d020e6` (`submission_uuid`),
  ADD KEY `assessment_assessment_27cb9807` (`rubric_id`),
  ADD KEY `assessment_assessment_3227200` (`scored_at`),
  ADD KEY `assessment_assessment_9f54855a` (`scorer_id`);

--
-- Индексы таблицы `assessment_assessmentfeedback`
--
ALTER TABLE `assessment_assessmentfeedback`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `submission_uuid` (`submission_uuid`);

--
-- Индексы таблицы `assessment_assessmentfeedbackoption`
--
ALTER TABLE `assessment_assessmentfeedbackoption`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `text` (`text`);

--
-- Индексы таблицы `assessment_assessmentfeedback_assessments`
--
ALTER TABLE `assessment_assessmentfeedback_assessments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `assessment_assessmen_assessmentfeedback_id_36925aaa1a839ac_uniq` (`assessmentfeedback_id`,`assessment_id`),
  ADD KEY `assessment_assessmentfeedback_assessments_58f1f0d` (`assessmentfeedback_id`),
  ADD KEY `assessment_assessmentfeedback_assessments_c168f2dc` (`assessment_id`);

--
-- Индексы таблицы `assessment_assessmentfeedback_options`
--
ALTER TABLE `assessment_assessmentfeedback_options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `assessment_assessmen_assessmentfeedback_id_14efc9eea8f4c83_uniq` (`assessmentfeedback_id`,`assessmentfeedbackoption_id`),
  ADD KEY `assessment_assessmentfeedback_options_58f1f0d` (`assessmentfeedback_id`),
  ADD KEY `assessment_assessmentfeedback_options_4e523d64` (`assessmentfeedbackoption_id`);

--
-- Индексы таблицы `assessment_assessmentpart`
--
ALTER TABLE `assessment_assessmentpart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assessment_assessmentpart_c168f2dc` (`assessment_id`),
  ADD KEY `assessment_assessmentpart_2f3b0dc9` (`option_id`),
  ADD KEY `assessment_assessmentpart_a36470e4` (`criterion_id`);

--
-- Индексы таблицы `assessment_criterion`
--
ALTER TABLE `assessment_criterion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assessment_criterion_27cb9807` (`rubric_id`);

--
-- Индексы таблицы `assessment_criterionoption`
--
ALTER TABLE `assessment_criterionoption`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assessment_criterionoption_a36470e4` (`criterion_id`);

--
-- Индексы таблицы `assessment_peerworkflow`
--
ALTER TABLE `assessment_peerworkflow`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `submission_uuid` (`submission_uuid`),
  ADD KEY `assessment_peerworkflow_42ff452e` (`student_id`),
  ADD KEY `assessment_peerworkflow_67b70d25` (`item_id`),
  ADD KEY `assessment_peerworkflow_ff48d8e5` (`course_id`),
  ADD KEY `assessment_peerworkflow_3b1c9c31` (`created_at`),
  ADD KEY `assessment_peerworkflow_a2fd3af6` (`completed_at`),
  ADD KEY `assessment_peerworkflow_course_id_5ca23fddca9b630d` (`course_id`,`item_id`,`student_id`),
  ADD KEY `assessment_peerworkflow_dcd62131` (`grading_completed_at`),
  ADD KEY `assessment_peerworkflow_853d09a8` (`cancelled_at`);

--
-- Индексы таблицы `assessment_peerworkflowitem`
--
ALTER TABLE `assessment_peerworkflowitem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assessment_peerworkflowitem_9f54855a` (`scorer_id`),
  ADD KEY `assessment_peerworkflowitem_cc846901` (`author_id`),
  ADD KEY `assessment_peerworkflowitem_39d020e6` (`submission_uuid`),
  ADD KEY `assessment_peerworkflowitem_d6e710e4` (`started_at`),
  ADD KEY `assessment_peerworkflowitem_c168f2dc` (`assessment_id`);

--
-- Индексы таблицы `assessment_rubric`
--
ALTER TABLE `assessment_rubric`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `content_hash` (`content_hash`),
  ADD KEY `assessment_rubric_36e74b05` (`structure_hash`);

--
-- Индексы таблицы `assessment_studenttrainingworkflow`
--
ALTER TABLE `assessment_studenttrainingworkflow`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `assessment_studenttrainin_submission_uuid_6d32c6477719d68f_uniq` (`submission_uuid`),
  ADD KEY `assessment_studenttrainingworkflow_39d020e6` (`submission_uuid`),
  ADD KEY `assessment_studenttrainingworkflow_42ff452e` (`student_id`),
  ADD KEY `assessment_studenttrainingworkflow_67b70d25` (`item_id`),
  ADD KEY `assessment_studenttrainingworkflow_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `assessment_studenttrainingworkflowitem`
--
ALTER TABLE `assessment_studenttrainingworkflowitem`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `assessment_studenttrainingworkf_order_num_1391289faa95b87c_uniq` (`order_num`,`workflow_id`),
  ADD KEY `assessment_studenttrainingworkflowitem_26cddbc7` (`workflow_id`),
  ADD KEY `assessment_studenttrainingworkflowitem_541d6663` (`training_example_id`);

--
-- Индексы таблицы `assessment_trainingexample`
--
ALTER TABLE `assessment_trainingexample`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `content_hash` (`content_hash`),
  ADD KEY `assessment_trainingexample_27cb9807` (`rubric_id`);

--
-- Индексы таблицы `assessment_trainingexample_options_selected`
--
ALTER TABLE `assessment_trainingexample_options_selected`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `assessment_trainingexa_trainingexample_id_60940991fb17d27d_uniq` (`trainingexample_id`,`criterionoption_id`),
  ADD KEY `assessment_trainingexample_options_selected_ea4da31f` (`trainingexample_id`),
  ADD KEY `assessment_trainingexample_options_selected_843fa247` (`criterionoption_id`);

--
-- Индексы таблицы `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индексы таблицы `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissions_bda51c3c` (`group_id`),
  ADD KEY `auth_group_permissions_1e014c8f` (`permission_id`);

--
-- Индексы таблицы `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  ADD KEY `auth_permission_e4470c6e` (`content_type_id`);

--
-- Индексы таблицы `auth_registration`
--
ALTER TABLE `auth_registration`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `activation_key` (`activation_key`);

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
-- Индексы таблицы `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_fbfc09f1` (`user_id`),
  ADD KEY `auth_user_groups_bda51c3c` (`group_id`);

--
-- Индексы таблицы `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permissions_fbfc09f1` (`user_id`),
  ADD KEY `auth_user_user_permissions_1e014c8f` (`permission_id`);

--
-- Индексы таблицы `branding_brandingapiconfig`
--
ALTER TABLE `branding_brandingapiconfig`
  ADD PRIMARY KEY (`id`),
  ADD KEY `branding_brandingapiconfig_16905482` (`changed_by_id`);

--
-- Индексы таблицы `branding_brandinginfoconfig`
--
ALTER TABLE `branding_brandinginfoconfig`
  ADD PRIMARY KEY (`id`),
  ADD KEY `branding_brandinginfoconfig_16905482` (`changed_by_id`);

--
-- Индексы таблицы `bulk_email_courseauthorization`
--
ALTER TABLE `bulk_email_courseauthorization`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bulk_email_courseauthorization_course_id_4f6cee675bf93275_uniq` (`course_id`),
  ADD KEY `bulk_email_courseauthorization_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `bulk_email_courseemail`
--
ALTER TABLE `bulk_email_courseemail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bulk_email_courseemail_901f59e9` (`sender_id`),
  ADD KEY `bulk_email_courseemail_36af87d1` (`slug`),
  ADD KEY `bulk_email_courseemail_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `bulk_email_courseemailtemplate`
--
ALTER TABLE `bulk_email_courseemailtemplate`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индексы таблицы `bulk_email_optout`
--
ALTER TABLE `bulk_email_optout`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bulk_email_optout_course_id_368f7519b2997e1a_uniq` (`course_id`,`user_id`),
  ADD KEY `bulk_email_optout_ff48d8e5` (`course_id`),
  ADD KEY `bulk_email_optout_fbfc09f1` (`user_id`);

--
-- Индексы таблицы `celery_taskmeta`
--
ALTER TABLE `celery_taskmeta`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `task_id` (`task_id`),
  ADD KEY `celery_taskmeta_c91f1bf` (`hidden`);

--
-- Индексы таблицы `celery_tasksetmeta`
--
ALTER TABLE `celery_tasksetmeta`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `taskset_id` (`taskset_id`),
  ADD KEY `celery_tasksetmeta_c91f1bf` (`hidden`);

--
-- Индексы таблицы `certificates_badgeassertion`
--
ALTER TABLE `certificates_badgeassertion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `certificates_badgeassertion_course_id_f465e63872f731f_uniq` (`course_id`,`user_id`),
  ADD KEY `certificates_badgeassertion_fbfc09f1` (`user_id`);

--
-- Индексы таблицы `certificates_badgeimageconfiguration`
--
ALTER TABLE `certificates_badgeimageconfiguration`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mode` (`mode`);

--
-- Индексы таблицы `certificates_certificategenerationconfiguration`
--
ALTER TABLE `certificates_certificategenerationconfiguration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `certificates_certificategenerationconfiguration_16905482` (`changed_by_id`);

--
-- Индексы таблицы `certificates_certificategenerationcoursesetting`
--
ALTER TABLE `certificates_certificategenerationcoursesetting`
  ADD PRIMARY KEY (`id`),
  ADD KEY `certificates_certificategenerationcoursesetting_b4b47e7a` (`course_key`);

--
-- Индексы таблицы `certificates_certificatehtmlviewconfiguration`
--
ALTER TABLE `certificates_certificatehtmlviewconfiguration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `certificates_certificatehtmlviewconfiguration_16905482` (`changed_by_id`);

--
-- Индексы таблицы `certificates_certificatewhitelist`
--
ALTER TABLE `certificates_certificatewhitelist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `certificates_certificatewhitelist_fbfc09f1` (`user_id`);

--
-- Индексы таблицы `certificates_examplecertificate`
--
ALTER TABLE `certificates_examplecertificate`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `certificates_examplecertificate_uuid_183b9188451b331e` (`uuid`,`access_key`),
  ADD KEY `certificates_examplecertificate_3b9264a` (`example_cert_set_id`),
  ADD KEY `certificates_examplecertificate_752852c3` (`access_key`);

--
-- Индексы таблицы `certificates_examplecertificateset`
--
ALTER TABLE `certificates_examplecertificateset`
  ADD PRIMARY KEY (`id`),
  ADD KEY `certificates_examplecertificateset_b4b47e7a` (`course_key`);

--
-- Индексы таблицы `certificates_generatedcertificate`
--
ALTER TABLE `certificates_generatedcertificate`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `certificates_generatedcertifica_course_id_1389f6b2d72f5e78_uniq` (`course_id`,`user_id`),
  ADD KEY `certificates_generatedcertificate_fbfc09f1` (`user_id`);

--
-- Индексы таблицы `circuit_servercircuit`
--
ALTER TABLE `circuit_servercircuit`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индексы таблицы `contentstore_pushnotificationconfig`
--
ALTER TABLE `contentstore_pushnotificationconfig`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contentstore_pushnotificationconfig_16905482` (`changed_by_id`);

--
-- Индексы таблицы `contentstore_videouploadconfig`
--
ALTER TABLE `contentstore_videouploadconfig`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contentstore_videouploadconfig_16905482` (`changed_by_id`);

--
-- Индексы таблицы `corsheaders_corsmodel`
--
ALTER TABLE `corsheaders_corsmodel`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cors_csrf_xdomainproxyconfiguration`
--
ALTER TABLE `cors_csrf_xdomainproxyconfiguration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cors_csrf_xdomainproxyconfiguration_16905482` (`changed_by_id`);

--
-- Индексы таблицы `courseware_offlinecomputedgrade`
--
ALTER TABLE `courseware_offlinecomputedgrade`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `courseware_offlinecomputedgrade_user_id_46133bbd0926078f_uniq` (`user_id`,`course_id`),
  ADD KEY `courseware_offlinecomputedgrade_fbfc09f1` (`user_id`),
  ADD KEY `courseware_offlinecomputedgrade_ff48d8e5` (`course_id`),
  ADD KEY `courseware_offlinecomputedgrade_3216ff68` (`created`),
  ADD KEY `courseware_offlinecomputedgrade_8aac229` (`updated`);

--
-- Индексы таблицы `courseware_offlinecomputedgradelog`
--
ALTER TABLE `courseware_offlinecomputedgradelog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `courseware_offlinecomputedgradelog_ff48d8e5` (`course_id`),
  ADD KEY `courseware_offlinecomputedgradelog_3216ff68` (`created`);

--
-- Индексы таблицы `courseware_studentfieldoverride`
--
ALTER TABLE `courseware_studentfieldoverride`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `courseware_studentfieldoverride_course_id_39dd7eaeac5623d2_uniq` (`course_id`,`field`,`location`,`student_id`),
  ADD KEY `courseware_studentfieldoverride_ff48d8e5` (`course_id`),
  ADD KEY `courseware_studentfieldoverride_b54954de` (`location`),
  ADD KEY `courseware_studentfieldoverride_42ff452e` (`student_id`),
  ADD KEY `courseware_studentfieldoverride_course_id_344e77afe4983e04` (`course_id`,`location`,`student_id`);

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
-- Индексы таблицы `courseware_studentmodulehistory`
--
ALTER TABLE `courseware_studentmodulehistory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `courseware_studentmodulehistory_5656f5fe` (`student_module_id`),
  ADD KEY `courseware_studentmodulehistory_659105e4` (`version`),
  ADD KEY `courseware_studentmodulehistory_3216ff68` (`created`);

--
-- Индексы таблицы `courseware_xmodulestudentinfofield`
--
ALTER TABLE `courseware_xmodulestudentinfofield`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `courseware_xmodulestudentinfof_student_id_33f2f772c49db067_uniq` (`student_id`,`field_name`),
  ADD KEY `courseware_xmodulestudentinfofield_7e1499` (`field_name`),
  ADD KEY `courseware_xmodulestudentinfofield_42ff452e` (`student_id`),
  ADD KEY `courseware_xmodulestudentinfofield_3216ff68` (`created`),
  ADD KEY `courseware_xmodulestudentinfofield_5436e97a` (`modified`);

--
-- Индексы таблицы `courseware_xmodulestudentprefsfield`
--
ALTER TABLE `courseware_xmodulestudentprefsfield`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `courseware_xmodulestudentprefs_student_id_2a5d275498b7a407_uniq` (`student_id`,`module_type`,`field_name`),
  ADD KEY `courseware_xmodulestudentprefsfield_7e1499` (`field_name`),
  ADD KEY `courseware_xmodulestudentprefsfield_2d8768ff` (`module_type`),
  ADD KEY `courseware_xmodulestudentprefsfield_42ff452e` (`student_id`),
  ADD KEY `courseware_xmodulestudentprefsfield_3216ff68` (`created`),
  ADD KEY `courseware_xmodulestudentprefsfield_5436e97a` (`modified`);

--
-- Индексы таблицы `courseware_xmoduleuserstatesummaryfield`
--
ALTER TABLE `courseware_xmoduleuserstatesummaryfield`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `courseware_xmodulecontentfi_definition_id_50fa4fd570cf2f4a_uniq` (`usage_id`,`field_name`),
  ADD KEY `courseware_xmodulecontentfield_7e1499` (`field_name`),
  ADD KEY `courseware_xmodulecontentfield_1d304ded` (`usage_id`),
  ADD KEY `courseware_xmodulecontentfield_3216ff68` (`created`),
  ADD KEY `courseware_xmodulecontentfield_5436e97a` (`modified`);

--
-- Индексы таблицы `course_action_state_coursererunstate`
--
ALTER TABLE `course_action_state_coursererunstate`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_action_state_coursererun_course_key_cf5da77ed3032d6_uniq` (`course_key`,`action`),
  ADD KEY `course_action_state_coursererunstate_5b876fa2` (`created_user_id`),
  ADD KEY `course_action_state_coursererunstate_ceb2e2e7` (`updated_user_id`),
  ADD KEY `course_action_state_coursererunstate_b4b47e7a` (`course_key`),
  ADD KEY `course_action_state_coursererunstate_1bd4707b` (`action`),
  ADD KEY `course_action_state_coursererunstate_ebfe36dd` (`source_course_key`);

--
-- Индексы таблицы `course_creators_coursecreator`
--
ALTER TABLE `course_creators_coursecreator`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Индексы таблицы `course_groups_coursecohort`
--
ALTER TABLE `course_groups_coursecohort`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_user_group_id` (`course_user_group_id`);

--
-- Индексы таблицы `course_groups_coursecohortssettings`
--
ALTER TABLE `course_groups_coursecohortssettings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_id` (`course_id`);

--
-- Индексы таблицы `course_groups_courseusergroup`
--
ALTER TABLE `course_groups_courseusergroup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_groups_courseusergroup_name_63f7511804c52f38_uniq` (`name`,`course_id`),
  ADD KEY `course_groups_courseusergroup_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `course_groups_courseusergrouppartitiongroup`
--
ALTER TABLE `course_groups_courseusergrouppartitiongroup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_user_group_id` (`course_user_group_id`);

--
-- Индексы таблицы `course_groups_courseusergroup_users`
--
ALTER TABLE `course_groups_courseusergroup_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_groups_courseus_courseusergroup_id_46691806058983eb_uniq` (`courseusergroup_id`,`user_id`),
  ADD KEY `course_groups_courseusergroup_users_caee1c64` (`courseusergroup_id`),
  ADD KEY `course_groups_courseusergroup_users_fbfc09f1` (`user_id`);

--
-- Индексы таблицы `course_modes_coursemode`
--
ALTER TABLE `course_modes_coursemode`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_modes_coursemode_course_id_69505c92fc09856_uniq` (`course_id`,`currency`,`mode_slug`),
  ADD KEY `course_modes_coursemode_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `course_modes_coursemodesarchive`
--
ALTER TABLE `course_modes_coursemodesarchive`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_modes_coursemodesarchive_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `course_overviews_courseoverview`
--
ALTER TABLE `course_overviews_courseoverview`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `course_structures_coursestructure`
--
ALTER TABLE `course_structures_coursestructure`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_id` (`course_id`);

--
-- Индексы таблицы `credit_creditcourse`
--
ALTER TABLE `credit_creditcourse`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_key` (`course_key`);

--
-- Индексы таблицы `credit_crediteligibility`
--
ALTER TABLE `credit_crediteligibility`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `credit_crediteligibility_username_936cb16677e83e_uniq` (`username`,`course_id`),
  ADD KEY `credit_crediteligibility_f774835d` (`username`),
  ADD KEY `credit_crediteligibility_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `credit_creditprovider`
--
ALTER TABLE `credit_creditprovider`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `provider_id` (`provider_id`);

--
-- Индексы таблицы `credit_creditrequest`
--
ALTER TABLE `credit_creditrequest`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD UNIQUE KEY `credit_creditrequest_username_4f61c10bb0d67c01_uniq` (`username`,`course_id`,`provider_id`),
  ADD KEY `credit_creditrequest_f774835d` (`username`),
  ADD KEY `credit_creditrequest_ff48d8e5` (`course_id`),
  ADD KEY `credit_creditrequest_d9e5df97` (`provider_id`);

--
-- Индексы таблицы `credit_creditrequirement`
--
ALTER TABLE `credit_creditrequirement`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `credit_creditrequirement_namespace_33039c83b3e69b8_uniq` (`namespace`,`name`,`course_id`),
  ADD KEY `credit_creditrequirement_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `credit_creditrequirementstatus`
--
ALTER TABLE `credit_creditrequirementstatus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `credit_creditrequirementstatus_username_67dcb69ebf779e3b_uniq` (`username`,`requirement_id`),
  ADD KEY `credit_creditrequirementstatus_f774835d` (`username`),
  ADD KEY `credit_creditrequirementstatus_99a85f32` (`requirement_id`);

--
-- Индексы таблицы `credit_historicalcreditrequest`
--
ALTER TABLE `credit_historicalcreditrequest`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `credit_historicalcreditrequest_4a5fc416` (`id`),
  ADD KEY `credit_historicalcreditrequest_2bbc74ae` (`uuid`),
  ADD KEY `credit_historicalcreditrequest_f774835d` (`username`),
  ADD KEY `credit_historicalcreditrequest_ff48d8e5` (`course_id`),
  ADD KEY `credit_historicalcreditrequest_d9e5df97` (`provider_id`),
  ADD KEY `credit_historicalcreditrequest_e1a0ea2a` (`history_user_id`);

--
-- Индексы таблицы `credit_historicalcreditrequirementstatus`
--
ALTER TABLE `credit_historicalcreditrequirementstatus`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `credit_historicalcreditrequirementstatus_4a5fc416` (`id`),
  ADD KEY `credit_historicalcreditrequirementstatus_f774835d` (`username`),
  ADD KEY `credit_historicalcreditrequirementstatus_99a85f32` (`requirement_id`),
  ADD KEY `credit_historicalcreditrequirementstatus_e1a0ea2a` (`history_user_id`);

--
-- Индексы таблицы `dark_lang_darklangconfig`
--
ALTER TABLE `dark_lang_darklangconfig`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dark_lang_darklangconfig_16905482` (`changed_by_id`);

--
-- Индексы таблицы `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_fbfc09f1` (`user_id`),
  ADD KEY `django_admin_log_e4470c6e` (`content_type_id`);

--
-- Индексы таблицы `django_comment_client_permission`
--
ALTER TABLE `django_comment_client_permission`
  ADD PRIMARY KEY (`name`);

--
-- Индексы таблицы `django_comment_client_permission_roles`
--
ALTER TABLE `django_comment_client_permission_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_comment_client_permi_permission_id_7a766da089425952_uniq` (`permission_id`,`role_id`),
  ADD KEY `django_comment_client_permission_roles_1e014c8f` (`permission_id`),
  ADD KEY `django_comment_client_permission_roles_bf07f040` (`role_id`);

--
-- Индексы таблицы `django_comment_client_role`
--
ALTER TABLE `django_comment_client_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_comment_client_role_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `django_comment_client_role_users`
--
ALTER TABLE `django_comment_client_role_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_comment_client_role_users_role_id_78e483f531943614_uniq` (`role_id`,`user_id`),
  ADD KEY `django_comment_client_role_users_bf07f040` (`role_id`),
  ADD KEY `django_comment_client_role_users_fbfc09f1` (`user_id`);

--
-- Индексы таблицы `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_label` (`app_label`,`model`);

--
-- Индексы таблицы `django_openid_auth_association`
--
ALTER TABLE `django_openid_auth_association`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `django_openid_auth_nonce`
--
ALTER TABLE `django_openid_auth_nonce`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `django_openid_auth_useropenid`
--
ALTER TABLE `django_openid_auth_useropenid`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_openid_auth_useropenid_fbfc09f1` (`user_id`);

--
-- Индексы таблицы `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_c25c2c28` (`expire_date`);

--
-- Индексы таблицы `django_site`
--
ALTER TABLE `django_site`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `djcelery_crontabschedule`
--
ALTER TABLE `djcelery_crontabschedule`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `djcelery_intervalschedule`
--
ALTER TABLE `djcelery_intervalschedule`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `djcelery_periodictask`
--
ALTER TABLE `djcelery_periodictask`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `djcelery_periodictask_17d2d99d` (`interval_id`),
  ADD KEY `djcelery_periodictask_7aa5fda` (`crontab_id`);

--
-- Индексы таблицы `djcelery_periodictasks`
--
ALTER TABLE `djcelery_periodictasks`
  ADD PRIMARY KEY (`ident`);

--
-- Индексы таблицы `djcelery_taskstate`
--
ALTER TABLE `djcelery_taskstate`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `task_id` (`task_id`),
  ADD KEY `djcelery_taskstate_355bfc27` (`state`),
  ADD KEY `djcelery_taskstate_52094d6e` (`name`),
  ADD KEY `djcelery_taskstate_f0ba6500` (`tstamp`),
  ADD KEY `djcelery_taskstate_20fc5b84` (`worker_id`),
  ADD KEY `djcelery_taskstate_c91f1bf` (`hidden`);

--
-- Индексы таблицы `djcelery_workerstate`
--
ALTER TABLE `djcelery_workerstate`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `hostname` (`hostname`),
  ADD KEY `djcelery_workerstate_eb8ac7e4` (`last_heartbeat`);

--
-- Индексы таблицы `edxval_coursevideo`
--
ALTER TABLE `edxval_coursevideo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `edxval_coursevideo_course_id_42cecee05cff2d8c_uniq` (`course_id`,`video_id`),
  ADD KEY `edxval_coursevideo_fa26288c` (`video_id`);

--
-- Индексы таблицы `edxval_encodedvideo`
--
ALTER TABLE `edxval_encodedvideo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `edxval_encodedvideo_141c6eec` (`profile_id`),
  ADD KEY `edxval_encodedvideo_fa26288c` (`video_id`);

--
-- Индексы таблицы `edxval_profile`
--
ALTER TABLE `edxval_profile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `profile_name` (`profile_name`);

--
-- Индексы таблицы `edxval_subtitle`
--
ALTER TABLE `edxval_subtitle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `edxval_subtitle_fa26288c` (`video_id`),
  ADD KEY `edxval_subtitle_306df28f` (`fmt`),
  ADD KEY `edxval_subtitle_8a7ac9ab` (`language`);

--
-- Индексы таблицы `edxval_video`
--
ALTER TABLE `edxval_video`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `edx_video_id` (`edx_video_id`),
  ADD KEY `edxval_video_de3f5709` (`client_video_id`),
  ADD KEY `edxval_video_c9ad71dd` (`status`);

--
-- Индексы таблицы `embargo_country`
--
ALTER TABLE `embargo_country`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `country` (`country`);

--
-- Индексы таблицы `embargo_countryaccessrule`
--
ALTER TABLE `embargo_countryaccessrule`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `embargo_countryacces_restricted_course_id_6f340c36c633cb0a_uniq` (`restricted_course_id`,`country_id`),
  ADD KEY `embargo_countryaccessrule_3cd064f4` (`restricted_course_id`),
  ADD KEY `embargo_countryaccessrule_534dd89` (`country_id`);

--
-- Индексы таблицы `embargo_courseaccessrulehistory`
--
ALTER TABLE `embargo_courseaccessrulehistory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `embargo_courseaccessrulehistory_67f1b7ce` (`timestamp`),
  ADD KEY `embargo_courseaccessrulehistory_b4b47e7a` (`course_key`);

--
-- Индексы таблицы `embargo_embargoedcourse`
--
ALTER TABLE `embargo_embargoedcourse`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_id` (`course_id`);

--
-- Индексы таблицы `embargo_embargoedstate`
--
ALTER TABLE `embargo_embargoedstate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `embargo_embargoedstate_16905482` (`changed_by_id`);

--
-- Индексы таблицы `embargo_ipfilter`
--
ALTER TABLE `embargo_ipfilter`
  ADD PRIMARY KEY (`id`),
  ADD KEY `embargo_ipfilter_16905482` (`changed_by_id`);

--
-- Индексы таблицы `embargo_restrictedcourse`
--
ALTER TABLE `embargo_restrictedcourse`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_key` (`course_key`);

--
-- Индексы таблицы `external_auth_externalauthmap`
--
ALTER TABLE `external_auth_externalauthmap`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `external_auth_externalauthmap_external_id_7f035ef8bc4d313e_uniq` (`external_id`,`external_domain`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `external_auth_externalauthmap_d5e787` (`external_id`),
  ADD KEY `external_auth_externalauthmap_a570024c` (`external_domain`),
  ADD KEY `external_auth_externalauthmap_a142061d` (`external_email`),
  ADD KEY `external_auth_externalauthmap_c1a016f` (`external_name`);

--
-- Индексы таблицы `foldit_puzzlecomplete`
--
ALTER TABLE `foldit_puzzlecomplete`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `foldit_puzzlecomplete_user_id_4c63656af6674331_uniq` (`user_id`,`puzzle_id`,`puzzle_set`,`puzzle_subset`),
  ADD KEY `foldit_puzzlecomplete_fbfc09f1` (`user_id`),
  ADD KEY `foldit_puzzlecomplete_8027477e` (`unique_user_id`),
  ADD KEY `foldit_puzzlecomplete_4798a2b8` (`puzzle_set`),
  ADD KEY `foldit_puzzlecomplete_59f06bcd` (`puzzle_subset`);

--
-- Индексы таблицы `foldit_score`
--
ALTER TABLE `foldit_score`
  ADD PRIMARY KEY (`id`),
  ADD KEY `foldit_score_fbfc09f1` (`user_id`),
  ADD KEY `foldit_score_8027477e` (`unique_user_id`),
  ADD KEY `foldit_score_3624c060` (`best_score`),
  ADD KEY `foldit_score_b4627792` (`current_score`);

--
-- Индексы таблицы `instructor_task_instructortask`
--
ALTER TABLE `instructor_task_instructortask`
  ADD PRIMARY KEY (`id`),
  ADD KEY `instructor_task_instructortask_8ae638b4` (`task_type`),
  ADD KEY `instructor_task_instructortask_ff48d8e5` (`course_id`),
  ADD KEY `instructor_task_instructortask_cfc55170` (`task_key`),
  ADD KEY `instructor_task_instructortask_c00fe455` (`task_id`),
  ADD KEY `instructor_task_instructortask_731e67a4` (`task_state`),
  ADD KEY `instructor_task_instructortask_b8ca8b9f` (`requester_id`);

--
-- Индексы таблицы `licenses_coursesoftware`
--
ALTER TABLE `licenses_coursesoftware`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `licenses_userlicense`
--
ALTER TABLE `licenses_userlicense`
  ADD PRIMARY KEY (`id`),
  ADD KEY `licenses_userlicense_4c6ed3c1` (`software_id`),
  ADD KEY `licenses_userlicense_fbfc09f1` (`user_id`);

--
-- Индексы таблицы `lms_xblock_xblockasidesconfig`
--
ALTER TABLE `lms_xblock_xblockasidesconfig`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lms_xblock_xblockasidesconfig_16905482` (`changed_by_id`);

--
-- Индексы таблицы `milestones_coursecontentmilestone`
--
ALTER TABLE `milestones_coursecontentmilestone`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `milestones_coursecontentmilesto_course_id_68d1457cd52d6dff_uniq` (`course_id`,`content_id`,`milestone_id`),
  ADD KEY `milestones_coursecontentmilestone_ff48d8e5` (`course_id`),
  ADD KEY `milestones_coursecontentmilestone_cc8ff3c` (`content_id`),
  ADD KEY `milestones_coursecontentmilestone_9cfa291f` (`milestone_id`),
  ADD KEY `milestones_coursecontentmilestone_595c57ff` (`milestone_relationship_type_id`);

--
-- Индексы таблицы `milestones_coursemilestone`
--
ALTER TABLE `milestones_coursemilestone`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `milestones_coursemilestone_course_id_5a06e10579eab3b7_uniq` (`course_id`,`milestone_id`),
  ADD KEY `milestones_coursemilestone_ff48d8e5` (`course_id`),
  ADD KEY `milestones_coursemilestone_9cfa291f` (`milestone_id`),
  ADD KEY `milestones_coursemilestone_595c57ff` (`milestone_relationship_type_id`);

--
-- Индексы таблицы `milestones_milestone`
--
ALTER TABLE `milestones_milestone`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `milestones_milestone_namespace_460a2f6943016c0b_uniq` (`namespace`,`name`),
  ADD KEY `milestones_milestone_eb040977` (`namespace`),
  ADD KEY `milestones_milestone_52094d6e` (`name`);

--
-- Индексы таблицы `milestones_milestonerelationshiptype`
--
ALTER TABLE `milestones_milestonerelationshiptype`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индексы таблицы `milestones_usermilestone`
--
ALTER TABLE `milestones_usermilestone`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `milestones_usermilestone_user_id_10206aa452468351_uniq` (`user_id`,`milestone_id`),
  ADD KEY `milestones_usermilestone_fbfc09f1` (`user_id`),
  ADD KEY `milestones_usermilestone_9cfa291f` (`milestone_id`);

--
-- Индексы таблицы `mobile_api_mobileapiconfig`
--
ALTER TABLE `mobile_api_mobileapiconfig`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mobile_api_mobileapiconfig_16905482` (`changed_by_id`);

--
-- Индексы таблицы `notes_note`
--
ALTER TABLE `notes_note`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notes_note_fbfc09f1` (`user_id`),
  ADD KEY `notes_note_ff48d8e5` (`course_id`),
  ADD KEY `notes_note_a9794fa` (`uri`),
  ADD KEY `notes_note_3216ff68` (`created`),
  ADD KEY `notes_note_8aac229` (`updated`);

--
-- Индексы таблицы `notifications_articlesubscription`
--
ALTER TABLE `notifications_articlesubscription`
  ADD PRIMARY KEY (`articleplugin_ptr_id`),
  ADD UNIQUE KEY `subscription_ptr_id` (`subscription_ptr_id`);

--
-- Индексы таблицы `notify_notification`
--
ALTER TABLE `notify_notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notify_notification_104f5ac1` (`subscription_id`);

--
-- Индексы таблицы `notify_notificationtype`
--
ALTER TABLE `notify_notificationtype`
  ADD PRIMARY KEY (`key`),
  ADD KEY `notify_notificationtype_e4470c6e` (`content_type_id`);

--
-- Индексы таблицы `notify_settings`
--
ALTER TABLE `notify_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notify_settings_fbfc09f1` (`user_id`);

--
-- Индексы таблицы `notify_subscription`
--
ALTER TABLE `notify_subscription`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notify_subscription_83326d99` (`settings_id`),
  ADD KEY `notify_subscription_9955f091` (`notification_type_id`);

--
-- Индексы таблицы `oauth2_accesstoken`
--
ALTER TABLE `oauth2_accesstoken`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth2_accesstoken_fbfc09f1` (`user_id`),
  ADD KEY `oauth2_accesstoken_4a4e8ffb` (`client_id`),
  ADD KEY `oauth2_accesstoken_bfac9f99` (`token`);

--
-- Индексы таблицы `oauth2_client`
--
ALTER TABLE `oauth2_client`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth2_client_fbfc09f1` (`user_id`);

--
-- Индексы таблицы `oauth2_grant`
--
ALTER TABLE `oauth2_grant`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth2_grant_fbfc09f1` (`user_id`),
  ADD KEY `oauth2_grant_4a4e8ffb` (`client_id`);

--
-- Индексы таблицы `oauth2_provider_trustedclient`
--
ALTER TABLE `oauth2_provider_trustedclient`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth2_provider_trustedclient_4a4e8ffb` (`client_id`);

--
-- Индексы таблицы `oauth2_refreshtoken`
--
ALTER TABLE `oauth2_refreshtoken`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `access_token_id` (`access_token_id`),
  ADD KEY `oauth2_refreshtoken_fbfc09f1` (`user_id`),
  ADD KEY `oauth2_refreshtoken_4a4e8ffb` (`client_id`);

--
-- Индексы таблицы `psychometrics_psychometricdata`
--
ALTER TABLE `psychometrics_psychometricdata`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `studentmodule_id` (`studentmodule_id`);

--
-- Индексы таблицы `reverification_midcoursereverificationwindow`
--
ALTER TABLE `reverification_midcoursereverificationwindow`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reverification_midcoursereverificationwindow_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `shoppingcart_certificateitem`
--
ALTER TABLE `shoppingcart_certificateitem`
  ADD PRIMARY KEY (`orderitem_ptr_id`),
  ADD KEY `shoppingcart_certificateitem_ff48d8e5` (`course_id`),
  ADD KEY `shoppingcart_certificateitem_9e513f0b` (`course_enrollment_id`),
  ADD KEY `shoppingcart_certificateitem_4160619e` (`mode`);

--
-- Индексы таблицы `shoppingcart_coupon`
--
ALTER TABLE `shoppingcart_coupon`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shoppingcart_coupon_65da3d2c` (`code`),
  ADD KEY `shoppingcart_coupon_b5de30be` (`created_by_id`);

--
-- Индексы таблицы `shoppingcart_couponredemption`
--
ALTER TABLE `shoppingcart_couponredemption`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shoppingcart_couponredemption_8337030b` (`order_id`),
  ADD KEY `shoppingcart_couponredemption_fbfc09f1` (`user_id`),
  ADD KEY `shoppingcart_couponredemption_c29b2e60` (`coupon_id`);

--
-- Индексы таблицы `shoppingcart_courseregcodeitem`
--
ALTER TABLE `shoppingcart_courseregcodeitem`
  ADD PRIMARY KEY (`orderitem_ptr_id`),
  ADD KEY `shoppingcart_courseregcodeitem_ff48d8e5` (`course_id`),
  ADD KEY `shoppingcart_courseregcodeitem_4160619e` (`mode`);

--
-- Индексы таблицы `shoppingcart_courseregcodeitemannotation`
--
ALTER TABLE `shoppingcart_courseregcodeitemannotation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_id` (`course_id`);

--
-- Индексы таблицы `shoppingcart_courseregistrationcode`
--
ALTER TABLE `shoppingcart_courseregistrationcode`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `shoppingcart_courseregistrationcode_code_6614bad3cae62199_uniq` (`code`),
  ADD KEY `shoppingcart_courseregistrationcode_65da3d2c` (`code`),
  ADD KEY `shoppingcart_courseregistrationcode_ff48d8e5` (`course_id`),
  ADD KEY `shoppingcart_courseregistrationcode_b5de30be` (`created_by_id`),
  ADD KEY `shoppingcart_courseregistrationcode_59f72b12` (`invoice_id`),
  ADD KEY `shoppingcart_courseregistrationcode_8337030b` (`order_id`),
  ADD KEY `shoppingcart_courseregistrationcode_80766641` (`invoice_item_id`);

--
-- Индексы таблицы `shoppingcart_courseregistrationcodeinvoiceitem`
--
ALTER TABLE `shoppingcart_courseregistrationcodeinvoiceitem`
  ADD PRIMARY KEY (`invoiceitem_ptr_id`),
  ADD KEY `shoppingcart_courseregistrationcodeinvoiceitem_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `shoppingcart_donation`
--
ALTER TABLE `shoppingcart_donation`
  ADD PRIMARY KEY (`orderitem_ptr_id`),
  ADD KEY `shoppingcart_donation_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `shoppingcart_donationconfiguration`
--
ALTER TABLE `shoppingcart_donationconfiguration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shoppingcart_donationconfiguration_16905482` (`changed_by_id`);

--
-- Индексы таблицы `shoppingcart_invoice`
--
ALTER TABLE `shoppingcart_invoice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shoppingcart_invoice_ca9021a2` (`company_name`),
  ADD KEY `shoppingcart_invoice_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `shoppingcart_invoicehistory`
--
ALTER TABLE `shoppingcart_invoicehistory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shoppingcart_invoicehistory_67f1b7ce` (`timestamp`),
  ADD KEY `shoppingcart_invoicehistory_59f72b12` (`invoice_id`);

--
-- Индексы таблицы `shoppingcart_invoiceitem`
--
ALTER TABLE `shoppingcart_invoiceitem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shoppingcart_invoiceitem_59f72b12` (`invoice_id`);

--
-- Индексы таблицы `shoppingcart_invoicetransaction`
--
ALTER TABLE `shoppingcart_invoicetransaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shoppingcart_invoicetransaction_59f72b12` (`invoice_id`),
  ADD KEY `shoppingcart_invoicetransaction_b5de30be` (`created_by_id`),
  ADD KEY `shoppingcart_invoicetransaction_bcd6c6d2` (`last_modified_by_id`);

--
-- Индексы таблицы `shoppingcart_order`
--
ALTER TABLE `shoppingcart_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shoppingcart_order_fbfc09f1` (`user_id`);

--
-- Индексы таблицы `shoppingcart_orderitem`
--
ALTER TABLE `shoppingcart_orderitem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shoppingcart_orderitem_8337030b` (`order_id`),
  ADD KEY `shoppingcart_orderitem_fbfc09f1` (`user_id`),
  ADD KEY `shoppingcart_orderitem_c9ad71dd` (`status`),
  ADD KEY `shoppingcart_orderitem_8457f26a` (`fulfilled_time`),
  ADD KEY `shoppingcart_orderitem_416112c1` (`refund_requested_time`);

--
-- Индексы таблицы `shoppingcart_paidcourseregistration`
--
ALTER TABLE `shoppingcart_paidcourseregistration`
  ADD PRIMARY KEY (`orderitem_ptr_id`),
  ADD KEY `shoppingcart_paidcourseregistration_ff48d8e5` (`course_id`),
  ADD KEY `shoppingcart_paidcourseregistration_4160619e` (`mode`),
  ADD KEY `shoppingcart_paidcourseregistration_9e513f0b` (`course_enrollment_id`);

--
-- Индексы таблицы `shoppingcart_paidcourseregistrationannotation`
--
ALTER TABLE `shoppingcart_paidcourseregistrationannotation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_id` (`course_id`);

--
-- Индексы таблицы `shoppingcart_registrationcoderedemption`
--
ALTER TABLE `shoppingcart_registrationcoderedemption`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shoppingcart_registrationcoderedemption_8337030b` (`order_id`),
  ADD KEY `shoppingcart_registrationcoderedemption_d25b37dc` (`registration_code_id`),
  ADD KEY `shoppingcart_registrationcoderedemption_e151467a` (`redeemed_by_id`),
  ADD KEY `shoppingcart_registrationcoderedemption_9e513f0b` (`course_enrollment_id`);

--
-- Индексы таблицы `south_migrationhistory`
--
ALTER TABLE `south_migrationhistory`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `splash_splashconfig`
--
ALTER TABLE `splash_splashconfig`
  ADD PRIMARY KEY (`id`),
  ADD KEY `splash_splashconfig_16905482` (`changed_by_id`);

--
-- Индексы таблицы `student_anonymoususerid`
--
ALTER TABLE `student_anonymoususerid`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `anonymous_user_id` (`anonymous_user_id`),
  ADD KEY `student_anonymoususerid_fbfc09f1` (`user_id`),
  ADD KEY `student_anonymoususerid_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `student_courseaccessrole`
--
ALTER TABLE `student_courseaccessrole`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_courseaccessrole_user_id_3203176c4f474414_uniq` (`user_id`,`org`,`course_id`,`role`),
  ADD KEY `student_courseaccessrole_fbfc09f1` (`user_id`),
  ADD KEY `student_courseaccessrole_4f5f82e2` (`org`),
  ADD KEY `student_courseaccessrole_ff48d8e5` (`course_id`),
  ADD KEY `student_courseaccessrole_e0b082a1` (`role`);

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
-- Индексы таблицы `student_courseenrollmentallowed`
--
ALTER TABLE `student_courseenrollmentallowed`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_courseenrollmentallowed_email_6f3eafd4a6c58591_uniq` (`email`,`course_id`),
  ADD KEY `student_courseenrollmentallowed_3904588a` (`email`),
  ADD KEY `student_courseenrollmentallowed_ff48d8e5` (`course_id`),
  ADD KEY `student_courseenrollmentallowed_3216ff68` (`created`);

--
-- Индексы таблицы `student_courseenrollmentattribute`
--
ALTER TABLE `student_courseenrollmentattribute`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_courseenrollmentattribute_ab10102` (`enrollment_id`);

--
-- Индексы таблицы `student_dashboardconfiguration`
--
ALTER TABLE `student_dashboardconfiguration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_dashboardconfiguration_16905482` (`changed_by_id`);

--
-- Индексы таблицы `student_entranceexamconfiguration`
--
ALTER TABLE `student_entranceexamconfiguration`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_entranceexamconfiguration_user_id_714c2ef6a88504f0_uniq` (`user_id`,`course_id`),
  ADD KEY `student_entranceexamconfiguration_fbfc09f1` (`user_id`),
  ADD KEY `student_entranceexamconfiguration_ff48d8e5` (`course_id`),
  ADD KEY `student_entranceexamconfiguration_3216ff68` (`created`),
  ADD KEY `student_entranceexamconfiguration_8aac229` (`updated`);

--
-- Индексы таблицы `student_languageproficiency`
--
ALTER TABLE `student_languageproficiency`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_languageproficiency_code_68e76171684c62e5_uniq` (`code`,`user_profile_id`),
  ADD KEY `student_languageproficiency_634d39b9` (`user_profile_id`);

--
-- Индексы таблицы `student_linkedinaddtoprofileconfiguration`
--
ALTER TABLE `student_linkedinaddtoprofileconfiguration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_linkedinaddtoprofileconfiguration_16905482` (`changed_by_id`);

--
-- Индексы таблицы `student_loginfailures`
--
ALTER TABLE `student_loginfailures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_loginfailures_fbfc09f1` (`user_id`);

--
-- Индексы таблицы `student_manualenrollmentaudit`
--
ALTER TABLE `student_manualenrollmentaudit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_manualenrollmentaudit_ab10102` (`enrollment_id`),
  ADD KEY `student_manualenrollmentaudit_a14a0576` (`enrolled_by_id`),
  ADD KEY `student_manualenrollmentaudit_3dd381cb` (`enrolled_email`);

--
-- Индексы таблицы `student_passwordhistory`
--
ALTER TABLE `student_passwordhistory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_passwordhistory_fbfc09f1` (`user_id`);

--
-- Индексы таблицы `student_pendingemailchange`
--
ALTER TABLE `student_pendingemailchange`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `activation_key` (`activation_key`),
  ADD KEY `student_pendingemailchange_856c86d7` (`new_email`);

--
-- Индексы таблицы `student_pendingnamechange`
--
ALTER TABLE `student_pendingnamechange`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Индексы таблицы `student_usersignupsource`
--
ALTER TABLE `student_usersignupsource`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_usersignupsource_e00a881a` (`site`),
  ADD KEY `student_usersignupsource_fbfc09f1` (`user_id`);

--
-- Индексы таблицы `student_userstanding`
--
ALTER TABLE `student_userstanding`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `student_userstanding_16905482` (`changed_by_id`);

--
-- Индексы таблицы `student_usertestgroup`
--
ALTER TABLE `student_usertestgroup`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_usertestgroup_52094d6e` (`name`);

--
-- Индексы таблицы `student_usertestgroup_users`
--
ALTER TABLE `student_usertestgroup_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_usertestgroup_us_usertestgroup_id_63c588e0372991b0_uniq` (`usertestgroup_id`,`user_id`),
  ADD KEY `student_usertestgroup_users_44f27cdf` (`usertestgroup_id`),
  ADD KEY `student_usertestgroup_users_fbfc09f1` (`user_id`);

--
-- Индексы таблицы `submissions_score`
--
ALTER TABLE `submissions_score`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submissions_score_fa84001` (`student_item_id`),
  ADD KEY `submissions_score_b3d6235a` (`submission_id`),
  ADD KEY `submissions_score_3b1c9c31` (`created_at`);

--
-- Индексы таблицы `submissions_scoresummary`
--
ALTER TABLE `submissions_scoresummary`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_item_id` (`student_item_id`),
  ADD KEY `submissions_scoresummary_d65f9365` (`highest_id`),
  ADD KEY `submissions_scoresummary_1efb24d9` (`latest_id`);

--
-- Индексы таблицы `submissions_studentitem`
--
ALTER TABLE `submissions_studentitem`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `submissions_studentitem_course_id_6a6eccbdec6ffd0b_uniq` (`course_id`,`student_id`,`item_id`),
  ADD KEY `submissions_studentitem_42ff452e` (`student_id`),
  ADD KEY `submissions_studentitem_ff48d8e5` (`course_id`),
  ADD KEY `submissions_studentitem_67b70d25` (`item_id`);

--
-- Индексы таблицы `submissions_submission`
--
ALTER TABLE `submissions_submission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submissions_submission_2bbc74ae` (`uuid`),
  ADD KEY `submissions_submission_fa84001` (`student_item_id`),
  ADD KEY `submissions_submission_4452d192` (`submitted_at`),
  ADD KEY `submissions_submission_3b1c9c31` (`created_at`);

--
-- Индексы таблицы `survey_surveyanswer`
--
ALTER TABLE `survey_surveyanswer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `survey_surveyanswer_fbfc09f1` (`user_id`),
  ADD KEY `survey_surveyanswer_1d0aabf2` (`form_id`),
  ADD KEY `survey_surveyanswer_7e1499` (`field_name`);

--
-- Индексы таблицы `survey_surveyform`
--
ALTER TABLE `survey_surveyform`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индексы таблицы `teams_courseteam`
--
ALTER TABLE `teams_courseteam`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `team_id` (`team_id`),
  ADD KEY `teams_courseteam_ff48d8e5` (`course_id`),
  ADD KEY `teams_courseteam_57732028` (`topic_id`);

--
-- Индексы таблицы `teams_courseteammembership`
--
ALTER TABLE `teams_courseteammembership`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `teams_courseteammembership_user_id_48efa8e8971947c3_uniq` (`user_id`,`team_id`),
  ADD KEY `teams_courseteammembership_fbfc09f1` (`user_id`),
  ADD KEY `teams_courseteammembership_fcf8ac47` (`team_id`);

--
-- Индексы таблицы `track_trackinglog`
--
ALTER TABLE `track_trackinglog`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `user_api_usercoursetag`
--
ALTER TABLE `user_api_usercoursetag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_api_usercoursetags_user_id_a734720a0483b08_uniq` (`user_id`,`course_id`,`key`),
  ADD KEY `user_api_usercoursetags_fbfc09f1` (`user_id`),
  ADD KEY `user_api_usercoursetags_45544485` (`key`),
  ADD KEY `user_api_usercoursetags_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `user_api_userorgtag`
--
ALTER TABLE `user_api_userorgtag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_api_userorgtag_user_id_694f9e3322120c6f_uniq` (`user_id`,`org`,`key`),
  ADD KEY `user_api_userorgtag_user_id_694f9e3322120c6f` (`user_id`,`org`,`key`),
  ADD KEY `user_api_userorgtag_fbfc09f1` (`user_id`),
  ADD KEY `user_api_userorgtag_45544485` (`key`),
  ADD KEY `user_api_userorgtag_4f5f82e2` (`org`);

--
-- Индексы таблицы `user_api_userpreference`
--
ALTER TABLE `user_api_userpreference`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_api_userpreference_user_id_4e4942d73f760072_uniq` (`user_id`,`key`),
  ADD KEY `user_api_userpreference_fbfc09f1` (`user_id`),
  ADD KEY `user_api_userpreference_45544485` (`key`);

--
-- Индексы таблицы `util_ratelimitconfiguration`
--
ALTER TABLE `util_ratelimitconfiguration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `util_ratelimitconfiguration_16905482` (`changed_by_id`);

--
-- Индексы таблицы `verify_student_incoursereverificationconfiguration`
--
ALTER TABLE `verify_student_incoursereverificationconfiguration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `verify_student_incoursereverificationconfiguration_16905482` (`changed_by_id`);

--
-- Индексы таблицы `verify_student_skippedreverification`
--
ALTER TABLE `verify_student_skippedreverification`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `verify_student_skippedreverificat_user_id_1e8af5a5e735aa1a_uniq` (`user_id`,`course_id`),
  ADD KEY `verify_student_skippedreverification_fbfc09f1` (`user_id`),
  ADD KEY `verify_student_skippedreverification_ff48d8e5` (`course_id`),
  ADD KEY `verify_student_skippedreverification_a631e438` (`checkpoint_id`);

--
-- Индексы таблицы `verify_student_softwaresecurephotoverification`
--
ALTER TABLE `verify_student_softwaresecurephotoverification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `verify_student_softwaresecurephotoverification_fbfc09f1` (`user_id`),
  ADD KEY `verify_student_softwaresecurephotoverification_8713c555` (`receipt_id`),
  ADD KEY `verify_student_softwaresecurephotoverification_3b1c9c31` (`created_at`),
  ADD KEY `verify_student_softwaresecurephotoverification_f84f7de6` (`updated_at`),
  ADD KEY `verify_student_softwaresecurephotoverification_4452d192` (`submitted_at`),
  ADD KEY `verify_student_softwaresecurephotoverification_b2c165b4` (`reviewing_user_id`),
  ADD KEY `verify_student_softwaresecurephotoverification_7343ffda` (`window_id`),
  ADD KEY `verify_student_softwaresecurephotoverification_35eebcb6` (`display`);

--
-- Индексы таблицы `verify_student_verificationcheckpoint`
--
ALTER TABLE `verify_student_verificationcheckpoint`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `verify_student_verificationchec_course_id_2c6a1f5c22b4cc19_uniq` (`course_id`,`checkpoint_location`),
  ADD KEY `verify_student_verificationcheckpoint_ff48d8e5` (`course_id`);

--
-- Индексы таблицы `verify_student_verificationcheckpoint_photo_verification`
--
ALTER TABLE `verify_student_verificationcheckpoint_photo_verification`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `verify_student_v_verificationcheckpoint_id_1df07f66c1a9271_uniq` (`verificationcheckpoint_id`,`softwaresecurephotoverification_id`),
  ADD KEY `verify_student_verificationcheckpoint_photo_verification_c30361a` (`verificationcheckpoint_id`),
  ADD KEY `verify_student_verificationcheckpoint_photo_verification_fdc8dba` (`softwaresecurephotoverification_id`);

--
-- Индексы таблицы `verify_student_verificationstatus`
--
ALTER TABLE `verify_student_verificationstatus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `verify_student_verificationstatus_a631e438` (`checkpoint_id`),
  ADD KEY `verify_student_verificationstatus_fbfc09f1` (`user_id`),
  ADD KEY `verify_student_verificationstatus_c9ad71dd` (`status`);

--
-- Индексы таблицы `wiki_article`
--
ALTER TABLE `wiki_article`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `current_revision_id` (`current_revision_id`),
  ADD KEY `wiki_article_5d52dd10` (`owner_id`),
  ADD KEY `wiki_article_bda51c3c` (`group_id`);

--
-- Индексы таблицы `wiki_articleforobject`
--
ALTER TABLE `wiki_articleforobject`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wiki_articleforobject_content_type_id_27c4cce189b3bcab_uniq` (`content_type_id`,`object_id`),
  ADD KEY `wiki_articleforobject_30525a19` (`article_id`),
  ADD KEY `wiki_articleforobject_e4470c6e` (`content_type_id`);

--
-- Индексы таблицы `wiki_articleplugin`
--
ALTER TABLE `wiki_articleplugin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wiki_articleplugin_30525a19` (`article_id`);

--
-- Индексы таблицы `wiki_articlerevision`
--
ALTER TABLE `wiki_articlerevision`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wiki_articlerevision_article_id_4b4e7910c8e7b2d0_uniq` (`article_id`,`revision_number`),
  ADD KEY `wiki_articlerevision_fbfc09f1` (`user_id`),
  ADD KEY `wiki_articlerevision_49bc38cc` (`previous_revision_id`),
  ADD KEY `wiki_articlerevision_30525a19` (`article_id`);

--
-- Индексы таблицы `wiki_articlesubscription`
--
ALTER TABLE `wiki_articlesubscription`
  ADD PRIMARY KEY (`articleplugin_ptr_id`),
  ADD UNIQUE KEY `subscription_ptr_id` (`subscription_ptr_id`);

--
-- Индексы таблицы `wiki_attachment`
--
ALTER TABLE `wiki_attachment`
  ADD PRIMARY KEY (`reusableplugin_ptr_id`),
  ADD UNIQUE KEY `current_revision_id` (`current_revision_id`);

--
-- Индексы таблицы `wiki_attachmentrevision`
--
ALTER TABLE `wiki_attachmentrevision`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wiki_attachmentrevision_fbfc09f1` (`user_id`),
  ADD KEY `wiki_attachmentrevision_49bc38cc` (`previous_revision_id`),
  ADD KEY `wiki_attachmentrevision_edee6011` (`attachment_id`);

--
-- Индексы таблицы `wiki_image`
--
ALTER TABLE `wiki_image`
  ADD PRIMARY KEY (`revisionplugin_ptr_id`);

--
-- Индексы таблицы `wiki_imagerevision`
--
ALTER TABLE `wiki_imagerevision`
  ADD PRIMARY KEY (`revisionpluginrevision_ptr_id`);

--
-- Индексы таблицы `wiki_reusableplugin`
--
ALTER TABLE `wiki_reusableplugin`
  ADD PRIMARY KEY (`articleplugin_ptr_id`);

--
-- Индексы таблицы `wiki_reusableplugin_articles`
--
ALTER TABLE `wiki_reusableplugin_articles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wiki_reusableplugin_art_reusableplugin_id_6e34ac94afa8f9f2_uniq` (`reusableplugin_id`,`article_id`),
  ADD KEY `wiki_reusableplugin_articles_28b0b358` (`reusableplugin_id`),
  ADD KEY `wiki_reusableplugin_articles_30525a19` (`article_id`);

--
-- Индексы таблицы `wiki_revisionplugin`
--
ALTER TABLE `wiki_revisionplugin`
  ADD PRIMARY KEY (`articleplugin_ptr_id`),
  ADD UNIQUE KEY `current_revision_id` (`current_revision_id`);

--
-- Индексы таблицы `wiki_revisionpluginrevision`
--
ALTER TABLE `wiki_revisionpluginrevision`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wiki_revisionpluginrevision_fbfc09f1` (`user_id`),
  ADD KEY `wiki_revisionpluginrevision_49bc38cc` (`previous_revision_id`),
  ADD KEY `wiki_revisionpluginrevision_2857ccbf` (`plugin_id`);

--
-- Индексы таблицы `wiki_simpleplugin`
--
ALTER TABLE `wiki_simpleplugin`
  ADD PRIMARY KEY (`articleplugin_ptr_id`),
  ADD KEY `wiki_simpleplugin_b3dc49fe` (`article_revision_id`);

--
-- Индексы таблицы `wiki_urlpath`
--
ALTER TABLE `wiki_urlpath`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wiki_urlpath_site_id_124f6aa7b2cc9b82_uniq` (`site_id`,`parent_id`,`slug`),
  ADD KEY `wiki_urlpath_a951d5d6` (`slug`),
  ADD KEY `wiki_urlpath_6223029` (`site_id`),
  ADD KEY `wiki_urlpath_63f17a16` (`parent_id`),
  ADD KEY `wiki_urlpath_42b06ff6` (`lft`),
  ADD KEY `wiki_urlpath_91543e5a` (`rght`),
  ADD KEY `wiki_urlpath_efd07f28` (`tree_id`),
  ADD KEY `wiki_urlpath_2a8f42e8` (`level`),
  ADD KEY `wiki_urlpath_30525a19` (`article_id`);

--
-- Индексы таблицы `workflow_assessmentworkflow`
--
ALTER TABLE `workflow_assessmentworkflow`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `submission_uuid` (`submission_uuid`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `workflow_assessmentworkflow_course_id_21b427c69fc666ad` (`course_id`,`item_id`,`status`),
  ADD KEY `workflow_assessmentworkflow_ff48d8e5` (`course_id`),
  ADD KEY `workflow_assessmentworkflow_67b70d25` (`item_id`);

--
-- Индексы таблицы `workflow_assessmentworkflowcancellation`
--
ALTER TABLE `workflow_assessmentworkflowcancellation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workflow_assessmentworkflowcancellation_26cddbc7` (`workflow_id`),
  ADD KEY `workflow_assessmentworkflowcancellation_8569167` (`cancelled_by_id`),
  ADD KEY `workflow_assessmentworkflowcancellation_3b1c9c31` (`created_at`);

--
-- Индексы таблицы `workflow_assessmentworkflowstep`
--
ALTER TABLE `workflow_assessmentworkflowstep`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workflow_assessmentworkflowstep_26cddbc7` (`workflow_id`);

--
-- Индексы таблицы `xblock_config_studioconfig`
--
ALTER TABLE `xblock_config_studioconfig`
  ADD PRIMARY KEY (`id`),
  ADD KEY `xblock_config_studioconfig_16905482` (`changed_by_id`);

--
-- Индексы таблицы `xblock_django_xblockdisableconfig`
--
ALTER TABLE `xblock_django_xblockdisableconfig`
  ADD PRIMARY KEY (`id`),
  ADD KEY `xblock_django_xblockdisableconfig_16905482` (`changed_by_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `assessment_aiclassifier`
--
ALTER TABLE `assessment_aiclassifier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `assessment_aiclassifierset`
--
ALTER TABLE `assessment_aiclassifierset`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `assessment_aigradingworkflow`
--
ALTER TABLE `assessment_aigradingworkflow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `assessment_aitrainingworkflow`
--
ALTER TABLE `assessment_aitrainingworkflow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `assessment_aitrainingworkflow_training_examples`
--
ALTER TABLE `assessment_aitrainingworkflow_training_examples`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `assessment_assessment`
--
ALTER TABLE `assessment_assessment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `assessment_assessmentfeedback`
--
ALTER TABLE `assessment_assessmentfeedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `assessment_assessmentfeedbackoption`
--
ALTER TABLE `assessment_assessmentfeedbackoption`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `assessment_assessmentfeedback_assessments`
--
ALTER TABLE `assessment_assessmentfeedback_assessments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `assessment_assessmentfeedback_options`
--
ALTER TABLE `assessment_assessmentfeedback_options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `assessment_assessmentpart`
--
ALTER TABLE `assessment_assessmentpart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `assessment_criterion`
--
ALTER TABLE `assessment_criterion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `assessment_criterionoption`
--
ALTER TABLE `assessment_criterionoption`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT для таблицы `assessment_peerworkflow`
--
ALTER TABLE `assessment_peerworkflow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `assessment_peerworkflowitem`
--
ALTER TABLE `assessment_peerworkflowitem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `assessment_rubric`
--
ALTER TABLE `assessment_rubric`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `assessment_studenttrainingworkflow`
--
ALTER TABLE `assessment_studenttrainingworkflow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `assessment_studenttrainingworkflowitem`
--
ALTER TABLE `assessment_studenttrainingworkflowitem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `assessment_trainingexample`
--
ALTER TABLE `assessment_trainingexample`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `assessment_trainingexample_options_selected`
--
ALTER TABLE `assessment_trainingexample_options_selected`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=571;
--
-- AUTO_INCREMENT для таблицы `auth_registration`
--
ALTER TABLE `auth_registration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT для таблицы `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT для таблицы `auth_userprofile`
--
ALTER TABLE `auth_userprofile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT для таблицы `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `branding_brandingapiconfig`
--
ALTER TABLE `branding_brandingapiconfig`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `branding_brandinginfoconfig`
--
ALTER TABLE `branding_brandinginfoconfig`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `bulk_email_courseauthorization`
--
ALTER TABLE `bulk_email_courseauthorization`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `bulk_email_courseemail`
--
ALTER TABLE `bulk_email_courseemail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `bulk_email_courseemailtemplate`
--
ALTER TABLE `bulk_email_courseemailtemplate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `bulk_email_optout`
--
ALTER TABLE `bulk_email_optout`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `celery_taskmeta`
--
ALTER TABLE `celery_taskmeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `celery_tasksetmeta`
--
ALTER TABLE `celery_tasksetmeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `certificates_badgeassertion`
--
ALTER TABLE `certificates_badgeassertion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `certificates_badgeimageconfiguration`
--
ALTER TABLE `certificates_badgeimageconfiguration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `certificates_certificategenerationconfiguration`
--
ALTER TABLE `certificates_certificategenerationconfiguration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `certificates_certificategenerationcoursesetting`
--
ALTER TABLE `certificates_certificategenerationcoursesetting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `certificates_certificatehtmlviewconfiguration`
--
ALTER TABLE `certificates_certificatehtmlviewconfiguration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `certificates_certificatewhitelist`
--
ALTER TABLE `certificates_certificatewhitelist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `certificates_examplecertificate`
--
ALTER TABLE `certificates_examplecertificate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `certificates_examplecertificateset`
--
ALTER TABLE `certificates_examplecertificateset`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `certificates_generatedcertificate`
--
ALTER TABLE `certificates_generatedcertificate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `circuit_servercircuit`
--
ALTER TABLE `circuit_servercircuit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `contentstore_pushnotificationconfig`
--
ALTER TABLE `contentstore_pushnotificationconfig`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `contentstore_videouploadconfig`
--
ALTER TABLE `contentstore_videouploadconfig`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `corsheaders_corsmodel`
--
ALTER TABLE `corsheaders_corsmodel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `cors_csrf_xdomainproxyconfiguration`
--
ALTER TABLE `cors_csrf_xdomainproxyconfiguration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `courseware_offlinecomputedgrade`
--
ALTER TABLE `courseware_offlinecomputedgrade`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `courseware_offlinecomputedgradelog`
--
ALTER TABLE `courseware_offlinecomputedgradelog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `courseware_studentfieldoverride`
--
ALTER TABLE `courseware_studentfieldoverride`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `courseware_studentmodule`
--
ALTER TABLE `courseware_studentmodule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT для таблицы `courseware_studentmodulehistory`
--
ALTER TABLE `courseware_studentmodulehistory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;
--
-- AUTO_INCREMENT для таблицы `courseware_xmodulestudentinfofield`
--
ALTER TABLE `courseware_xmodulestudentinfofield`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `courseware_xmodulestudentprefsfield`
--
ALTER TABLE `courseware_xmodulestudentprefsfield`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `courseware_xmoduleuserstatesummaryfield`
--
ALTER TABLE `courseware_xmoduleuserstatesummaryfield`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `course_action_state_coursererunstate`
--
ALTER TABLE `course_action_state_coursererunstate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `course_creators_coursecreator`
--
ALTER TABLE `course_creators_coursecreator`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `course_groups_coursecohort`
--
ALTER TABLE `course_groups_coursecohort`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `course_groups_coursecohortssettings`
--
ALTER TABLE `course_groups_coursecohortssettings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `course_groups_courseusergroup`
--
ALTER TABLE `course_groups_courseusergroup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `course_groups_courseusergrouppartitiongroup`
--
ALTER TABLE `course_groups_courseusergrouppartitiongroup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `course_groups_courseusergroup_users`
--
ALTER TABLE `course_groups_courseusergroup_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `course_modes_coursemode`
--
ALTER TABLE `course_modes_coursemode`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `course_modes_coursemodesarchive`
--
ALTER TABLE `course_modes_coursemodesarchive`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `course_structures_coursestructure`
--
ALTER TABLE `course_structures_coursestructure`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `credit_creditcourse`
--
ALTER TABLE `credit_creditcourse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `credit_crediteligibility`
--
ALTER TABLE `credit_crediteligibility`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `credit_creditprovider`
--
ALTER TABLE `credit_creditprovider`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `credit_creditrequest`
--
ALTER TABLE `credit_creditrequest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `credit_creditrequirement`
--
ALTER TABLE `credit_creditrequirement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `credit_creditrequirementstatus`
--
ALTER TABLE `credit_creditrequirementstatus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `credit_historicalcreditrequest`
--
ALTER TABLE `credit_historicalcreditrequest`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `credit_historicalcreditrequirementstatus`
--
ALTER TABLE `credit_historicalcreditrequirementstatus`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `dark_lang_darklangconfig`
--
ALTER TABLE `dark_lang_darklangconfig`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `django_comment_client_permission_roles`
--
ALTER TABLE `django_comment_client_permission_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=190;
--
-- AUTO_INCREMENT для таблицы `django_comment_client_role`
--
ALTER TABLE `django_comment_client_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT для таблицы `django_comment_client_role_users`
--
ALTER TABLE `django_comment_client_role_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT для таблицы `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=190;
--
-- AUTO_INCREMENT для таблицы `django_openid_auth_association`
--
ALTER TABLE `django_openid_auth_association`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `django_openid_auth_nonce`
--
ALTER TABLE `django_openid_auth_nonce`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `django_openid_auth_useropenid`
--
ALTER TABLE `django_openid_auth_useropenid`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `django_site`
--
ALTER TABLE `django_site`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `djcelery_crontabschedule`
--
ALTER TABLE `djcelery_crontabschedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `djcelery_intervalschedule`
--
ALTER TABLE `djcelery_intervalschedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `djcelery_periodictask`
--
ALTER TABLE `djcelery_periodictask`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `djcelery_taskstate`
--
ALTER TABLE `djcelery_taskstate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `djcelery_workerstate`
--
ALTER TABLE `djcelery_workerstate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `edxval_coursevideo`
--
ALTER TABLE `edxval_coursevideo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `edxval_encodedvideo`
--
ALTER TABLE `edxval_encodedvideo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `edxval_profile`
--
ALTER TABLE `edxval_profile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT для таблицы `edxval_subtitle`
--
ALTER TABLE `edxval_subtitle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `edxval_video`
--
ALTER TABLE `edxval_video`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `embargo_country`
--
ALTER TABLE `embargo_country`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=250;
--
-- AUTO_INCREMENT для таблицы `embargo_countryaccessrule`
--
ALTER TABLE `embargo_countryaccessrule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `embargo_courseaccessrulehistory`
--
ALTER TABLE `embargo_courseaccessrulehistory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `embargo_embargoedcourse`
--
ALTER TABLE `embargo_embargoedcourse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `embargo_embargoedstate`
--
ALTER TABLE `embargo_embargoedstate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `embargo_ipfilter`
--
ALTER TABLE `embargo_ipfilter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `embargo_restrictedcourse`
--
ALTER TABLE `embargo_restrictedcourse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `external_auth_externalauthmap`
--
ALTER TABLE `external_auth_externalauthmap`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `foldit_puzzlecomplete`
--
ALTER TABLE `foldit_puzzlecomplete`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `foldit_score`
--
ALTER TABLE `foldit_score`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `instructor_task_instructortask`
--
ALTER TABLE `instructor_task_instructortask`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `licenses_coursesoftware`
--
ALTER TABLE `licenses_coursesoftware`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `licenses_userlicense`
--
ALTER TABLE `licenses_userlicense`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `lms_xblock_xblockasidesconfig`
--
ALTER TABLE `lms_xblock_xblockasidesconfig`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `milestones_coursecontentmilestone`
--
ALTER TABLE `milestones_coursecontentmilestone`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `milestones_coursemilestone`
--
ALTER TABLE `milestones_coursemilestone`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `milestones_milestone`
--
ALTER TABLE `milestones_milestone`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `milestones_milestonerelationshiptype`
--
ALTER TABLE `milestones_milestonerelationshiptype`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `milestones_usermilestone`
--
ALTER TABLE `milestones_usermilestone`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `mobile_api_mobileapiconfig`
--
ALTER TABLE `mobile_api_mobileapiconfig`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `notes_note`
--
ALTER TABLE `notes_note`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `notify_notification`
--
ALTER TABLE `notify_notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `notify_settings`
--
ALTER TABLE `notify_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `notify_subscription`
--
ALTER TABLE `notify_subscription`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `oauth2_accesstoken`
--
ALTER TABLE `oauth2_accesstoken`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `oauth2_client`
--
ALTER TABLE `oauth2_client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `oauth2_grant`
--
ALTER TABLE `oauth2_grant`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `oauth2_provider_trustedclient`
--
ALTER TABLE `oauth2_provider_trustedclient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `oauth2_refreshtoken`
--
ALTER TABLE `oauth2_refreshtoken`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `psychometrics_psychometricdata`
--
ALTER TABLE `psychometrics_psychometricdata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `reverification_midcoursereverificationwindow`
--
ALTER TABLE `reverification_midcoursereverificationwindow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `shoppingcart_coupon`
--
ALTER TABLE `shoppingcart_coupon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `shoppingcart_couponredemption`
--
ALTER TABLE `shoppingcart_couponredemption`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `shoppingcart_courseregcodeitemannotation`
--
ALTER TABLE `shoppingcart_courseregcodeitemannotation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `shoppingcart_courseregistrationcode`
--
ALTER TABLE `shoppingcart_courseregistrationcode`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `shoppingcart_donationconfiguration`
--
ALTER TABLE `shoppingcart_donationconfiguration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `shoppingcart_invoice`
--
ALTER TABLE `shoppingcart_invoice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `shoppingcart_invoicehistory`
--
ALTER TABLE `shoppingcart_invoicehistory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `shoppingcart_invoiceitem`
--
ALTER TABLE `shoppingcart_invoiceitem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `shoppingcart_invoicetransaction`
--
ALTER TABLE `shoppingcart_invoicetransaction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `shoppingcart_order`
--
ALTER TABLE `shoppingcart_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `shoppingcart_orderitem`
--
ALTER TABLE `shoppingcart_orderitem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `shoppingcart_paidcourseregistrationannotation`
--
ALTER TABLE `shoppingcart_paidcourseregistrationannotation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `shoppingcart_registrationcoderedemption`
--
ALTER TABLE `shoppingcart_registrationcoderedemption`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `south_migrationhistory`
--
ALTER TABLE `south_migrationhistory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=264;
--
-- AUTO_INCREMENT для таблицы `splash_splashconfig`
--
ALTER TABLE `splash_splashconfig`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `student_anonymoususerid`
--
ALTER TABLE `student_anonymoususerid`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT для таблицы `student_courseaccessrole`
--
ALTER TABLE `student_courseaccessrole`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `student_courseenrollment`
--
ALTER TABLE `student_courseenrollment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT для таблицы `student_courseenrollmentallowed`
--
ALTER TABLE `student_courseenrollmentallowed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `student_courseenrollmentattribute`
--
ALTER TABLE `student_courseenrollmentattribute`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `student_dashboardconfiguration`
--
ALTER TABLE `student_dashboardconfiguration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `student_entranceexamconfiguration`
--
ALTER TABLE `student_entranceexamconfiguration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `student_languageproficiency`
--
ALTER TABLE `student_languageproficiency`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `student_linkedinaddtoprofileconfiguration`
--
ALTER TABLE `student_linkedinaddtoprofileconfiguration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `student_loginfailures`
--
ALTER TABLE `student_loginfailures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `student_manualenrollmentaudit`
--
ALTER TABLE `student_manualenrollmentaudit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `student_passwordhistory`
--
ALTER TABLE `student_passwordhistory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `student_pendingemailchange`
--
ALTER TABLE `student_pendingemailchange`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `student_pendingnamechange`
--
ALTER TABLE `student_pendingnamechange`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `student_usersignupsource`
--
ALTER TABLE `student_usersignupsource`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `student_userstanding`
--
ALTER TABLE `student_userstanding`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `student_usertestgroup`
--
ALTER TABLE `student_usertestgroup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `student_usertestgroup_users`
--
ALTER TABLE `student_usertestgroup_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `submissions_score`
--
ALTER TABLE `submissions_score`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `submissions_scoresummary`
--
ALTER TABLE `submissions_scoresummary`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `submissions_studentitem`
--
ALTER TABLE `submissions_studentitem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `submissions_submission`
--
ALTER TABLE `submissions_submission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `survey_surveyanswer`
--
ALTER TABLE `survey_surveyanswer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `survey_surveyform`
--
ALTER TABLE `survey_surveyform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `teams_courseteam`
--
ALTER TABLE `teams_courseteam`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `teams_courseteammembership`
--
ALTER TABLE `teams_courseteammembership`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `track_trackinglog`
--
ALTER TABLE `track_trackinglog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `user_api_usercoursetag`
--
ALTER TABLE `user_api_usercoursetag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `user_api_userorgtag`
--
ALTER TABLE `user_api_userorgtag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `user_api_userpreference`
--
ALTER TABLE `user_api_userpreference`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `util_ratelimitconfiguration`
--
ALTER TABLE `util_ratelimitconfiguration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `verify_student_incoursereverificationconfiguration`
--
ALTER TABLE `verify_student_incoursereverificationconfiguration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `verify_student_skippedreverification`
--
ALTER TABLE `verify_student_skippedreverification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `verify_student_softwaresecurephotoverification`
--
ALTER TABLE `verify_student_softwaresecurephotoverification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `verify_student_verificationcheckpoint`
--
ALTER TABLE `verify_student_verificationcheckpoint`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `verify_student_verificationcheckpoint_photo_verification`
--
ALTER TABLE `verify_student_verificationcheckpoint_photo_verification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `verify_student_verificationstatus`
--
ALTER TABLE `verify_student_verificationstatus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `wiki_article`
--
ALTER TABLE `wiki_article`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `wiki_articleforobject`
--
ALTER TABLE `wiki_articleforobject`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `wiki_articleplugin`
--
ALTER TABLE `wiki_articleplugin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `wiki_articlerevision`
--
ALTER TABLE `wiki_articlerevision`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `wiki_attachmentrevision`
--
ALTER TABLE `wiki_attachmentrevision`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `wiki_reusableplugin_articles`
--
ALTER TABLE `wiki_reusableplugin_articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `wiki_revisionpluginrevision`
--
ALTER TABLE `wiki_revisionpluginrevision`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `wiki_urlpath`
--
ALTER TABLE `wiki_urlpath`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `workflow_assessmentworkflow`
--
ALTER TABLE `workflow_assessmentworkflow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `workflow_assessmentworkflowcancellation`
--
ALTER TABLE `workflow_assessmentworkflowcancellation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `workflow_assessmentworkflowstep`
--
ALTER TABLE `workflow_assessmentworkflowstep`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `xblock_config_studioconfig`
--
ALTER TABLE `xblock_config_studioconfig`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `xblock_django_xblockdisableconfig`
--
ALTER TABLE `xblock_django_xblockdisableconfig`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `assessment_aiclassifier`
--
ALTER TABLE `assessment_aiclassifier`
  ADD CONSTRAINT `classifier_set_id_refs_id_f80cbf6` FOREIGN KEY (`classifier_set_id`) REFERENCES `assessment_aiclassifierset` (`id`),
  ADD CONSTRAINT `criterion_id_refs_id_e6ab97f2` FOREIGN KEY (`criterion_id`) REFERENCES `assessment_criterion` (`id`);

--
-- Ограничения внешнего ключа таблицы `assessment_aiclassifierset`
--
ALTER TABLE `assessment_aiclassifierset`
  ADD CONSTRAINT `rubric_id_refs_id_c037b8e4` FOREIGN KEY (`rubric_id`) REFERENCES `assessment_rubric` (`id`);

--
-- Ограничения внешнего ключа таблицы `assessment_aigradingworkflow`
--
ALTER TABLE `assessment_aigradingworkflow`
  ADD CONSTRAINT `assessment_id_refs_id_1d8478e7` FOREIGN KEY (`assessment_id`) REFERENCES `assessment_assessment` (`id`),
  ADD CONSTRAINT `classifier_set_id_refs_id_1e9046d1` FOREIGN KEY (`classifier_set_id`) REFERENCES `assessment_aiclassifierset` (`id`),
  ADD CONSTRAINT `rubric_id_refs_id_dc2a0464` FOREIGN KEY (`rubric_id`) REFERENCES `assessment_rubric` (`id`);

--
-- Ограничения внешнего ключа таблицы `assessment_aitrainingworkflow`
--
ALTER TABLE `assessment_aitrainingworkflow`
  ADD CONSTRAINT `classifier_set_id_refs_id_dcc7412` FOREIGN KEY (`classifier_set_id`) REFERENCES `assessment_aiclassifierset` (`id`);

--
-- Ограничения внешнего ключа таблицы `assessment_aitrainingworkflow_training_examples`
--
ALTER TABLE `assessment_aitrainingworkflow_training_examples`
  ADD CONSTRAINT `aitrainingworkflow_id_refs_id_45c30582` FOREIGN KEY (`aitrainingworkflow_id`) REFERENCES `assessment_aitrainingworkflow` (`id`),
  ADD CONSTRAINT `trainingexample_id_refs_id_bf13a24` FOREIGN KEY (`trainingexample_id`) REFERENCES `assessment_trainingexample` (`id`);

--
-- Ограничения внешнего ключа таблицы `assessment_assessment`
--
ALTER TABLE `assessment_assessment`
  ADD CONSTRAINT `rubric_id_refs_id_1ab6dbc4` FOREIGN KEY (`rubric_id`) REFERENCES `assessment_rubric` (`id`);

--
-- Ограничения внешнего ключа таблицы `assessment_assessmentfeedback_assessments`
--
ALTER TABLE `assessment_assessmentfeedback_assessments`
  ADD CONSTRAINT `assessment_id_refs_id_e7fd607e` FOREIGN KEY (`assessment_id`) REFERENCES `assessment_assessment` (`id`),
  ADD CONSTRAINT `assessmentfeedback_id_refs_id_91bbd347` FOREIGN KEY (`assessmentfeedback_id`) REFERENCES `assessment_assessmentfeedback` (`id`);

--
-- Ограничения внешнего ключа таблицы `assessment_assessmentfeedback_options`
--
ALTER TABLE `assessment_assessmentfeedback_options`
  ADD CONSTRAINT `assessmentfeedback_id_refs_id_5c27c412` FOREIGN KEY (`assessmentfeedback_id`) REFERENCES `assessment_assessmentfeedback` (`id`),
  ADD CONSTRAINT `assessmentfeedbackoption_id_refs_id_cdf28acd` FOREIGN KEY (`assessmentfeedbackoption_id`) REFERENCES `assessment_assessmentfeedbackoption` (`id`);

--
-- Ограничения внешнего ключа таблицы `assessment_assessmentpart`
--
ALTER TABLE `assessment_assessmentpart`
  ADD CONSTRAINT `assessment_id_refs_id_bff26444` FOREIGN KEY (`assessment_id`) REFERENCES `assessment_assessment` (`id`),
  ADD CONSTRAINT `criterion_id_refs_id_eeb3dc44` FOREIGN KEY (`criterion_id`) REFERENCES `assessment_criterion` (`id`),
  ADD CONSTRAINT `option_id_refs_id_4439dd5` FOREIGN KEY (`option_id`) REFERENCES `assessment_criterionoption` (`id`);

--
-- Ограничения внешнего ключа таблицы `assessment_criterion`
--
ALTER TABLE `assessment_criterion`
  ADD CONSTRAINT `rubric_id_refs_id_f2f4f3c4` FOREIGN KEY (`rubric_id`) REFERENCES `assessment_rubric` (`id`);

--
-- Ограничения внешнего ключа таблицы `assessment_criterionoption`
--
ALTER TABLE `assessment_criterionoption`
  ADD CONSTRAINT `criterion_id_refs_id_d2645232` FOREIGN KEY (`criterion_id`) REFERENCES `assessment_criterion` (`id`);

--
-- Ограничения внешнего ключа таблицы `assessment_peerworkflowitem`
--
ALTER TABLE `assessment_peerworkflowitem`
  ADD CONSTRAINT `assessment_id_refs_id_f69a86a1` FOREIGN KEY (`assessment_id`) REFERENCES `assessment_assessment` (`id`),
  ADD CONSTRAINT `author_id_refs_id_59547df0` FOREIGN KEY (`author_id`) REFERENCES `assessment_peerworkflow` (`id`),
  ADD CONSTRAINT `scorer_id_refs_id_59547df0` FOREIGN KEY (`scorer_id`) REFERENCES `assessment_peerworkflow` (`id`);

--
-- Ограничения внешнего ключа таблицы `assessment_studenttrainingworkflowitem`
--
ALTER TABLE `assessment_studenttrainingworkflowitem`
  ADD CONSTRAINT `training_example_id_refs_id_7d3f36e4` FOREIGN KEY (`training_example_id`) REFERENCES `assessment_trainingexample` (`id`),
  ADD CONSTRAINT `workflow_id_refs_id_ce50a30` FOREIGN KEY (`workflow_id`) REFERENCES `assessment_studenttrainingworkflow` (`id`);

--
-- Ограничения внешнего ключа таблицы `assessment_trainingexample`
--
ALTER TABLE `assessment_trainingexample`
  ADD CONSTRAINT `rubric_id_refs_id_7750db21` FOREIGN KEY (`rubric_id`) REFERENCES `assessment_rubric` (`id`);

--
-- Ограничения внешнего ключа таблицы `assessment_trainingexample_options_selected`
--
ALTER TABLE `assessment_trainingexample_options_selected`
  ADD CONSTRAINT `criterionoption_id_refs_id_bed5a465` FOREIGN KEY (`criterionoption_id`) REFERENCES `assessment_criterionoption` (`id`),
  ADD CONSTRAINT `trainingexample_id_refs_id_5f0faa8d` FOREIGN KEY (`trainingexample_id`) REFERENCES `assessment_trainingexample` (`id`);

--
-- Ограничения внешнего ключа таблицы `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `group_id_refs_id_3cea63fe` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `permission_id_refs_id_a7792de1` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);

--
-- Ограничения внешнего ключа таблицы `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `content_type_id_refs_id_728de91f` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Ограничения внешнего ключа таблицы `auth_registration`
--
ALTER TABLE `auth_registration`
  ADD CONSTRAINT `user_id_refs_id_3e5b0b5` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `auth_userprofile`
--
ALTER TABLE `auth_userprofile`
  ADD CONSTRAINT `user_id_refs_id_628b4c11` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `group_id_refs_id_f0ee9890` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `user_id_refs_id_831107f1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `permission_id_refs_id_67e79cb` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `user_id_refs_id_f2045483` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `branding_brandingapiconfig`
--
ALTER TABLE `branding_brandingapiconfig`
  ADD CONSTRAINT `changed_by_id_refs_id_9f2ff49` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `branding_brandinginfoconfig`
--
ALTER TABLE `branding_brandinginfoconfig`
  ADD CONSTRAINT `changed_by_id_refs_id_d2757db8` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `bulk_email_courseemail`
--
ALTER TABLE `bulk_email_courseemail`
  ADD CONSTRAINT `sender_id_refs_id_70ed6279` FOREIGN KEY (`sender_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `bulk_email_optout`
--
ALTER TABLE `bulk_email_optout`
  ADD CONSTRAINT `user_id_refs_id_9e68e67c` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `certificates_badgeassertion`
--
ALTER TABLE `certificates_badgeassertion`
  ADD CONSTRAINT `user_id_refs_id_30664b3b` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `certificates_certificategenerationconfiguration`
--
ALTER TABLE `certificates_certificategenerationconfiguration`
  ADD CONSTRAINT `changed_by_id_refs_id_abb3a677` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `certificates_certificatehtmlviewconfiguration`
--
ALTER TABLE `certificates_certificatehtmlviewconfiguration`
  ADD CONSTRAINT `changed_by_id_refs_id_8584db17` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `certificates_certificatewhitelist`
--
ALTER TABLE `certificates_certificatewhitelist`
  ADD CONSTRAINT `user_id_refs_id_a7ba9306` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `certificates_examplecertificate`
--
ALTER TABLE `certificates_examplecertificate`
  ADD CONSTRAINT `example_cert_set_id_refs_id_bdd9e28a` FOREIGN KEY (`example_cert_set_id`) REFERENCES `certificates_examplecertificateset` (`id`);

--
-- Ограничения внешнего ключа таблицы `certificates_generatedcertificate`
--
ALTER TABLE `certificates_generatedcertificate`
  ADD CONSTRAINT `user_id_refs_id_8e23bfe2` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `contentstore_pushnotificationconfig`
--
ALTER TABLE `contentstore_pushnotificationconfig`
  ADD CONSTRAINT `changed_by_id_refs_id_e431b975` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `contentstore_videouploadconfig`
--
ALTER TABLE `contentstore_videouploadconfig`
  ADD CONSTRAINT `changed_by_id_refs_id_209c438f` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `cors_csrf_xdomainproxyconfiguration`
--
ALTER TABLE `cors_csrf_xdomainproxyconfiguration`
  ADD CONSTRAINT `changed_by_id_refs_id_3dfcfcb0` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `courseware_offlinecomputedgrade`
--
ALTER TABLE `courseware_offlinecomputedgrade`
  ADD CONSTRAINT `user_id_refs_id_38cf339d` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `courseware_studentfieldoverride`
--
ALTER TABLE `courseware_studentfieldoverride`
  ADD CONSTRAINT `student_id_refs_id_7b49c12b` FOREIGN KEY (`student_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `courseware_studentmodule`
--
ALTER TABLE `courseware_studentmodule`
  ADD CONSTRAINT `student_id_refs_id_79ba2570` FOREIGN KEY (`student_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `courseware_studentmodulehistory`
--
ALTER TABLE `courseware_studentmodulehistory`
  ADD CONSTRAINT `student_module_id_refs_id_e48636f4` FOREIGN KEY (`student_module_id`) REFERENCES `courseware_studentmodule` (`id`);

--
-- Ограничения внешнего ключа таблицы `courseware_xmodulestudentinfofield`
--
ALTER TABLE `courseware_xmodulestudentinfofield`
  ADD CONSTRAINT `student_id_refs_id_bfcfbe68` FOREIGN KEY (`student_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `courseware_xmodulestudentprefsfield`
--
ALTER TABLE `courseware_xmodulestudentprefsfield`
  ADD CONSTRAINT `student_id_refs_id_d7b9940b` FOREIGN KEY (`student_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `course_action_state_coursererunstate`
--
ALTER TABLE `course_action_state_coursererunstate`
  ADD CONSTRAINT `created_user_id_refs_id_1744bdeb` FOREIGN KEY (`created_user_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `updated_user_id_refs_id_1744bdeb` FOREIGN KEY (`updated_user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `course_creators_coursecreator`
--
ALTER TABLE `course_creators_coursecreator`
  ADD CONSTRAINT `user_id_refs_id_6a0e6044` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `course_groups_coursecohort`
--
ALTER TABLE `course_groups_coursecohort`
  ADD CONSTRAINT `course_user_group_id_refs_id_8febc00f` FOREIGN KEY (`course_user_group_id`) REFERENCES `course_groups_courseusergroup` (`id`);

--
-- Ограничения внешнего ключа таблицы `course_groups_courseusergrouppartitiongroup`
--
ALTER TABLE `course_groups_courseusergrouppartitiongroup`
  ADD CONSTRAINT `course_user_group_id_refs_id_145383c4` FOREIGN KEY (`course_user_group_id`) REFERENCES `course_groups_courseusergroup` (`id`);

--
-- Ограничения внешнего ключа таблицы `course_groups_courseusergroup_users`
--
ALTER TABLE `course_groups_courseusergroup_users`
  ADD CONSTRAINT `courseusergroup_id_refs_id_d26180aa` FOREIGN KEY (`courseusergroup_id`) REFERENCES `course_groups_courseusergroup` (`id`),
  ADD CONSTRAINT `user_id_refs_id_bf33b47a` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `credit_crediteligibility`
--
ALTER TABLE `credit_crediteligibility`
  ADD CONSTRAINT `course_id_refs_id_eede15d0` FOREIGN KEY (`course_id`) REFERENCES `credit_creditcourse` (`id`);

--
-- Ограничения внешнего ключа таблицы `credit_creditrequest`
--
ALTER TABLE `credit_creditrequest`
  ADD CONSTRAINT `course_id_refs_id_96abc610` FOREIGN KEY (`course_id`) REFERENCES `credit_creditcourse` (`id`),
  ADD CONSTRAINT `provider_id_refs_id_df6afe06` FOREIGN KEY (`provider_id`) REFERENCES `credit_creditprovider` (`id`);

--
-- Ограничения внешнего ключа таблицы `credit_creditrequirement`
--
ALTER TABLE `credit_creditrequirement`
  ADD CONSTRAINT `course_id_refs_id_a417c522` FOREIGN KEY (`course_id`) REFERENCES `credit_creditcourse` (`id`);

--
-- Ограничения внешнего ключа таблицы `credit_creditrequirementstatus`
--
ALTER TABLE `credit_creditrequirementstatus`
  ADD CONSTRAINT `requirement_id_refs_id_1f08312b` FOREIGN KEY (`requirement_id`) REFERENCES `credit_creditrequirement` (`id`);

--
-- Ограничения внешнего ключа таблицы `credit_historicalcreditrequest`
--
ALTER TABLE `credit_historicalcreditrequest`
  ADD CONSTRAINT `course_id_refs_id_b034099e` FOREIGN KEY (`course_id`) REFERENCES `credit_creditcourse` (`id`),
  ADD CONSTRAINT `history_user_id_refs_id_3ef1516a` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `provider_id_refs_id_72d984b8` FOREIGN KEY (`provider_id`) REFERENCES `credit_creditprovider` (`id`);

--
-- Ограничения внешнего ключа таблицы `credit_historicalcreditrequirementstatus`
--
ALTER TABLE `credit_historicalcreditrequirementstatus`
  ADD CONSTRAINT `history_user_id_refs_id_9342f9b4` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `requirement_id_refs_id_b49b13a7` FOREIGN KEY (`requirement_id`) REFERENCES `credit_creditrequirement` (`id`);

--
-- Ограничения внешнего ключа таблицы `dark_lang_darklangconfig`
--
ALTER TABLE `dark_lang_darklangconfig`
  ADD CONSTRAINT `changed_by_id_refs_id_5c5fe834` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `content_type_id_refs_id_288599e6` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `user_id_refs_id_c8665aa` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `django_comment_client_permission_roles`
--
ALTER TABLE `django_comment_client_permission_roles`
  ADD CONSTRAINT `permission_id_refs_name_b6302d27` FOREIGN KEY (`permission_id`) REFERENCES `django_comment_client_permission` (`name`),
  ADD CONSTRAINT `role_id_refs_id_c1b5c854` FOREIGN KEY (`role_id`) REFERENCES `django_comment_client_role` (`id`);

--
-- Ограничения внешнего ключа таблицы `django_comment_client_role_users`
--
ALTER TABLE `django_comment_client_role_users`
  ADD CONSTRAINT `role_id_refs_id_ab82c838` FOREIGN KEY (`role_id`) REFERENCES `django_comment_client_role` (`id`),
  ADD CONSTRAINT `user_id_refs_id_441b79e7` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `django_openid_auth_useropenid`
--
ALTER TABLE `django_openid_auth_useropenid`
  ADD CONSTRAINT `user_id_refs_id_be7162f0` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `djcelery_periodictask`
--
ALTER TABLE `djcelery_periodictask`
  ADD CONSTRAINT `crontab_id_refs_id_ebff5e74` FOREIGN KEY (`crontab_id`) REFERENCES `djcelery_crontabschedule` (`id`),
  ADD CONSTRAINT `interval_id_refs_id_f2054349` FOREIGN KEY (`interval_id`) REFERENCES `djcelery_intervalschedule` (`id`);

--
-- Ограничения внешнего ключа таблицы `djcelery_taskstate`
--
ALTER TABLE `djcelery_taskstate`
  ADD CONSTRAINT `worker_id_refs_id_4e3453a` FOREIGN KEY (`worker_id`) REFERENCES `djcelery_workerstate` (`id`);

--
-- Ограничения внешнего ключа таблицы `edxval_coursevideo`
--
ALTER TABLE `edxval_coursevideo`
  ADD CONSTRAINT `video_id_refs_id_7520c050` FOREIGN KEY (`video_id`) REFERENCES `edxval_video` (`id`);

--
-- Ограничения внешнего ключа таблицы `edxval_encodedvideo`
--
ALTER TABLE `edxval_encodedvideo`
  ADD CONSTRAINT `profile_id_refs_id_692d754` FOREIGN KEY (`profile_id`) REFERENCES `edxval_profile` (`id`),
  ADD CONSTRAINT `video_id_refs_id_176ce1a0` FOREIGN KEY (`video_id`) REFERENCES `edxval_video` (`id`);

--
-- Ограничения внешнего ключа таблицы `edxval_subtitle`
--
ALTER TABLE `edxval_subtitle`
  ADD CONSTRAINT `video_id_refs_id_788bc3d3` FOREIGN KEY (`video_id`) REFERENCES `edxval_video` (`id`);

--
-- Ограничения внешнего ключа таблицы `embargo_countryaccessrule`
--
ALTER TABLE `embargo_countryaccessrule`
  ADD CONSTRAINT `country_id_refs_id_f679fa73` FOREIGN KEY (`country_id`) REFERENCES `embargo_country` (`id`),
  ADD CONSTRAINT `restricted_course_id_refs_id_c792331c` FOREIGN KEY (`restricted_course_id`) REFERENCES `embargo_restrictedcourse` (`id`);

--
-- Ограничения внешнего ключа таблицы `embargo_embargoedstate`
--
ALTER TABLE `embargo_embargoedstate`
  ADD CONSTRAINT `changed_by_id_refs_id_d0205d39` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `embargo_ipfilter`
--
ALTER TABLE `embargo_ipfilter`
  ADD CONSTRAINT `changed_by_id_refs_id_22c1f5d3` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `external_auth_externalauthmap`
--
ALTER TABLE `external_auth_externalauthmap`
  ADD CONSTRAINT `user_id_refs_id_f8635f67` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `foldit_puzzlecomplete`
--
ALTER TABLE `foldit_puzzlecomplete`
  ADD CONSTRAINT `user_id_refs_id_37e9437b` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `foldit_score`
--
ALTER TABLE `foldit_score`
  ADD CONSTRAINT `user_id_refs_id_4c07957f` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `instructor_task_instructortask`
--
ALTER TABLE `instructor_task_instructortask`
  ADD CONSTRAINT `requester_id_refs_id_a97278e6` FOREIGN KEY (`requester_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `licenses_userlicense`
--
ALTER TABLE `licenses_userlicense`
  ADD CONSTRAINT `software_id_refs_id_f9e27be8` FOREIGN KEY (`software_id`) REFERENCES `licenses_coursesoftware` (`id`),
  ADD CONSTRAINT `user_id_refs_id_2f3a1cb3` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `lms_xblock_xblockasidesconfig`
--
ALTER TABLE `lms_xblock_xblockasidesconfig`
  ADD CONSTRAINT `changed_by_id_refs_id_552627bc` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `milestones_coursecontentmilestone`
--
ALTER TABLE `milestones_coursecontentmilestone`
  ADD CONSTRAINT `milestone_id_refs_id_d7fabedc` FOREIGN KEY (`milestone_id`) REFERENCES `milestones_milestone` (`id`),
  ADD CONSTRAINT `milestone_relationship_type_id_refs_id_d7ab186` FOREIGN KEY (`milestone_relationship_type_id`) REFERENCES `milestones_milestonerelationshiptype` (`id`);

--
-- Ограничения внешнего ключа таблицы `milestones_coursemilestone`
--
ALTER TABLE `milestones_coursemilestone`
  ADD CONSTRAINT `milestone_id_refs_id_cd764354` FOREIGN KEY (`milestone_id`) REFERENCES `milestones_milestone` (`id`),
  ADD CONSTRAINT `milestone_relationship_type_id_refs_id_874a03b6` FOREIGN KEY (`milestone_relationship_type_id`) REFERENCES `milestones_milestonerelationshiptype` (`id`);

--
-- Ограничения внешнего ключа таблицы `milestones_usermilestone`
--
ALTER TABLE `milestones_usermilestone`
  ADD CONSTRAINT `milestone_id_refs_id_af7fa460` FOREIGN KEY (`milestone_id`) REFERENCES `milestones_milestone` (`id`);

--
-- Ограничения внешнего ключа таблицы `mobile_api_mobileapiconfig`
--
ALTER TABLE `mobile_api_mobileapiconfig`
  ADD CONSTRAINT `changed_by_id_refs_id_97c2f4c8` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `notes_note`
--
ALTER TABLE `notes_note`
  ADD CONSTRAINT `user_id_refs_id_360715cc` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `notifications_articlesubscription`
--
ALTER TABLE `notifications_articlesubscription`
  ADD CONSTRAINT `articleplugin_ptr_id_refs_id_71ed584a` FOREIGN KEY (`articleplugin_ptr_id`) REFERENCES `wiki_articleplugin` (`id`),
  ADD CONSTRAINT `subscription_ptr_id_refs_id_75c0b518` FOREIGN KEY (`subscription_ptr_id`) REFERENCES `notify_subscription` (`id`);

--
-- Ограничения внешнего ключа таблицы `notify_notification`
--
ALTER TABLE `notify_notification`
  ADD CONSTRAINT `subscription_id_refs_id_baf93d4f` FOREIGN KEY (`subscription_id`) REFERENCES `notify_subscription` (`id`);

--
-- Ограничения внешнего ключа таблицы `notify_notificationtype`
--
ALTER TABLE `notify_notificationtype`
  ADD CONSTRAINT `content_type_id_refs_id_f2478378` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Ограничения внешнего ключа таблицы `notify_settings`
--
ALTER TABLE `notify_settings`
  ADD CONSTRAINT `user_id_refs_id_9a2911e6` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `notify_subscription`
--
ALTER TABLE `notify_subscription`
  ADD CONSTRAINT `notification_type_id_refs_key_baa41a19` FOREIGN KEY (`notification_type_id`) REFERENCES `notify_notificationtype` (`key`),
  ADD CONSTRAINT `settings_id_refs_id_3b7225d5` FOREIGN KEY (`settings_id`) REFERENCES `notify_settings` (`id`);

--
-- Ограничения внешнего ключа таблицы `oauth2_accesstoken`
--
ALTER TABLE `oauth2_accesstoken`
  ADD CONSTRAINT `client_id_refs_id_e566ebcc` FOREIGN KEY (`client_id`) REFERENCES `oauth2_client` (`id`),
  ADD CONSTRAINT `user_id_refs_id_c740ddb9` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `oauth2_client`
--
ALTER TABLE `oauth2_client`
  ADD CONSTRAINT `user_id_refs_id_c2e3e9a0` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `oauth2_grant`
--
ALTER TABLE `oauth2_grant`
  ADD CONSTRAINT `client_id_refs_id_b2f66ded` FOREIGN KEY (`client_id`) REFERENCES `oauth2_client` (`id`),
  ADD CONSTRAINT `user_id_refs_id_37f50fe6` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `oauth2_provider_trustedclient`
--
ALTER TABLE `oauth2_provider_trustedclient`
  ADD CONSTRAINT `client_id_refs_id_f6dfcacc` FOREIGN KEY (`client_id`) REFERENCES `oauth2_client` (`id`);

--
-- Ограничения внешнего ключа таблицы `oauth2_refreshtoken`
--
ALTER TABLE `oauth2_refreshtoken`
  ADD CONSTRAINT `access_token_id_refs_id_df7961b9` FOREIGN KEY (`access_token_id`) REFERENCES `oauth2_accesstoken` (`id`),
  ADD CONSTRAINT `client_id_refs_id_798730c8` FOREIGN KEY (`client_id`) REFERENCES `oauth2_client` (`id`),
  ADD CONSTRAINT `user_id_refs_id_78216905` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `shoppingcart_certificateitem`
--
ALTER TABLE `shoppingcart_certificateitem`
  ADD CONSTRAINT `course_enrollment_id_refs_id_8048c435` FOREIGN KEY (`course_enrollment_id`) REFERENCES `student_courseenrollment` (`id`),
  ADD CONSTRAINT `orderitem_ptr_id_refs_id_d3ebc4d0` FOREIGN KEY (`orderitem_ptr_id`) REFERENCES `shoppingcart_orderitem` (`id`);

--
-- Ограничения внешнего ключа таблицы `shoppingcart_coupon`
--
ALTER TABLE `shoppingcart_coupon`
  ADD CONSTRAINT `created_by_id_refs_id_259aadc` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `shoppingcart_couponredemption`
--
ALTER TABLE `shoppingcart_couponredemption`
  ADD CONSTRAINT `coupon_id_refs_id_c11a8022` FOREIGN KEY (`coupon_id`) REFERENCES `shoppingcart_coupon` (`id`),
  ADD CONSTRAINT `order_id_refs_id_f5db1967` FOREIGN KEY (`order_id`) REFERENCES `shoppingcart_order` (`id`),
  ADD CONSTRAINT `user_id_refs_id_5e9b8167` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `shoppingcart_courseregcodeitem`
--
ALTER TABLE `shoppingcart_courseregcodeitem`
  ADD CONSTRAINT `orderitem_ptr_id_refs_id_a466f07f` FOREIGN KEY (`orderitem_ptr_id`) REFERENCES `shoppingcart_orderitem` (`id`);

--
-- Ограничения внешнего ключа таблицы `shoppingcart_courseregistrationcode`
--
ALTER TABLE `shoppingcart_courseregistrationcode`
  ADD CONSTRAINT `created_by_id_refs_id_38397037` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `invoice_id_refs_id_995f0ae8` FOREIGN KEY (`invoice_id`) REFERENCES `shoppingcart_invoice` (`id`),
  ADD CONSTRAINT `invoice_item_id_refs_invoiceitem_ptr_id_8a5558e6` FOREIGN KEY (`invoice_item_id`) REFERENCES `shoppingcart_courseregistrationcodeinvoiceitem` (`invoiceitem_ptr_id`),
  ADD CONSTRAINT `order_id_refs_id_be36d837` FOREIGN KEY (`order_id`) REFERENCES `shoppingcart_order` (`id`);

--
-- Ограничения внешнего ключа таблицы `shoppingcart_courseregistrationcodeinvoiceitem`
--
ALTER TABLE `shoppingcart_courseregistrationcodeinvoiceitem`
  ADD CONSTRAINT `invoiceitem_ptr_id_refs_id_74a11b46` FOREIGN KEY (`invoiceitem_ptr_id`) REFERENCES `shoppingcart_invoiceitem` (`id`);

--
-- Ограничения внешнего ключа таблицы `shoppingcart_donation`
--
ALTER TABLE `shoppingcart_donation`
  ADD CONSTRAINT `orderitem_ptr_id_refs_id_b7138a4b` FOREIGN KEY (`orderitem_ptr_id`) REFERENCES `shoppingcart_orderitem` (`id`);

--
-- Ограничения внешнего ключа таблицы `shoppingcart_donationconfiguration`
--
ALTER TABLE `shoppingcart_donationconfiguration`
  ADD CONSTRAINT `changed_by_id_refs_id_b4a26b7f` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `shoppingcart_invoicehistory`
--
ALTER TABLE `shoppingcart_invoicehistory`
  ADD CONSTRAINT `invoice_id_refs_id_239c2b7c` FOREIGN KEY (`invoice_id`) REFERENCES `shoppingcart_invoice` (`id`);

--
-- Ограничения внешнего ключа таблицы `shoppingcart_invoiceitem`
--
ALTER TABLE `shoppingcart_invoiceitem`
  ADD CONSTRAINT `invoice_id_refs_id_5c894802` FOREIGN KEY (`invoice_id`) REFERENCES `shoppingcart_invoice` (`id`);

--
-- Ограничения внешнего ключа таблицы `shoppingcart_invoicetransaction`
--
ALTER TABLE `shoppingcart_invoicetransaction`
  ADD CONSTRAINT `created_by_id_refs_id_7259d0bb` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `invoice_id_refs_id_8e5b62ec` FOREIGN KEY (`invoice_id`) REFERENCES `shoppingcart_invoice` (`id`),
  ADD CONSTRAINT `last_modified_by_id_refs_id_7259d0bb` FOREIGN KEY (`last_modified_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `shoppingcart_order`
--
ALTER TABLE `shoppingcart_order`
  ADD CONSTRAINT `user_id_refs_id_e1195673` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `shoppingcart_orderitem`
--
ALTER TABLE `shoppingcart_orderitem`
  ADD CONSTRAINT `order_id_refs_id_7c77b3f0` FOREIGN KEY (`order_id`) REFERENCES `shoppingcart_order` (`id`),
  ADD CONSTRAINT `user_id_refs_id_d92ae410` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `shoppingcart_paidcourseregistration`
--
ALTER TABLE `shoppingcart_paidcourseregistration`
  ADD CONSTRAINT `course_enrollment_id_refs_id_dc061be6` FOREIGN KEY (`course_enrollment_id`) REFERENCES `student_courseenrollment` (`id`),
  ADD CONSTRAINT `orderitem_ptr_id_refs_id_d8709d99` FOREIGN KEY (`orderitem_ptr_id`) REFERENCES `shoppingcart_orderitem` (`id`);

--
-- Ограничения внешнего ключа таблицы `shoppingcart_registrationcoderedemption`
--
ALTER TABLE `shoppingcart_registrationcoderedemption`
  ADD CONSTRAINT `course_enrollment_id_refs_id_c9486127` FOREIGN KEY (`course_enrollment_id`) REFERENCES `student_courseenrollment` (`id`),
  ADD CONSTRAINT `order_id_refs_id_53a8a5c9` FOREIGN KEY (`order_id`) REFERENCES `shoppingcart_order` (`id`),
  ADD CONSTRAINT `redeemed_by_id_refs_id_4e320dc9` FOREIGN KEY (`redeemed_by_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `registration_code_id_refs_id_4d01e47b` FOREIGN KEY (`registration_code_id`) REFERENCES `shoppingcart_courseregistrationcode` (`id`);

--
-- Ограничения внешнего ключа таблицы `splash_splashconfig`
--
ALTER TABLE `splash_splashconfig`
  ADD CONSTRAINT `changed_by_id_refs_id_9125b21c` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `student_anonymoususerid`
--
ALTER TABLE `student_anonymoususerid`
  ADD CONSTRAINT `user_id_refs_id_c38f7a2a` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `student_courseaccessrole`
--
ALTER TABLE `student_courseaccessrole`
  ADD CONSTRAINT `user_id_refs_id_6ac23885` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `student_courseenrollment`
--
ALTER TABLE `student_courseenrollment`
  ADD CONSTRAINT `user_id_refs_id_ed37bc9d` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `student_courseenrollmentattribute`
--
ALTER TABLE `student_courseenrollmentattribute`
  ADD CONSTRAINT `enrollment_id_refs_id_974619de` FOREIGN KEY (`enrollment_id`) REFERENCES `student_courseenrollment` (`id`);

--
-- Ограничения внешнего ключа таблицы `student_dashboardconfiguration`
--
ALTER TABLE `student_dashboardconfiguration`
  ADD CONSTRAINT `changed_by_id_refs_id_eec78c18` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `student_entranceexamconfiguration`
--
ALTER TABLE `student_entranceexamconfiguration`
  ADD CONSTRAINT `user_id_refs_id_9c93dc16` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `student_languageproficiency`
--
ALTER TABLE `student_languageproficiency`
  ADD CONSTRAINT `user_profile_id_refs_id_ba5aae00` FOREIGN KEY (`user_profile_id`) REFERENCES `auth_userprofile` (`id`);

--
-- Ограничения внешнего ключа таблицы `student_linkedinaddtoprofileconfiguration`
--
ALTER TABLE `student_linkedinaddtoprofileconfiguration`
  ADD CONSTRAINT `changed_by_id_refs_id_9469646a` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `student_loginfailures`
--
ALTER TABLE `student_loginfailures`
  ADD CONSTRAINT `user_id_refs_id_e6a71045` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `student_manualenrollmentaudit`
--
ALTER TABLE `student_manualenrollmentaudit`
  ADD CONSTRAINT `enrolled_by_id_refs_id_a8059256` FOREIGN KEY (`enrolled_by_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `enrollment_id_refs_id_a87a89ac` FOREIGN KEY (`enrollment_id`) REFERENCES `student_courseenrollment` (`id`);

--
-- Ограничения внешнего ключа таблицы `student_passwordhistory`
--
ALTER TABLE `student_passwordhistory`
  ADD CONSTRAINT `user_id_refs_id_ed0987da` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `student_pendingemailchange`
--
ALTER TABLE `student_pendingemailchange`
  ADD CONSTRAINT `user_id_refs_id_a525fa67` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `student_pendingnamechange`
--
ALTER TABLE `student_pendingnamechange`
  ADD CONSTRAINT `user_id_refs_id_d9359b27` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `student_usersignupsource`
--
ALTER TABLE `student_usersignupsource`
  ADD CONSTRAINT `user_id_refs_id_38a4bd6e` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `student_userstanding`
--
ALTER TABLE `student_userstanding`
  ADD CONSTRAINT `changed_by_id_refs_id_450a33b` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `user_id_refs_id_450a33b` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `student_usertestgroup_users`
--
ALTER TABLE `student_usertestgroup_users`
  ADD CONSTRAINT `user_id_refs_id_8947584c` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `usertestgroup_id_refs_id_6d724f9e` FOREIGN KEY (`usertestgroup_id`) REFERENCES `student_usertestgroup` (`id`);

--
-- Ограничения внешнего ключа таблицы `submissions_score`
--
ALTER TABLE `submissions_score`
  ADD CONSTRAINT `student_item_id_refs_id_8cd97385` FOREIGN KEY (`student_item_id`) REFERENCES `submissions_studentitem` (`id`),
  ADD CONSTRAINT `submission_id_refs_id_9e39cf2e` FOREIGN KEY (`submission_id`) REFERENCES `submissions_submission` (`id`);

--
-- Ограничения внешнего ключа таблицы `submissions_scoresummary`
--
ALTER TABLE `submissions_scoresummary`
  ADD CONSTRAINT `highest_id_refs_id_1bdc0a18` FOREIGN KEY (`highest_id`) REFERENCES `submissions_score` (`id`),
  ADD CONSTRAINT `latest_id_refs_id_1bdc0a18` FOREIGN KEY (`latest_id`) REFERENCES `submissions_score` (`id`),
  ADD CONSTRAINT `student_item_id_refs_id_bd51e768` FOREIGN KEY (`student_item_id`) REFERENCES `submissions_studentitem` (`id`);

--
-- Ограничения внешнего ключа таблицы `submissions_submission`
--
ALTER TABLE `submissions_submission`
  ADD CONSTRAINT `student_item_id_refs_id_b5cccc` FOREIGN KEY (`student_item_id`) REFERENCES `submissions_studentitem` (`id`);

--
-- Ограничения внешнего ключа таблицы `survey_surveyanswer`
--
ALTER TABLE `survey_surveyanswer`
  ADD CONSTRAINT `form_id_refs_id_f4c79f29` FOREIGN KEY (`form_id`) REFERENCES `survey_surveyform` (`id`),
  ADD CONSTRAINT `user_id_refs_id_e0ad4b5e` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `teams_courseteammembership`
--
ALTER TABLE `teams_courseteammembership`
  ADD CONSTRAINT `team_id_refs_id_679497a3` FOREIGN KEY (`team_id`) REFERENCES `teams_courseteam` (`id`),
  ADD CONSTRAINT `user_id_refs_id_abc442bf` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `user_api_usercoursetag`
--
ALTER TABLE `user_api_usercoursetag`
  ADD CONSTRAINT `user_id_refs_id_47a9a367` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `user_api_userorgtag`
--
ALTER TABLE `user_api_userorgtag`
  ADD CONSTRAINT `user_id_refs_id_e54b717f` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `user_api_userpreference`
--
ALTER TABLE `user_api_userpreference`
  ADD CONSTRAINT `user_id_refs_id_f3473b9e` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `util_ratelimitconfiguration`
--
ALTER TABLE `util_ratelimitconfiguration`
  ADD CONSTRAINT `changed_by_id_refs_id_76a26307` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `verify_student_incoursereverificationconfiguration`
--
ALTER TABLE `verify_student_incoursereverificationconfiguration`
  ADD CONSTRAINT `changed_by_id_refs_id_ab2dfc2a` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `verify_student_skippedreverification`
--
ALTER TABLE `verify_student_skippedreverification`
  ADD CONSTRAINT `checkpoint_id_refs_id_de8541b1` FOREIGN KEY (`checkpoint_id`) REFERENCES `verify_student_verificationcheckpoint` (`id`),
  ADD CONSTRAINT `user_id_refs_id_f26a5780` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `verify_student_softwaresecurephotoverification`
--
ALTER TABLE `verify_student_softwaresecurephotoverification`
  ADD CONSTRAINT `reviewing_user_id_refs_id_d6ea4207` FOREIGN KEY (`reviewing_user_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `user_id_refs_id_d6ea4207` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `window_id_refs_id_fce8f38a` FOREIGN KEY (`window_id`) REFERENCES `reverification_midcoursereverificationwindow` (`id`);

--
-- Ограничения внешнего ключа таблицы `verify_student_verificationcheckpoint_photo_verification`
--
ALTER TABLE `verify_student_verificationcheckpoint_photo_verification`
  ADD CONSTRAINT `softwaresecurephotoverification_id_refs_id_5efb90e` FOREIGN KEY (`softwaresecurephotoverification_id`) REFERENCES `verify_student_softwaresecurephotoverification` (`id`),
  ADD CONSTRAINT `verificationcheckpoint_id_refs_id_9a387f43` FOREIGN KEY (`verificationcheckpoint_id`) REFERENCES `verify_student_verificationcheckpoint` (`id`);

--
-- Ограничения внешнего ключа таблицы `verify_student_verificationstatus`
--
ALTER TABLE `verify_student_verificationstatus`
  ADD CONSTRAINT `checkpoint_id_refs_id_70d70b21` FOREIGN KEY (`checkpoint_id`) REFERENCES `verify_student_verificationcheckpoint` (`id`),
  ADD CONSTRAINT `user_id_refs_id_bfc6370` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `wiki_article`
--
ALTER TABLE `wiki_article`
  ADD CONSTRAINT `current_revision_id_refs_id_bafac304` FOREIGN KEY (`current_revision_id`) REFERENCES `wiki_articlerevision` (`id`),
  ADD CONSTRAINT `group_id_refs_id_108bfee4` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `owner_id_refs_id_9e14b583` FOREIGN KEY (`owner_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `wiki_articleforobject`
--
ALTER TABLE `wiki_articleforobject`
  ADD CONSTRAINT `article_id_refs_id_5099436` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`),
  ADD CONSTRAINT `content_type_id_refs_id_37828764` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Ограничения внешнего ключа таблицы `wiki_articleplugin`
--
ALTER TABLE `wiki_articleplugin`
  ADD CONSTRAINT `article_id_refs_id_92c648ca` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`);

--
-- Ограничения внешнего ключа таблицы `wiki_articlerevision`
--
ALTER TABLE `wiki_articlerevision`
  ADD CONSTRAINT `article_id_refs_id_5c88570a` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`),
  ADD CONSTRAINT `previous_revision_id_refs_id_a951e36b` FOREIGN KEY (`previous_revision_id`) REFERENCES `wiki_articlerevision` (`id`),
  ADD CONSTRAINT `user_id_refs_id_fbb26714` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `wiki_articlesubscription`
--
ALTER TABLE `wiki_articlesubscription`
  ADD CONSTRAINT `articleplugin_ptr_id_refs_id_cbce00e3` FOREIGN KEY (`articleplugin_ptr_id`) REFERENCES `wiki_articleplugin` (`id`),
  ADD CONSTRAINT `subscription_ptr_id_refs_id_ae89f475` FOREIGN KEY (`subscription_ptr_id`) REFERENCES `notify_subscription` (`id`);

--
-- Ограничения внешнего ключа таблицы `wiki_attachment`
--
ALTER TABLE `wiki_attachment`
  ADD CONSTRAINT `current_revision_id_refs_id_2198feb4` FOREIGN KEY (`current_revision_id`) REFERENCES `wiki_attachmentrevision` (`id`),
  ADD CONSTRAINT `reusableplugin_ptr_id_refs_articleplugin_ptr_id_6644e87a` FOREIGN KEY (`reusableplugin_ptr_id`) REFERENCES `wiki_reusableplugin` (`articleplugin_ptr_id`);

--
-- Ограничения внешнего ключа таблицы `wiki_attachmentrevision`
--
ALTER TABLE `wiki_attachmentrevision`
  ADD CONSTRAINT `attachment_id_refs_reusableplugin_ptr_id_640583da` FOREIGN KEY (`attachment_id`) REFERENCES `wiki_attachment` (`reusableplugin_ptr_id`),
  ADD CONSTRAINT `previous_revision_id_refs_id_41bbf5` FOREIGN KEY (`previous_revision_id`) REFERENCES `wiki_attachmentrevision` (`id`),
  ADD CONSTRAINT `user_id_refs_id_2eaca84c` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `wiki_image`
--
ALTER TABLE `wiki_image`
  ADD CONSTRAINT `revisionplugin_ptr_id_refs_articleplugin_ptr_id_fc42a0b1` FOREIGN KEY (`revisionplugin_ptr_id`) REFERENCES `wiki_revisionplugin` (`articleplugin_ptr_id`);

--
-- Ограничения внешнего ключа таблицы `wiki_imagerevision`
--
ALTER TABLE `wiki_imagerevision`
  ADD CONSTRAINT `revisionpluginrevision_ptr_id_refs_id_5b9fc791` FOREIGN KEY (`revisionpluginrevision_ptr_id`) REFERENCES `wiki_revisionpluginrevision` (`id`);

--
-- Ограничения внешнего ключа таблицы `wiki_reusableplugin`
--
ALTER TABLE `wiki_reusableplugin`
  ADD CONSTRAINT `articleplugin_ptr_id_refs_id_4ca661fd` FOREIGN KEY (`articleplugin_ptr_id`) REFERENCES `wiki_articleplugin` (`id`);

--
-- Ограничения внешнего ключа таблицы `wiki_reusableplugin_articles`
--
ALTER TABLE `wiki_reusableplugin_articles`
  ADD CONSTRAINT `article_id_refs_id_2f51faad` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`),
  ADD CONSTRAINT `reusableplugin_id_refs_articleplugin_ptr_id_44b45e30` FOREIGN KEY (`reusableplugin_id`) REFERENCES `wiki_reusableplugin` (`articleplugin_ptr_id`);

--
-- Ограничения внешнего ключа таблицы `wiki_revisionplugin`
--
ALTER TABLE `wiki_revisionplugin`
  ADD CONSTRAINT `articleplugin_ptr_id_refs_id_cac31401` FOREIGN KEY (`articleplugin_ptr_id`) REFERENCES `wiki_articleplugin` (`id`),
  ADD CONSTRAINT `current_revision_id_refs_id_44938e26` FOREIGN KEY (`current_revision_id`) REFERENCES `wiki_revisionpluginrevision` (`id`);

--
-- Ограничения внешнего ключа таблицы `wiki_revisionpluginrevision`
--
ALTER TABLE `wiki_revisionpluginrevision`
  ADD CONSTRAINT `plugin_id_refs_articleplugin_ptr_id_41bbc69c` FOREIGN KEY (`plugin_id`) REFERENCES `wiki_revisionplugin` (`articleplugin_ptr_id`),
  ADD CONSTRAINT `previous_revision_id_refs_id_78fffe43` FOREIGN KEY (`previous_revision_id`) REFERENCES `wiki_revisionpluginrevision` (`id`),
  ADD CONSTRAINT `user_id_refs_id_32d8f395` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `wiki_simpleplugin`
--
ALTER TABLE `wiki_simpleplugin`
  ADD CONSTRAINT `article_revision_id_refs_id_6df37b12` FOREIGN KEY (`article_revision_id`) REFERENCES `wiki_articlerevision` (`id`),
  ADD CONSTRAINT `articleplugin_ptr_id_refs_id_a25cbfd2` FOREIGN KEY (`articleplugin_ptr_id`) REFERENCES `wiki_articleplugin` (`id`);

--
-- Ограничения внешнего ключа таблицы `wiki_urlpath`
--
ALTER TABLE `wiki_urlpath`
  ADD CONSTRAINT `article_id_refs_id_971759c9` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`),
  ADD CONSTRAINT `parent_id_refs_id_52d1e703` FOREIGN KEY (`parent_id`) REFERENCES `wiki_urlpath` (`id`),
  ADD CONSTRAINT `site_id_refs_id_f4bbaaa2` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`);

--
-- Ограничения внешнего ключа таблицы `workflow_assessmentworkflowcancellation`
--
ALTER TABLE `workflow_assessmentworkflowcancellation`
  ADD CONSTRAINT `workflow_id_refs_id_9b9e066a` FOREIGN KEY (`workflow_id`) REFERENCES `workflow_assessmentworkflow` (`id`);

--
-- Ограничения внешнего ключа таблицы `workflow_assessmentworkflowstep`
--
ALTER TABLE `workflow_assessmentworkflowstep`
  ADD CONSTRAINT `workflow_id_refs_id_69d0b483` FOREIGN KEY (`workflow_id`) REFERENCES `workflow_assessmentworkflow` (`id`);

--
-- Ограничения внешнего ключа таблицы `xblock_config_studioconfig`
--
ALTER TABLE `xblock_config_studioconfig`
  ADD CONSTRAINT `changed_by_id_refs_id_6ef7f7d7` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `xblock_django_xblockdisableconfig`
--
ALTER TABLE `xblock_django_xblockdisableconfig`
  ADD CONSTRAINT `changed_by_id_refs_id_1ff69d70` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
