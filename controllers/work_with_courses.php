<?php
    require_once("db.php");

    function deleteCourses($serializeVal) {
        for ($i = 0; $i < count($serializeVal); $i++) {
            $courseID = $serializeVal[$i]["name"];
            mysql_query("DELETE
                         FROM `student_courseaccessrole`
                         WHERE `course_id` = '$courseID'") or die(mysql_error());
        }
    }

    function changeInfoCourses($courseID, $serializeVal) {
        $staffs = ", " . $serializeVal[0]["value"];
        $subject = $serializeVal[1]["value"];
        $terms = $serializeVal[2]["value"];
        $bonuses = $serializeVal[3]["value"];
        mysql_query("UPDATE `fspo_courseinfo`
                     SET `staffs` = CONCAT(`staffs`, '$staffs'),
                         `subject` = '$subject',
                         `terms` = '$terms',
                         `bonuses` = '$bonuses'
                     WHERE `course_id` = '$courseID'");
    }

    switch ($_POST["status"]) {
        case 1:
            deleteCourses($_POST["serializeValue"]);
            break;
        case 2:
            changeInfoCourses($_POST["courseID"], $_POST["serializeValue"]);
    }
?>
