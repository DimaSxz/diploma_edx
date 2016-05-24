<?php
    function is_auth()
    {
        session_start();
        if(isset($_SESSION['user_id']) && isset($_SESSION['name'])){
            
            $content = mysql_connect('localhost', 'root', '') or die('Could not connect to database because: '.mysql_error());
            mysql_select_db('edxapp') or die("Could not select database");
            mysql_query('set names utf8');
            
            $result=mysql_query("SELECT `user_id`, `name`, `profile_image` FROM `auth_userprofile` WHERE `user_id` = '$_SESSION[id]' AND `name` = '$_SESSION[name]'") or die(mysql_error());
            
            mysql_close($content);
            
            if(mysql_num_rows($result)<1)
                return false;
            else{
                while($user=mysql_fetch_assoc($result)){
                    $_SESSION=$user;
                }
                $_SESSION['is_auth']=true;
                return true;
            }
        }
        else return false;
    }

?>