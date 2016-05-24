<?php
    
    session_start();

    require_once('db.php');
//    require_once('lib/password.php');

	function pass_verify($pass, $dbpass){
		if("pbkdf2_".hash('sha256',$pass) == $dbpass) return true;
		return false;
	}

    $result = mysql_query("SELECT `auth_user`.`id`, `name`, `password` FROM `auth_user` INNER JOIN `auth_userprofile` ON `auth_user`.`id` = `auth_userprofile`.`user_id` WHERE `username`='$_POST[login]'") or die(mysql_error());

    $answer = "good";
$pass ='';
    if(mysql_num_rows($result)>0)
    {
        while($user=mysql_fetch_assoc($result))
        {
			$pass=$user['password'];
            if(pass_verify($_POST['password'], $user['password']))
//            if(password_verify($_POST['password'], $user['password']))
            {
                unset($user['password']);
                $_SESSION=$user;
                $_SESSION['is_auth']=true;
            }
            else{
                $answer = "bad";
                session_destroy();
            }
        }
    }
    else{
        $answer = "bad";
        session_destroy();
    }
//    echo $answer;
	echo json_encode(array(
				'input' => "pbkdf2_".hash('sha256',$_POST['password']),
				'pass' => $pass
			));
?>