<?php
    session_start();
    require_once('db.php');
    $user_id = $_SESSION['user_id'];
    $result_1 = mysql_query("SELECT user_id, subject_id, full_title, short_title, category FROM subjects JOIN user_subjects ON id = subject_id WHERE user_id = '$user_id'") or die(mysql_error());
    
    $subj_with_badges = "";
        
    while($subjects = mysql_fetch_assoc($result_1)) {
        switch ($subjects['category']) {
            case 1:
                $btn_style = "btn-success";
                break;
            case 2:
                $btn_style = "btn-info";
                break;
            case 3:
                $btn_style = "btn-danger";
        }
        $count_courses = mysql_fetch_assoc(mysql_query("SELECT count(*) as count_courses FROM courses WHERE user_id='$_SESSION[user_id]' and subject_id = '$subjects[subject_id]'"));
        $subj_with_badges .= "<li>
                                <button type='button' class='btn $btn_style' title='$subjects[full_title]' data-placement='bottom' data-toggle='tooltip'>" . $subjects['short_title'] . " <span class='badge'>" . $count_courses['count_courses'] . "</span>
                                </button>
                              </li>";
    }
        
    echo $subj_with_badges;
?>