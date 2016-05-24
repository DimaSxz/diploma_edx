<?php

    session_start();
    require_once('../controllers/db.php');
    
    $user_id = $_SESSION['user_id'];
    $selected_subjects = $_POST['selected_subjects'];
    mysql_query("DELETE FROM user_subjects WHERE user_id = '$user_id'");
    foreach ($selected_subjects as $selected_subject) {
        mysql_query("INSERT INTO user_subjects(user_id, subject_id) VALUES('$user_id', '$selected_subject')");
    }

    print_r($selected_subjects);

?>