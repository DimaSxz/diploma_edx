<?php

    require_once('../controllers/db.php');
    require_once('../controllers/getSubjectsForModal.php');
    require_once('../controllers/lib/getProfileImage.php');
    if(!isset($_SESSION['is_auth']) || !$_SESSION['is_auth'])
    {
        header("Location: ../index.php?action=logout");
    }
    $select = mysql_query("SELECT DISTINCT `course_id`
                           FROM `student_courseaccessrole`
                           WHERE `course_id`
                           NOT IN (SELECT `course_id` FROM `fspo_courseinfo`)
                           AND `user_id` = '$_SESSION[id]'") or die(mysql_error());
    while ($result = mysql_fetch_assoc($select)) {
        mysql_query("INSERT INTO `fspo_courseinfo` (`course_id`, `staffs`)
                     VALUES ('$result[course_id]', '$_SESSION[name]')") or die(mysql_error());
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
    <script src="../js/jquery-2.1.4.js"></script>
    <script src="../js/bootstrap.js"></script>
    <script src="../js/jasny-bootstrap.js"></script>
    <script src="../js/moment-with-locales.min.js"></script>
    <script src="../js/bootstrap-datetimepicker.min.js"></script>

    <script>
        $(function() {

            $('.main.container-fluid .row').css('opacity','0');
            $('.main.container-fluid .row').animate({opacity: "1"}, 555);

            $('.left-menu-a-main').on('click', function() {
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

            $('.navbar-toggle').on('click', function() {
                $(this).toggleClass('active');
            })

            $('.row').on('click', function() {
                if($('.main').hasClass('canvas-slid')) {
                    $('.navbar-toggle').removeClass('active');
                }
            })

            $('#panel-default-manage-courses div:nth-child(2) div:nth-child(2) a').click();

            $('.avatar').on('click', function(){
                $('#fullImage').modal('hide');
            });

            $(function() {
                var today = new Date();
                $("#create_start_date").datetimepicker({
                    locale: 'ru',
                    minDate: today
                });
                $("#create_end_date").datetimepicker({
                    locale: 'ru',
                    minDate: today
                });
                $("#create_start_date").on("dp.change", function (e) {
                    $("#create_end_date").data("DateTimePicker").setMinDate(e.date);
                });
                $("#create_end_date").on("dp.change", function (e) {
                    $("#create_start_date").data("DateTimePicker").setMaxDate(e.date);
                });
            });

            $('#create_course_title').focus(function() {
                if ($(this).val != '') {
                    $(this).parent('div').removeClass('has-error has-feedback');
                }
            });

            $('#create_subjects').focus(function() {
                if ($(this).val != '') {
                    $(this).parent('div').removeClass('has-error has-feedback');
                }
            });

            $('#create_description').focus(function() {
                if ($(this).val != '') {
                    $(this).parent('div').removeClass('has-error has-feedback');
                }
            });

            function inspectCourseTitle(result) {
                if (result == 'empty') {
                    $('#create_course_title').parent('div').addClass('has-error has-feedback');
                }
            }

            function inspectSubject(result) {
                if (result == 'empty') {
                    $('#subjects').parent('div').addClass('has-error has-feedback');
                }
            }

            function inspectDescription(result) {
                if (result == 'empty') {
                    $('#create_description').parent('div').addClass('has-error has-feedback');
                }
            }

            $('#create-btn').on('click', function() {
                var create_course_title = $('#create_course_title').val();
                var create_start_date = $('#create_start_date input[type=text]').val();
                var create_end_date = $('#create_end_date input[type=text]').val();
                var subject = $('#create_subjects').val();
                var create_description = $('#create_description').val();
                $.post(
                    "../controllers/create_course.php",
                    {course_title: create_course_title, start_date: create_start_date, end_date: create_end_date, subject: subject, description: create_description},
                    function(responce) {
                        responce = JSON.parse(responce);
                        if (responce['course_title'] == 'all_good' && responce['subject'] == 'all_good' && responce['description'] == 'all_good') {
                            for (var i=1; i <= 5; ++i) {
                                $('#create_course_title').val('');
                                $('#create_subject').val('');
                                $('#create_description').val('');
                            }
                            $('#success_alert').css('display','block');
                            $('#error_alert').css('display', 'none');
                            $('.row.subject-element').remove();
                            $('.row.navmenu-for-subjects').remove();
                            $('.row.no-courses').remove();
                            $.get (
                                "../controllers/getLastCoursesForMain.php",
                                {},
                                function (responce) {
                                    $('#three-last-courses').html(responce);
                                }
                            );
                            $.get (
                                "../controllers/getBadges.php",
                                {},
                                function (responce) {
                                    $('.list-subjects').html(responce);
                                }
                            );
                        } else {
                            inspectCourseTitle(responce['course_title']);
                            inspectSubject(responce['subject']);
                            inspectDescription(responce['description']);
                            $('#success_alert').css('display','none');
                            $('#error_alert').css('display', 'block');
                        }
                    }
                );
            });
        });
    </script>
    <style>
        .modal-create-course .form-horizontal .row {
            margin-bottom: 20px;
        }
    </style>

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
								<a href="../index.php?action=userRating">Рейтинг пользователей</a>
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
           <div class="col-xs-12 col-md-offset-3 col-md-9 col-lg-offset-3 col-lg-7">
               <div class="row">
                   <div class="col-xs-4">
                          <a data-toggle="modal" data-target="#fullImage">
                           <img src="<?=getProfileMiniImage()?>" alt="Аватар" class="avatar img-circle img-responsive">
                          </a>
                   </div>
                   <div class="col-xs-8">
                        <h3 class="full-name-header"><?=$_SESSION['name']?></h3>
                        <ul class="list-inline list-subjects">
                        <script>
                            $.get (
                                "../controllers/getBadges.php",
                                {},
                                function (responce) {
                                    $('.list-subjects').html(responce);
                                }
                            );
                        </script>
                       </ul>
                   </div>
                </div>
                <div class="row text-center" id="three-last-courses">
                    <script>
                        $.get (
                            "../controllers/getLastCoursesForMain.php",
                            {},
                            function (responce) {
                                $('#three-last-courses').html(responce);
                                $("[data-toggle='tooltip']").tooltip();
                            }
                        );
                    </script>
                </div>
                <div class="row text-center">
                    <div class="col-xs-12">
                        <div class="thumbnail add-course-button">
                            <a href="#" data-toggle="modal" data-target=".modal-create-course">
                                <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
       </div>
   </div>
   <div class="modal fade" id="fullImage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
       <div class="modal-dialog avatar">
           <img src="<?=getProfileImage()?>" alt="Аватар" class="img-responsive img-rounded center-block">
       </div>
   </div>
   <div class="modal fade modal-create-course" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
          <div class="modal-dialog modal-lg">
              <div class="modal-content">
                   <div class="modal-header">
                       <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                       <h4 class="modal-title" id="myModalLabel">Создание курса</h4>
                   </div>
                   <div class="modal-body">
                      <div class="row">
                           <div class="col-lg-offset-1 col-lg-10" style="display: none;" id="error_alert">
                               <div class="alert alert-danger alert-dismissible" role="alert" style="margin-top: 20px;">
                                   <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                   <strong>Ошибка!</strong> Проверьте корректность ввода данных
                               </div>
                           </div>
                           <div class="col-lg-offset-1 col-lg-10" style="display: none;" id="success_alert">
                               <div class="alert alert-success alert-dismissible" role="alert" style="margin-top: 20px;">
                                   <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                   <strong>Успех!</strong> Создание курса успешно завершено
                               </div>
                           </div>
                       </div>
                       <form class="form-horizontal">
                           <div class="row">
                               <div class="col-lg-12">
                                    <label class="control-label" for="create_course_title">Название курса</label>
                                    <input type="text" class="form-control" id="create_course_title">
                               </div>
                           </div>
                           <div class="row">
                               <div class="col-lg-3">
                                  <label class="control-label" for="create_start_date">Дата начала</label>
                                  <div class='input-group date' id='create_start_date'>
                                      <span class="input-group-addon">
                                          <span class="glyphicon glyphicon-calendar"></span>
                                      </span>
                                      <input type='text' class="form-control">
                                  </div>
                               </div>
                               <div class="col-lg-3">
                                  <label class="control-label" for="create_end_date">Дата окончания</label>
                                  <div class='input-group date' id='create_end_date'>
                                      <span class="input-group-addon">
                                          <span class="glyphicon glyphicon-calendar"></span>
                                      </span>
                                      <input type='text' class="form-control">
                                  </div>
                               </div>
                               <div class="col-lg-6">
                                 <label class="control-label" for="create_subjects">Дисциплина</label>
                                 <select id="create_subjects" class="form-control">
                                     <?=getSubjectsForModal()?>
                                 </select>
                               </div>
                           </div>
                       <div class="row">
                           <div class="col-lg-12">
                              <label class="control-label" for="create_description">Описание</label>
                              <textarea class="form-control" rows="12" cols="10" id="create_description" style="resize: none;"></textarea>
                           </div>
                       </div>
                    </form>
                   </div>
                   <div class="modal-footer">
                       <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
                       <button type="button" class="btn btn-primary" id="create-btn">Сохранить</button>
                   </div>
              </div>
          </div>
       </div>
</body>
<META http-equiv="pragma" content="no-cache">
<META http-equiv="Cache-Control" content="no-cache">
</html>
