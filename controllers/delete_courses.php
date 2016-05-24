<?php
    require_once('../controllers/db.php');

    $checkArray = $_POST['checkArray'];
    foreach ($checkArray as $oneCheck) {
        mysql_query("DELETE FROM courses WHERE id = '$oneCheck[value]'");
    }

    $result = mysql_query('SELECT * FROM courses');

    if (mysql_num_rows($result) > 0) {
        echo 1;
    } else {
        echo 0;
    }

?>