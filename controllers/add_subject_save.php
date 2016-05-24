<?php

    session_start();
    require_once('../controllers/db.php');
    
    $user_id = $_SESSION['id'];
    $selected_subjects = $_POST['selected_subjects'];
    mysql_query("DELETE FROM user_subjects WHERE user_id = '$user_id'") or die(mysql_error());
    foreach ($selected_subjects as $selected_subject) {
        mysql_query("INSERT INTO user_subjects(user_id, subject_id) VALUES('$user_id', '$selected_subject')") or die(mysql_error());
    }

    print_r($selected_subjects);

?>