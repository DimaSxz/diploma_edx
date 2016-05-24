<?php
    session_start();
    require_once('./lib/translate.php');
    $file=array();
    $error=false;
    define("MAX_FILE_SIZE", 52428800);

    function mkdir_r($dirName, $rights=0777){ 
        $dirs = explode('/', $dirName); 
        $dir=''; 
        foreach ($dirs as $part) { 
            $dir.=$part.'/'; 
            if (!is_dir($dir) && strlen($dir)>0) 
                mkdir($dir, $rights); 
        } 
    } 
        
    function in_blacklist($file_name)
    {
        $blacklist = array(
                            ".php",
                            ".phtml",
                            ".php1",
                            ".php2",
                            ".php3",
                            ".php4",
                            ".php5",
                            ".php6",
                            ".php7",
                            ".html",
                            ".htm",
                            ".tpl"
                            );
        foreach ($blacklist as $item)
        {
            if(preg_match("/$item\$/i", $file_name))
            {
                return true;
            }
        }
        return false;
    }

    function checkType($file_type)
    {
        $types = array(
                        "image/jpeg",
                        "image/jpg",
                        "image/gif"
                        );
        if(in_array($file_type, $types))
            return true;
        else return false;
    }

    function checkSize($file_size)
    {
        if($file_size <= MAX_FILE_SIZE)
            return true;
        else return false;
    }
    
    if(isset($_FILES['avatar']) && !in_blacklist($_FILES['avatar']['name']) && checkType($_FILES['avatar']['type']) && checkSize($_FILES['avatar']['size']))
    {
        $upload_dir="../images/users/".$_SESSION['id'].'/';
        if(!is_dir($upload_dir)) mkdir_r($upload_dir, 0777);
        $_FILES['avatar']['name'] = translate($_FILES['avatar']['name']);
        if(move_uploaded_file($_FILES['avatar']['tmp_name'], $upload_dir.$_FILES['avatar']['name'])){
            $file=$upload_dir.$_FILES['avatar']['name'];
        }
        else{
            $error=true;
        }
    }
    else{
        $error=true;
    }
    
    $data = $error ? array('error' => 'Ошибка загрузки изображения.') : array('file' => $file);

    echo json_encode($data);

?>