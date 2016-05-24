<?php
function getAllSubjects() {
        require_once('../controllers/db.php');
        $result = mysql_query("SELECT id, title, description, (SELECT short_title FROM subjects WHERE id = subject_id) AS short_title FROM courses ORDER BY id DESC") or die(mysql_error());
        $subjects = "";
        
        if (mysql_num_rows($result) > 0) {
            $subjects .= "<div class='row navmenu-for-subjects'>
                                        <div class='col-lg-offset-2 col-lg-7' style='padding-left: 4%;'>
                                            <form class='navbar-form navbar-left' role='search'>
                                                <div class='btn-group'>
                                                    <button type='button' class='btn btn-default dropdown-toggle' data-toggle='dropdown'>
                                                         <input type='checkbox'> <span class='caret'></span>
                                                    </button>
                                                    <ul class='dropdown-menu' id='menu-checks'>
                                                        <li><a href='#'>Все</a></li>
                                                        <li><a href='#'>Ни одного</a></li>
                                                    </ul>
                                                </div>
                                                <button type='button' class='btn btn-success' data-toggle='modal' data-target='.modal-create-course'>Создать</button>
                                                <button type='button' class='btn btn-danger' id='delete-btn'>Удалить</button>
                                            </form>
                                        </div>
                                     </div>";
            while ($subject = mysql_fetch_assoc($result)) {
                $subjects .= "<div class='row subject-element' style='margin-bottom: 0;'>
                                        <form>
                                            <div class='row' style='margin-bottom: 0;'>
                                                <div class='col-lg-offset-2 col-lg-1 text-right'>
                                                    <div class='checkbox'>
                                                        <label>
                                                            <input type='checkbox' id='blankCheckbox' name=" . "check" . $subject['id'] . " value=" . $subject['id'] . ">
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class='col-lg-7'>
                                                    <div class='well well-lg'>
                                                            <div class='row'>
                                                                <div class='col-xs-10'>
                                                                    <b>" . $subject['title'] . " <span class='label label-warning'>" . $subject['short_title'] . "</span></b>
                                                                </div>
                                                                <div class='col-xs-2 text-right'>
                                                                    <a href=" . "#collapse-" . $subject['id'] . " data-toggle='collapse' aria-expanded='false' aria-controls=" . $subject['id'] . ">
                                                                        <img src='../images/more.png' width='18' height='18'>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                            <div class='collapse' id=" . "collapse-" . $subject['id'] . ">
                                                                    <div class='panel panel-default'>
                                                                        <div class='panel-body'>
                                                                            <div class='page-header' style='margin-top: 0;'>
                                                                                <h4>Описание</h4>
                                                                            </div>
                                                                            <p>" . $subject['description'] . "</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class='text-right'>
                                                                        <button type='button' class='btn btn-warning' value=" . $subject['id'] . ">Редактировать</button>
                                                                    </div>
                                                            </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>";
            }  
        } else {
            $subjects .= "<div class='row navmenu-for-subjects' style='margin-top: 40px;'>
                                        <div class='col-lg-offset-2 col-lg-7' style='padding-left: 8.35%;'>
                                            <form class='navbar-form navbar-left' role='search'>
                                                <button type='button' class='btn btn-success' data-toggle='modal' data-target='.modal-create-course'>Создать</button>
                                            </form>
                                        </div>
                                     </div>";
            $subjects .= "<div class='row no-courses'>
                                    <div class='col-lg-offset-3 col-lg-7' style='padding-right: 5px;'>
                                        <div class='well well-lg'>На данный момент, ни одного курса не было создано</div>
                                    </div>
                                 </div>";
        }
        
        return $subjects;
    }

    $subjects = getAllSubjects();
    echo $subjects;
?>