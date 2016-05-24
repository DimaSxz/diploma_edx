<?php
    session_start();
    require_once('db.php');
    
    mysql_query("UPDATE `auth_userprofile` SET `profile_image`=null, `angle`='0', `crop`=null WHERE `user_id`='$_SESSION[user_id]'") or die(mysql_error());

    header("Location: ../index.php?action=edit_profile");

?>