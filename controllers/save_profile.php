<?php
    session_start();
    require_once('./lib/getProfileImage.php');
    require_once('./lib/translate.php');
    require_once('db.php');

function resizeImage($file_name = null)
{
    if($file_name == null)
    {
        $query = mysql_query("SELECT `profile_image` FROM `auth_userprofile` WHERE `user_id` = '$_SESSION[id]'") or die(mysql_error());
        $select = mysql_fetch_assoc($query);
        $file_name=$select['profile_image'];
    }
    if($file_name == null)
        return false;
    
    $crop=$_POST['x1'].' '.$_POST['y1'].' '.$_POST['x2'].' '.$_POST['y2'].' '.$_POST['w'].' '.$_POST['h'];
    mysql_query("UPDATE `auth_userprofile` SET `crop`='$crop', `angle` = '$_POST[r]' WHERE `user_id`='$_SESSION[id]'") or die(mysql_error());
    $file_name = translate($file_name);
    $size = getimagesize('../images/users/' . $_SESSION['id'] . '/' . $file_name);
    if($_POST['r']!=0)
    {
        switch($size['mime'])
        {
            case 'image/jpeg':
                $size = getimagesize('../images/users/' . $_SESSION['id'] . '/' . $file_name . "_" . $_POST['r'] . "_.jpeg");
                break;
            case 'image/gif':
                $size = getimagesize('../images/users/' . $_SESSION['id'] . '/' . $file_name . "_" . $_POST['r'] . "_.gif");
                break;
            default: return false;
        }
       
    }
      $size['new_file']='../images/users/'.$_SESSION['id'].'/'.$file_name.'_min';
    $size['k']=$size[1]/320;
    $size['width']=$_POST['w']*$size['k'];
    $size['height']=$_POST['h']*$size['k'];
    $size['x1']=$_POST['x1']*$size['k'];
    $size['y1']=$_POST['y1']*$size['k'];
    $size['x2']=$_POST['x2']*$size['k'];
    $size['y2']=$_POST['y2']*$size['k'];
    
    $new_image = imagecreatetruecolor($size['width'], $size['height']);
    
    switch($size['mime']){
        case 'image/jpeg':
            if($_POST['r']==0)
                $size['file']='../images/users/' . $_SESSION['id'] . '/' . $file_name;
            else
                $size['file']='../images/users/' . $_SESSION['id'] . '/' . $file_name . "_". $_POST['r']."_.jpeg";
            $current_image = imagecreatefromjpeg($size['file']);
            imagecopyresampled($new_image, $current_image, 0, 0, $size['x1'], $size['y1'], $size['width'], $size['height'], $size['width'], $size['height']);
            $size['new_file'].='.jpeg';
            imagejpeg($new_image, $size['new_file'],100);
            break;
        case 'image/gif':
            if($_POST['r']==0)
                $size['file']='../images/users/' . $_SESSION['id'] . '/' . $file_name;
            else
                $size['file']='../images/users/' . $_SESSION['id'] . '/' . $file_name . "_". $_POST['r']."_.gif";
            $current_image = imagecreatefromgif($size['file']);
            imagecopyresampled($new_image, $current_image, 0, 0, $size['x1'], $size['y1'], $size['width'], $size['height'], $size['width'], $size['height']);
            $size['new_file'].='.gif';
            imagegif($new_image, $size['new_file'],100);
            break;
        default:
            imagedestroy($new_image);
            return false;
    }
    imagedestroy($new_image);
    return true;
        
}

    $full_name=$_POST['last_name'].' '.$_POST['first_name'].' '.$_POST['middle_name'];
    if($_POST['file_name']!=''){
        $file_name = translate($_POST['file_name']);
        mysql_query("UPDATE `auth_userprofile` SET `name`='$full_name', `profile_image`='$file_name' WHERE `user_id`='$_SESSION[id]'") or die(mysql_error());
    }
    else{
        mysql_query("UPDATE `auth_userprofile` SET `name`='$full_name' WHERE `user_id`='$_SESSION[id]'") or die(mysql_error());
    }
    
    $_SESSION['name']=$full_name;
    resizeImage($_POST['file_name']);
    header("Location: ../index.php?action=edit_profile");

?>