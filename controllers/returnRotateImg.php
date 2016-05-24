<?php

    $file_name = $_POST['file'];
    $angle = $_POST['angle'];
    if($angle == 0)
    {
        $response['file'] = $file_name;
    }
    else
    {
        $response = array();
        $size = $size=getimagesize($file_name);    

        
        switch($size['mime']){
            case 'image/jpeg':
                $len = strrpos($file_name, '_.jpeg');
                if($len>0)
                    $rotated_file_name = substr($file_name,0,$len)."_".$angle."_.jpeg";
                else $rotated_file_name = $file_name."_".$angle."_.jpeg";
                break;
            case 'image/gif':
                $len = strrpos($file_name, '_.gif');
                if($len>0)
                    $rotated_file_name = substr($file_name, 0, $len)."_".$angle."_.gif";
                else $rotated_file_name = $file_name."_".$angle."_.gif";
                break;
            default:
                $response['error'] = "Файл имеет неверный mime-type!";
        }

        if(!file_exists($rotated_file_name) && !isset($response['error']))
        {
            switch($size['mime']){
                case 'image/jpeg':
                    $source = imagecreatefromjpeg($file_name);
                    $rotate = imagerotate($source, $angle, 0);
                    imagejpeg($rotate, $rotated_file_name, 100);
                    $response['file'] = $rotated_file_name;
                    break;
                case 'image/gif':
                    $source = imagecreatefromgif($file_name);
                    $rotate = imagerotate($source, $angle, 0);
                    imagegif($rotate, $rotated_file_name, 100);
                    $response['file'] = $rotated_file_name;
                    break;
                default:
                    $response['error'] = "Не удалось создать копию файла!";
            }
        }
        else{
            $response['file'] = $rotated_file_name;
        }
    }
    echo json_encode($response);

?>