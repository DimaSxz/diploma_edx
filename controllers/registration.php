<?php

    require_once('db.php');
    require_once('lib/password.php');

    function inspectName(&$answers, $name, $index) {
        if ($name == '') {
            $answers[$index] = 'empty';
        } else {
            $answers[$index] = 'all_good';
        }
    }

    function inspectLogin(&$answers, $login) {
        $expLogin = "/^[a-zA-Z0-9_-]+$/";
        if ($login == '') {
            $answers['login'] = 'empty';
            return;
        } else if (!preg_match($expLogin, $login)) {
            $answers['login'] = 'regular_error';
            return;
        } else {
            $result_login = mysql_fetch_assoc(mysql_query("SELECT username FROM auth_user WHERE username = '$login'"));
            if ($login == $result_login['username']) {    
                $answers['login'] = 'login_exists';
                return;
            }
        }
        $answers['login'] = 'all_good';
    }

    function inspectPassword(&$answers, $password) {
        $expPassword = "/^[a-zA-Z0-9_-]{6,20}$/";
        if ($password == '') {
            $answers['password'] = 'empty';
        } else if (!preg_match($expPassword, $password)) {
            $answers['password'] = 'regular_error';
        } else {
            $answers['password'] = 'all_good';
        }
    }

    $last_name = $_POST['last_name'];
    $first_name = $_POST['first_name'];
    $middle_name = $_POST['middle_name'];
    $login = $_POST['login'];
    $password = $_POST['password'];
    
    $answers = array();

    inspectName($answers, $last_name, 'last_name');
    inspectName($answers, $first_name, 'first_name');
    inspectName($answers, $middle_name, 'middle_name');
    inspectLogin($answers, $login);
    inspectPassword($answers, $password);

    if ($answers['last_name'] == 'all_good' && $answers['first_name'] == 'all_good' && $answers['middle_name'] == 'all_good'
        && $answers['login'] == 'all_good' && $answers['password'] == 'all_good') {
        $full_name = $last_name . ' ' . $first_name . ' ' . $middle_name;
        $password = password_hash($password, PASSWORD_BCRYPT);
        mysql_query("INSERT INTO auth_user(`username`, `password`, `account_type`) VALUES('$login', '$password', '$_POST[account_type]')") or die(mysql_error());
        $last_id = mysql_insert_id();
        mysql_query("INSERT INTO auth_userprofile(`user_id`, `name`) VALUES('$last_id', '$full_name')") or die(mysql_error());
    }

    echo json_encode($answers);
?>