<?php

    require_once('../controllers/db.php');
    require_once('../controllers/getSubjectsForModal.php');
    require_once('../controllers/lib/getProfileImage.php');
    if(!isset($_SESSION['is_auth']) || !$_SESSION['is_auth'])
    {
        header("Location: ../index.php?action=logout");
    }

?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Модуль администрирования Open edX</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/jasny-bootstrap.css">
    <link rel="stylesheet" href="../css/normalize.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/edit_courses.css">
    <script src="../js/jquery-2.1.4.js"></script>
    <script src="../js/bootstrap.js"></script>
    <script src="../js/jasny-bootstrap.js"></script>
    <script src="../js/moment-with-locales.min.js"></script>
    <script src="../js/bootstrap-datetimepicker.min.js"></script>
</head>
<body>
    <div class="header container-fluid navbar-fixed-top">
        <div class="row">
            <div class="col-xs-2 col-sm-3">
               <div class="navbar-default pull-left">
                    <button type="button" class="navbar-toggle" data-toggle="offcanvas" data-target=".navmenu" data-canvas=".main">
                        <span class="icon-bar"></span>
                    </button>
                </div>
            </div>
            <div class="hidden-xs col-sm-6">
                  <img class="img-responsive center-block logo" src="../images/logo.svg" alt="Университет ИТМО">
            </div>
            <div class="visible-xs-block col-xs-10">
                <img class="img-responsive pull-right logo" src="../images/logo.svg" alt="Университет ИТМО">
            </div>
            <div class="text-right hidden-xs col-sm-3">
                <a href="../index.php?action=logout" class="back-button-a">
                    <h4 class="back-button-header">
                        Выход
                        <span class="glyphicon glyphicon-circle-arrow-right back-button-icon" aria-hidden="true"></span>
                    </h4>
                </a>
            </div>
        </div>
    </div>
    <div class="main container-fluid">
        <div class="navmenu navmenu-default navmenu-fixed-left offcanvas-sm">
            <a class="navmenu-brand" href="../index.php?action=main">
               Модуль администрирования Open edX
            </a>
            <ul class="nav navmenu-nav">
                <li>
                    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                        <div class="panel panel-default unclicked" id="panel-default-manage-users">
                            <div class="panel-heading" role="tab" id="headingOne">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne" class="collapsed left-menu-a-main" id="manage-users-a">
                                        <span class="glyphicon glyphicon-user" aria-hidden="true"></span> Управление пользователями
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne" aria-expanded="false" style="height: 0px;">
                                <div class="panel-body">
                                    <a href="../index.php?action=edit_profile">Редактировать профиль</a>
                                </div>
                                <div class="panel-body">
                                    <a href="../index.php?action=search_users">Поиск пользователей</a>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default unclicked" id="panel-default-manage-courses">
                            <div class="panel-heading" role="tab" id="headingTwo">
                                <h4 class="panel-title">
                                    <a class="collapsed left-menu-a-main" id="manage-courses-a" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                        <span class="glyphicon glyphicon-blackboard" aria-hidden="true"></span> Управление курсами
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo" aria-expanded="false" style="height: 0px;">
                                <div class="panel-body">
                                    <a href="../index.php?action=watch_courses">Просмотреть курсы</a>
                                </div>
                                <div class="panel-body">
                                    <a href="../index.php?action=edit_courses">Редактировать курсы</a>
                                </div>
                            </div>
                        </div>
                      <div class="panel panel-default unclicked" id="panel-default-manage-certificates">
                        <div class="panel-heading" role="tab" id="headingThree">
                          <h4 class="panel-title">
                            <a class="collapsed left-menu-a-main" id="manage-certificates-a" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                              <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> Управление сертификатами
                            </a>
                          </h4>
                        </div>
                        <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree" aria-expanded="false">
                          <div class="panel-body">
                            Просмотр сертификатов
                          </div>
                        </div>
                      </div>
                      <div class="panel panel-default unclicked" id="panel-default-manage-stats">
                        <div class="panel-heading" role="tab" id="headingThree">
                          <h4 class="panel-title">
                            <a class="collapsed left-menu-a-main" id="manage-stats-a" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                              <span class="glyphicon glyphicon-stats" aria-hidden="true"></span> Управление статистикой
                            </a>
                          </h4>
                        </div>
                        <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour" aria-expanded="false">
							<div class="panel-body">
								<a href="../index.php?action=ratingOfAllUsers">Общий рейтинг пользователей</a>
							</div>
							<div class="panel-body">
								<a href="../index.php?action=studentsRating">Рейтинг студентов по группам и курсам</a>
							</div>
							<div class="panel-body">
								<a href="../index.php?action=courseRating">Рейтинг курсов</a>
							</div>
							<div class="panel-body">
								<a href="../index.php?action=complexity">Анализ сложности частей курсов</a>
							</div>
                        </div>
                      </div>
                    </div>
                </li>
                <li class="visible-xs-block">
                    <a href="../index.php?action=logout" class="back-button-a">
                        Выход
                        <span class="glyphicon glyphicon-circle-arrow-right" aria-hidden="true"></span>
                    </a>
                </li>
           </ul>
        </div>
        <div class="row">
            <div class="col-xs-12 col-md-offset-3 col-md-9 col-lg-offset-3 col-lg-6 courses-wrapper">
                <div class="manipulation-of-courses">
                    <div class="dropdown">
                        <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                            Выбрать
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                            <li><a>Все</a></li>
                            <li><a>Ни одного</a></li>
                        </ul>
                    </div>
                    <button type="button" class="btn btn-danger" id="btn-delete-courses">Удалить</button>
                </div>
                <div class="user-courses panel-group" role="tablist" aria-multiselectable="true">
                    <form class="form-courses">
                        <?php
                            $select = mysql_query("SELECT DISTINCT `a`.`course_id`, `a`.`org`, `b`.`created`, `c`.`staffs`, `c`.`subject`, `c`.`terms`, `c`.`bonuses`
                                                   FROM `student_courseaccessrole` AS `a`
                                                   LEFT JOIN `course_structures_coursestructure` AS `b`
                                                   ON `a`.`course_id` = `b`.`course_id`
                                                   LEFT JOIN `fspo_courseinfo` AS `c`
                                                   ON `a`.`course_id` = `c`.`course_id`
                                                   WHERE `a`.`user_id` = '$_SESSION[id]'");
                            $i = 0;
							$html = "";
                            while ($result = mysql_fetch_assoc($select)) {
                                list($courseBegin, $courseBase) = split(":", $result["course_id"]);
                                $courseElem = explode("+", $courseBase, 3);
                                $created = new DateTime($result["created"]);
                                $staffs = $result["staffs"];

                                $subject = $result["subject"];
                                if ($subject == NULL) {
                                    $subject = "нет";
                                }

                                $terms = $result["terms"];
                                if ($terms == NULL) {
                                    $terms = "нет";
                                }

                                $bonuses = $result["bonuses"];
                                if ($bonuses == NULL) {
                                    $bonuses = "нет";
                                }

                                $html .= "<div class='checkbox'>" .
                                         "<input type='checkbox' name=" . $result["course_id"] . ">" .
                                         "<div class='panel panel-default'>" .
                                            "<div class='panel-heading' role='tab' id='heading'" . $i . ">" .
                                                "<h3 class='panel-title'>" .
                                                    $courseElem["1"] .
                                                    " <span class='label label-primary'>" . $result["org"] . "</span>" .
                                                    "<a class='btn-more-info' role='button' data-toggle='collapse' data-parent='#accordion-user-courses' href='#collapse" . $i . "'>" .
                                                        "<span class='glyphicon glyphicon-plus'></span>" .
                                                    "</a>" .
                                                    "<a class='btn-edit' role='button' data-toggle='modal' data-target='#edit-course-modal'>" .
                                                        "<span class='glyphicon glyphicon-pencil'></span>" .
                                                    "</a>" .
                                                "</h3>" .
                                            "</div>" .
                                            "<div id='collapse" . $i . "' class='panel-collapse collapse' role='tabpanel' aria-labeledby='heading" . $i . "'>" .
                                                "<div class='panel-body'>" .
                                                    "<p class='created-date'>" .
                                                        "<b>Дата создания:</b> " . $created -> format("d.m.Y") .
                                                    "</p>" .
                                                    "<p>" .
                                                        "<b>Ответственные преподаватели:</b> " . $staffs .
                                                    "</p>" .
                                                    "<p>" .
                                                        "<b>Дисциплина:</b> " . $subject .
                                                    "</p>" .
                                                    "<p>" .
                                                        "<b>Ключевые термины:</b> " . $terms .
                                                    "</p>" .
                                                    "<p>" .
                                                        "<b>Бонусы за успешное прохождение:</b> " . $bonuses .
                                                    "</p>" .
                                                "</div>" .
                                            "</div>" .
                                         "</div>" .
                                     "</div>";
                                $i++;
                            }
							if($html == ''):?>
								<div class="well well-lg"><p class="text-center">На данный момент курсов нет</p></div>
						<?php
							endif;
							echo $html;
                        ?>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="edit-course-modal" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Редактирование данных курса</h4>
                </div>
                <div class="modal-body">
                    <form class="edit-courses-form">
                        <div class="form-group">
                            <label for="staffs">Ответственные преподаватели</label>
                            <textarea class="form-control" name="staffs" rows="4"><?=$staffs?></textarea>
                        </div>
                        <div class="form-group">
                            <label for="subject">Дисциплина</label>
                            <input type="text" class="form-control" name="subject" value="<?=$subject?>">
                        </div>
                        <div class="form-group">
                            <label for="terms">Ключевые термины</label>
                            <textarea class="form-control" name="terms" rows="4"><?=$terms?></textarea>
                        </div>
                        <div class="form-group">
                            <label for="bonuses">Бонусы за успешное прохождение</label>
                            <textarea class="form-control" name="bonuses" rows="4"><?=$bonuses?></textarea>
                        </div>
                    </form>
                    <button type="button" class="btn btn-success btn-confirm" id="btn-confirm-edit">Подтвердить</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(function() {
            var userID = "<?=$_SESSION["id"]?>";
            var editCourseID;

            $(".main.container-fluid .row").css("opacity","0");
            $(".main.container-fluid .row").animate({opacity: "1"}, 555);
            setTimeout(function() {
                $('a#manage-courses-a.left-menu-a-main').click();
            }, 350);

            $(".left-menu-a-main").on("click", function() {
                var panel = "#"+$("#"+$(this).attr("id")).parents(".panel-default").attr("id");
                if ($(panel).hasClass("clicked")) {
                    $(panel).removeClass("clicked");
                    $(panel).addClass("unclicked");
                } else {
                    $(".panel-default").removeClass("clicked");
                    $(".panel-default").addClass("unclicked");
                    $(panel).removeClass("unclicked");
                    $(panel).addClass("clicked");
                }
            });

            $(".navbar-toggle").on("click", function() {
                $(this).toggleClass("active");
            });

            $(".row").on("click", function() {
                if($('.main').hasClass('canvas-slid')) {
                    $('.navbar-toggle').removeClass('active');
                }
            });

            $(".courses-wrapper .manipulation-of-courses .dropdown-menu li:first-child").on("click", function() {
                $(".courses-wrapper .user-courses input[type=checkbox]").prop("checked", true);
            });

            $(".courses-wrapper .manipulation-of-courses .dropdown-menu li:last-child").on("click", function() {
                $(".courses-wrapper .user-courses input[type=checkbox]").removeAttr("checked");
            });

            $("#btn-delete-courses").on("click", function() {
                doSomethingByStatus(
                    "../controllers/work_with_courses.php",
                    {status: 1, serializeValue: $(".form-courses").serializeArray()},
                    function() {
                        location.reload();
                    }
                );
            });

            $(".btn-edit").on("click", function() {
                editCourseID = $(this).parents(".panel").prev("input").attr("name");
            });

            $("#btn-confirm-edit").on("click", function() {
                console.log($(".edit-courses-form").serializeArray());
                doSomethingByStatus(
                    "../controllers/work_with_courses.php",
                    {status: 2, courseID: editCourseID, serializeValue: $(".edit-courses-form").serializeArray()},
                    function() {
                        location.reload();
                    }
                );
            });

            // status
            // 1 - удаление выбранных курсов
            // 2 - изменение доп. информации о курсе
            function doSomethingByStatus(url, data, success) {
            	$.post(
            		url,
            		data,
            		success
            	);
            }

        });
    </script>
</body>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
</html>
