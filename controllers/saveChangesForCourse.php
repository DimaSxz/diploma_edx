<?php
    require_once("db.php");

    $query = "UPDATE courses SET ";

    $_POST['start_date'] = date('Y-m-d H:i:s', strtotime($_POST['start_date']));
    $_POST['end_date'] = date('Y-m-d H:i:s', strtotime($_POST['end_date']));

    foreach($_POST as $key => $value) {
        if ($key != "id" && $value != '') {
            $query .= $key . "='" . $value . "', ";   
        }
    }

    $query = substr($query, 0, strlen($query)-2);
    $query .= " WHERE id = " . $_POST['id'];
    mysql_query($query) or die(mysql_error());
    $short_title = mysql_fetch_assoc(mysql_query("SELECT short_title FROM subjects WHERE id = '$_POST[subject_id]'") or die(mysql_error()));

    echo $short_title['short_title'];

?>