<?php

    session_start();

    require_once('db.php');

    $result = mysql_query("SELECT `auth_user`.`id`, `username`, `name`, `password`, `is_staff`, `is_superuser` FROM `auth_user` INNER JOIN `auth_userprofile` ON `auth_user`.`id` = `auth_userprofile`.`user_id` WHERE `username`='$_POST[login]'") or die(mysql_error());

    $answer = "good";
	$pass ='';
    if(mysql_num_rows($result)>0)
    {
        while($user=mysql_fetch_assoc($result))
        {
			unset($user['password']);
			$_SESSION=$user;
			$_SESSION['is_auth']=true;
        }
    }
    else{
        $answer = "bad";
        session_destroy();
    }
    echo $answer;
?>
