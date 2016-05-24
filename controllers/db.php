<?php

//    $content = mysql_connect('localhost:8889', 'root', 'root') or die('Could not connect to database because: '.mysql_error());
    $content = mysql_connect('localhost', 'root', '') or die('Could not connect to database because: '.mysql_error());
    mysql_select_db('edxapp') or die("Could not select database");
    mysql_query('set names utf8');

?>