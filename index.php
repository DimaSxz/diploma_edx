<?php

/*Show Errors*/
ini_set("display_errors",1);
error_reporting(E_ALL);
ini_set('error_reporting',2047);
ini_set('display_startup_errors', 1);
ini_set("max_execution_time", "60");

session_start();

require_once('controllers/db.php');
require_once('controllers/is_auth.php');

$action = (isset($_GET['action'])) ? $_GET['action'] : 'index';

switch($action)
{
    case "index":
        if(is_auth())
            header("Location: views/main.php");
        else
            header("Location: views/entry.php");
        break;
    case "delete_image":
        header("Location: controllers/delete_image.php");
        break;
    case "main":
    case "lk":
        header("Location: views/main.php");
        break;
    case "edit_profile":
        header("Location: views/edit_profile.php");
        break;
    case "save_profile":
        header("Location: controllers/save_profile.php");
        break;
    case "create_course":
        header("Location: views/add_course.php");
        break;
    case "watch_courses":
        header("Location: views/watch_courses.php");
        break;
    case "add_subject":
        header("Location: views/add_subject.php");
        break;
    case "logout":
        session_unset();
        session_destroy();
    case "entry":
        header("Location: views/entry.php");
        break;
    case "search_users":
        header("Location: views/search_users.php");
        break;
	case "ratingOfAllUsers":
		header("Location: views/rating.php");
		break;
	case "studentsRating":
		header("Location: views/rating.php?mode=students");
		break;
	case "courseRating":
		header("Location: views/rating.php?mode=courses");
		break;
	case "complexity":
		header("Location: views/complexity.php");
		break;
    default:
        echo "404 ERROR! Page not found...<br>";
        break;
}

?>
