<?php
    require_once("db.php");

    function getNames($name) {
        $arrNames = array();
        $select = mysql_query("SELECT `a`.`user_id`, `a`.`name`, `b`.`is_staff`, `b`.`is_superuser`
                               FROM `auth_userprofile` AS `a`
                               LEFT JOIN `auth_user` AS `b`
                               ON `b`.`id` = `a`.`user_id`
                               WHERE `name` LIKE '%$name%'")
                               or die(mysql_error());
        while ($result = mysql_fetch_assoc($select)) {
            $arrNames[] = $result;
        }
        return $arrNames;
    }

    function changePermissions($userID, $permissions) {
        switch($permissions) {
            case "1":
                mysql_query("UPDATE `auth_user`
                             SET `is_staff` = 0, `is_superuser` = 0
                             WHERE `id` = '$userID'") or die(mysql_error());
            break;
            case "2":
                mysql_query("UPDATE `auth_user`
                             SET `is_staff` = 1, `is_superuser` = 0
                             WHERE `id` = '$userID'") or die(mysql_error());
                break;
            case "3":
                mysql_query("UPDATE `auth_user`
                             SET `is_staff` = 1, `is_superuser` = 1
                             WHERE `id` = '$userID'") or die(mysql_error());
                break;
        }
        return "good";
    }

    function getUserPerm($username) {
        $select = mysql_query("SELECT `is_staff`, `is_superuser`
                               FROM `auth_user`
                               WHERE `username` = '$username'") or die(mysql_error());
        return mysql_fetch_assoc($select);
    }

    function getCourses($userID, $permissions) {
        $arrCourses = array(0 => 0);
        switch ($permissions) {
            case "1":
                $select = mysql_query("SELECT `a`.`course_id`, `a`.`created`, `b`.`org`, `c`.`download_url`
                                       FROM `student_courseenrollment` AS `a`
                                       LEFT JOIN `student_courseaccessrole` AS `b`
                                       ON `a`.`course_id` = `b`.`course_id`
                                       LEFT JOIN `certificates_generatedcertificate` AS `c`
                                       ON `a`.`course_id` = `c`.`course_id`
                                       WHERE `a`.`user_id` = '$userID'
                                       AND `a`.`is_active` = '1'") or die(mysql_error());
                while ($result = mysql_fetch_assoc($select)) {
                    $arrCourses[] = $result;
                    $date = new DateTime($result["created"]);
                    $arrCourses[count($arrCourses)-1]["created"] = $date -> format("d.m.Y");
                }
                break;
            default:
                $arrCourses[0] = 1;
                $select = mysql_query("SELECT DISTINCT `a`.`course_id`, `a`.`org`, `b`.`created`
                                       FROM `student_courseaccessrole` AS `a`
                                       LEFT JOIN `course_structures_coursestructure` AS `b`
                                       ON `a`.`course_id` = `b`.`course_id`
                                       WHERE `a`.`user_id` = '$userID'") or die(mysql_error());
                while ($result = mysql_fetch_assoc($select)) {
                    $arrCourses[] = $result;
                    $date = new DateTime($result["created"]);
                    $arrCourses[count($arrCourses)-1]["created"] = $date -> format("d.m.Y");
                }
        }
        return $arrCourses;
    }

    function getCoursesForAppoint($sessionID, $userID) {
        $arrCourses = array();
        $select = mysql_query("SELECT DISTINCT `course_id`
                               FROM `student_courseaccessrole`
                               WHERE `course_id`
                               NOT IN (SELECT DISTINCT `course_id`
                                       FROM `student_courseaccessrole`
                                       WHERE `user_id` = '$userID')
                               AND `user_id` = '$sessionID'") or die(mysql_error());
        while ($result = mysql_fetch_assoc($select)) {
            $arrCourses[] = $result;
        }
        return $arrCourses;
    }

    function appointToCourse($userID, $courseID) {
        list($courseBegin, $courseBase) = split(":", $courseID);
        $courseElem = explode("+", $courseBase, 3);
        mysql_query("INSERT INTO `student_courseaccessrole` (`org`, `course_id`, `role`, `user_id`)
                     VALUES('$courseElem[0]', '$courseID', 'staff', '$userID')");
        mysql_query("UPDATE `fspo_courseinfo`
                     SET `staffs` = CONCAT(`staffs`, CONCAT(', ', (SELECT `name`
                                                                   FROM `auth_userprofile`
                                                                   WHERE `user_id` = '$userID')))
                     WHERE `course_id` = '$courseID'") or die(mysql_error());
    }

    function deleteUserData($userID) {
        mysql_query("DELETE
                     FROM `auth_registration`
                     WHERE `user_id` = '$userID'") or die(mysql_error());
        mysql_query("DELETE
                     FROM `auth_userprofile`
                     WHERE `user_id` = '$userID'") or die(mysql_error());
        mysql_query("DELETE
                     FROM `user_api_userpreference`
                     WHERE `user_id` = '$userID'") or die(mysql_error());
        mysql_query("DELETE
                     FROM `auth_user`
                     WHERE `id` = '$userID'") or die(mysql_error());
    }

    switch ($_POST["status"]) {
        case 1:
            echo json_encode(getNames($_POST["name"]));
            break;
        case 2:
            echo json_encode(changePermissions($_POST["userID"], $_POST["permissions"]));
            break;
        case 3:
            echo json_encode(getCourses($_POST["userID"], $_POST["permissions"]));
            break;
        case 4:
            deleteUserData($_POST["userID"]);
            break;
        case 5:
            echo json_encode(getCoursesForAppoint($_POST["sessionID"], $_POST["userID"]));
            break;
        case 6:
            appointToCourse($_POST["userID"], $_POST["courseID"]);
    }
?>
