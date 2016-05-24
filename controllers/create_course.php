<?php
    
    session_start();
    require_once('db.php');

    function inspectCourseTitle(&$answers, $title) {
        if ($title == '') {
            $answers['course_title'] = 'empty';
        } else {
            $answers['course_title'] = 'all_good';
        }
    }

    function inspectSubject(&$answers, $subject) {
        if ($subject == '' || $subject == "Вам требуется добавить дисциплины") {
            $answers['subject'] = 'empty';
        } else {
            $answers['subject'] = 'all_good';
        }
    }

    function inspectDescription(&$answers, $description) {
        if ($description == '') {
            $answers['description'] = 'empty';
        } else {
            $answers['description'] = 'all_good';
        }
    }

    $course_title = $_POST['course_title'];
    $start_date = date('Y-m-d H:i:s', strtotime($_POST['start_date']));
    $end_date = date('Y-m-d H:i:s', strtotime($_POST['end_date']));
    $subject = $_POST['subject'];
    $description = $_POST['description'];
    
    $answers = array();

    inspectCourseTitle($answers, $course_title);
    inspectSubject($answers, $subject);
    inspectDescription($answers, $description);

    if ($answers['course_title'] == 'all_good' && $answers['subject'] == 'all_good' && $answers['description'] == 'all_good') {
        mysql_query("INSERT INTO courses(user_id, title, start_date, end_date, subject_id, description) VALUES('$_SESSION[user_id]', '$course_title', '$start_date', '$end_date', '$subject', '$description')");
    }

    echo json_encode($answers);
?>