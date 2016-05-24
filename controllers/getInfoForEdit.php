<?php
    require_once("../controllers/db.php");
    $edit_course_id = $_POST['edit_course_id'];
    
    $result = mysql_query("SELECT title, start_date, end_date, subject_id, description FROM courses WHERE id = '$edit_course_id'");

    echo json_encode(mysql_fetch_assoc($result));
?>