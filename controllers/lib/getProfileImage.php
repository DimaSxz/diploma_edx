<?php
    require_once('../controllers/db.php');
    function getProfileImage($angle = null){
        $select = mysql_query("SELECT `profile_image`, `angle` FROM `auth_userprofile` WHERE `user_id`='$_SESSION[user_id]'") or die(mysql_error());    
        $select = mysql_fetch_assoc($select);
        
        if($select['profile_image']===NULL)
            return "../images/avatar.png";
        else
        {
            if($angle==null)
                $angle=$select['angle'];
            $img = '../images/users/'.$_SESSION['user_id'].'/'.$select['profile_image'];
            if($angle == 'first' || $angle == 0)
            {
                return $img;
            }
            else{
                $size=getimagesize($img);
                switch($size['mime']){
                    case 'image/jpeg':
                        return $img.'_'.$select['angle']."_.jpeg";
                        break;
                    case 'image/gif':
                        return $img.'_'.$select['angle']."_.gif";
                        break;
                    default:
                        return "../images/avatar.png";
                }
            }
        }
    }

    function getProfileMiniImage(){
        $select = mysql_query("SELECT `profile_image` FROM `auth_userprofile` WHERE `user_id`='$_SESSION[user_id]'") or die(mysql_error());    
        $select = mysql_fetch_assoc($select);
        
        if($select['profile_image']===NULL)
            return "../images/avatar.png";
        else{ 
            $size = getimagesize('../images/users/'.$_SESSION['user_id'].'/'.$select['profile_image']);
            switch($size['mime']){
                case 'image/jpeg':
                    return '../images/users/'.$_SESSION['user_id'].'/'.$select['profile_image'].'_min.jpeg';
                    break;
                case 'image/png':
                    return '../images/users/'.$_SESSION['user_id'].'/'.$select['profile_image'].'_min.png';
                    break;
                case 'image/gif':
                    return '../images/users/'.$_SESSION['user_id'].'/'.$select['profile_image'].'_min.gif';
                    break;
                default:
                    return false;
            }
        }
    }

?>