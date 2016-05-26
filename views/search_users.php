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
    <link rel="stylesheet" href="../css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="../css/search_users.css">
    <script src="../js/jquery-2.1.4.js"></script>
    <script src="../js/bootstrap.js"></script>
    <script src="../js/jasny-bootstrap.js"></script>
    <script src="../js/moment-with-locales.min.js"></script>
    <script src="../js/bootstrap-datetimepicker.min.js"></script>

    <script>
        $(function() {
            var userID;

            $(".user-wrapper .user-full-name h2").text("<?=$_SESSION['name']?>");
            $(".user-wrapper .user-full-name h2").append("<span class='label label-warning permissions-label'></span>");
            $(".user-wrapper .permissions-label").text(setUserPermByFlags("<?=$_SESSION['is_staff']?>", "<?=$_SESSION['is_superuser']?>"));

            $(".main.container-fluid .row").css("opacity","0");
            $(".main.container-fluid .row").animate({opacity: "1"}, 555);

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
            })

            $(".row").on("click", function() {
                if($('.main').hasClass('canvas-slid')) {
                    $('.navbar-toggle').removeClass('active');
                }
            })

            $("#panel-default-manage-courses div:nth-child(2) div:nth-child(2) a").click();

            $(document).on("click", function(e) {
              var target = $(e.target);
              if (!target.is("input.search-users") && !target.is("p.title")) {
                $(".names-wrapper").hide();
              }
            });

            $(".search-wrapper input.search-users").on("focus", function() {
                //дописать условие
                if ($(this).val() != "") {
                    $(".search-wrapper .names-wrapper").show();
                }
            });

            //вывод найденных пользователей в блок names
            $(".search-wrapper input.search-users").on("input", function() {
                var name = $(this).val().trim();
                if (name.length >= 3) {
                    doSomethingByStatus(
                        "../controllers/work_with_users.php",
                        {status: 1, name: name},
                        function(response) {
                            response = JSON.parse(response);
                            var namesStaffs = "";
                            var namesStudents = "";
                            $.each(response, function(key, val) {
                                if (val.is_staff == "0" && val.is_superuser == "0") {
                                    namesStudents += "<p><a class='link-student link-user' id='link-user-" + val.user_id + "'>" + val.name + "</a></p>";
                                } else if (val.is_staff == "1") {
                                    namesStaffs += "<p><a class='link-staff link-user' id='link-user-" + val.user_id + "'>" + val.name + "</a></p>";
                                }
                            });
                            if (namesStaffs == "") {
                                namesStaffs += "<p class='no-results'>Нет результатов</p>";
                            }
                            if (namesStudents == "") {
                                namesStudents += "<p class='no-results'>Нет результатов</p>";
                            }
                            namesStaffs = "<p class='title'>Преподаватели</p>" + namesStaffs;
                            namesStudents = "<p class='title'>Студенты</p>" + namesStudents;
                            $(".search-wrapper .names-wrapper").show();
                            $(".search-wrapper .names-wrapper .names").html(namesStaffs + namesStudents);
                        }
                    );
                }
            });

            //вывод информации о выбранном пользователе
            $(".search-wrapper .names-wrapper").on("click", "p:not(.title)", function() {
                userID = ($(this).children(".link-user").attr("id")).split("-")[2];
                if ("<?=$_SESSION['is_superuser']?>" == "1" && userID != "<?=$_SESSION['id']?>") {
                    $(".user-wrapper .edit-permissions").show();
                    $(".user-wrapper .delete-user").show();
                }
                var userPermNum; //номер прав пользователя
                if ($(this).children(".link-user").hasClass("link-admin")) {
                    userPerm = setUserPerm(3);
                    userPermNum = "3";
                } else if ($(this).children(".link-user").hasClass("link-staff")) {
                    userPerm = setUserPerm(2);
                    userPermNum = "2";
                } else {
                    userPerm = setUserPerm(1);
                    userPermNum = "1";
                }
                var fullName = $(this).children(".link-user").text();
                $(".user-wrapper .user-full-name h2").text(fullName);
                $(".user-wrapper .user-full-name h2").append("<span class='label label-warning permissions-label label-" + userID + "'></span>");
                $(".user-wrapper .permissions-label").text(userPerm);
                $("#edit-modal .permissions option[value=" + userPermNum + "]").prop("selected", true);
                $("#delete-user-modal p").text("Вы уверены, что хотите удалить данные о пользователе: " + fullName + "?");
                doSomethingByStatus(
                    "../controllers/work_with_users.php",
                    {status: 3, userID: userID, permissions: userPermNum},
                    function(response) {
                        response = JSON.parse(response);
                        console.log(response);
                    }
                );
            });

            $("#btn-confirm-perm").on("click", function() {
                var newPerm = $("#edit-modal .permissions option:checked").val();
                doSomethingByStatus(
                    "../controllers/work_with_users.php",
                    {status: 2, userID: userID, permissions: newPerm},
                    function(response) {
                        $(".user-wrapper .permissions-label").text(setUserPerm(Number(newPerm)));
                        $("#edit-modal .close").click();
                    }
                );
            });

            $("#btn-confirm-delete").on("click", function() {
                doSomethingByStatus(
                    "../controllers/work_with_users.php",
                    {status: 4, userID: userID},
                    function(response) {
                        console.log(response);
                    }
                );
            });

            // status
            // 1 - получить информацию для поиска о пользователях с совпадающим именем из БД
            // 2 - изменить права пользователя
            // 3 -
            // 4 - удалить данные о пользователе
            function doSomethingByStatus(url, data, success) {
            	$.post(
            		url,
            		data,
            		success
            	);
            }

            function setUserPerm(perm) {
              switch(perm) {
                case 1:
                  return "студент";
                case 2:
                  return "преподаватель";
                case 3:
                  return "администратор";
              }
            }

            function setUserPermByFlags(is_staff, is_superuser) {
                if (is_staff == "0" && is_superuser == "0") {
                    return setUserPerm(1);
                } else if (is_staff == "1") {
                    return setUserPerm(2);
                } else {
                    return setUserPerm(3);
                }
            }

        });
    </script>
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
                                    <a href="../index.php?action=add_subject">Добавить дисциплину</a>
                                </div>
                                <div class="panel-body">
                                    Назначить преподавателя
                                </div>
                                <div class="panel-body">
                                    Назначить бонусы
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
            <div class="col-xs-offset-6 col-xs-6 col-sm-offset-7 col-sm-5 col-md-offset-8 col-md-4 col-lg-offset-9 col-lg-3 search-wrapper">
                <div class="search-users-form-wrapper">
                    <form class="search-users-form">
                        <input type="text" class="form-control search-users" autocomplete="off" placeholder='Поиск...'>
                        <div class="row names-wrapper">
                          <div class="names"></div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 col-md-offset-3 col-md-9 col-lg-offset-3 col-lg-6 user-wrapper">
                <div class="user-full-name">
                    <h2><span class="label label-warning permissions-label"></span></h2>
                    <button type="button" class="btn btn-default edit-permissions" data-toggle="modal" data-target="#edit-modal">
                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                    </button>
                    <button type="button" class="btn btn-default delete-user" data-toggle="modal" data-target="#delete-user-modal">
                        <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="edit-modal" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Назначение прав</h4>
                </div>
                <div class="modal-body">
                    <form class="edit-form">
                        <div class="form-group">
                            <select class="form-control permissions">
                                <option value="1">Студент</option>
                                <option value="2">Преподаватель</option>
                                <option value="3">Администратор</option>
                            </select>
                        </div>
                        <button type="button" class="btn btn-success btn-confirm" id="btn-confirm-perm">Подтвердить</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="delete-user-modal" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Удаление данных пользователя</h4>
                </div>
                <div class="modal-body">
                    <p></p>
                    <button type="button" class="btn btn-danger btn-confirm" id="btn-confirm-delete">Подтвердить</button>
                </div>
            </div>
        </div>
    </div>
</body>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
</html>
