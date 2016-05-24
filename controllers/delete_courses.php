<?php
    require_once('../controllers/db.php');

    $checkArray = $_POST['checkArray'];
    foreach ($checkArray as $oneCheck) {
        mysql_query("DELETE FROM courses WHERE id = '$oneCheck[value]'") or die(mysql_error());
    }

    $result = mysql_query('SELECT * FROM courses') or die(mysql_error());

    if (mysql_num_rows($result) > 0) {
        echo 1;
    } else {
        echo 0;
    }

?>