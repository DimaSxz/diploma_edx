<?php
    session_start();
    require_once('db.php');
    $result = mysql_query("SELECT * FROM (SELECT id, title, description FROM courses WHERE user_id = '$_SESSION[user_id]' ORDER BY id DESC LIMIT 3) AS last_courses");
    $last_courses_str = "";
    $i = 1;
            
            if (mysql_num_rows($result) > 0) {
                while ($last_courses = mysql_fetch_assoc($result)) {
                    if ($i == 3) {
                        $last_courses_str .= "<div class='hidden-xs hidden-sm col-md-4'>
                                                        <a href='#' class='main-course-a'>
                                                            <div class='thumbnail main-course'>
                                                                <img src='../images/logo-xs.png' alt='IT's MOre than a UNIVERSITY'>
                                                                <div class='caption'>
                                                                    <h3>" . $last_courses['title'] . "</h3>
                                                                    <p>" . $last_courses['description'] . "</p>
                                                                    <ul  class='list-group text-left'>
                                                                        <li class='list-group-item'>
                                                                            <span class='badge'>0</span>
                                                                            Студентов
                                                                        </li>
                                                                        <li class='list-group-item'>
                                                                            <span class='badge'>0</span>
                                                                            Активных
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </a>
                                                    </div>";
                    } else {
                        $last_courses_str .= "<div class='col-xs-12 col-xsm-6 col-sm-6 col-md-4'>
                                                        <a href='#' class='main-course-a'>
                                                            <div class='thumbnail main-course'>
                                                                <img src='../images/logo-xs.png' alt='IT's MOre than a UNIVERSITY'>
                                                                <div class='caption'>
                                                                    <h3>" . $last_courses['title'] . "</h3>
                                                                    <p>" . $last_courses['description'] . "</p>
                                                                    <ul  class='list-group text-left'>
                                                                        <li class='list-group-item'>
                                                                            <span class='badge'>0</span>
                                                                            Студентов
                                                                        </li>
                                                                        <li class='list-group-item'>
                                                                            <span class='badge'>0</span>
                                                                            Активных
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </a>
                                                    </div>";
                    }
                    $i++;
                }
            } else {
                $last_courses_str .= "<div class='well well-lg'>На данный момент, ни одного курса не было создано</div>";
            }
            
            echo $last_courses_str;
?>