<?php

    session_start();
    require_once('../controllers/is_auth.php');
    require_once('../controllers/db.php');
    if(!isset($_SESSION['is_auth']) || !$_SESSION['is_auth'])
    {
        header("Location: ../index.php?action=logout");
    }

    function getSubjectsForModal() {
        $user_id = $_SESSION['id'];
        $result = mysql_query("SELECT id, full_title FROM subjects JOIN user_subjects ON id = subject_id WHERE user_id = '$user_id'") or die(mysql_error());
        $subjects = "";

        if (mysql_num_rows($result) > 0) {
            while ($options = mysql_fetch_assoc($result)) {
                $subjects .= "<option value=" . $options['id'] . ">" . $options['full_title'] . "</option>";
            }
        } else {
                $subjects .= "<option>Вам требуется добавить дисциплины</option>";
        }

        return $subjects;
    }

?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Модуль администрирования Open edX</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <script src="../js/jquery-2.1.4.js"></script>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <script src="../js/bootstrap.js"></script>
    <link rel="stylesheet" href="../css/jasny-bootstrap.css">
    <script src="../js/jasny-bootstrap.js"></script>
    <link rel="stylesheet" href="../css/normalize.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/watch_courses.css">
    <script src="../js/moment-with-locales.min.js"></script>
    <script src="../js/bootstrap-datetimepicker.min.js"></script>
    <link rel="stylesheet" href="../css/bootstrap-datetimepicker.min.css">

    <script>
        var setValStart;
        var setValEnd;
        var edit_course_id;

        function getAllSubjectsForWatch() {
            $.post(
                "../controllers/getAllSubjectsForWatch.php",
                {},
                function(responce) {
                    $('.main').append(responce);

                    $('.main.container-fluid .row').css('opacity','0');
                    $('.main.container-fluid .row').animate({opacity: "1"}, 555);

                    $('.navmenu .left-menu-a-main').on('click', function() {
                        var panel = "#"+$("#"+$(this).attr("id")).parents(".panel-default").attr("id");
                        if ($(panel).hasClass("clicked")) {
                            $(panel).removeClass("clicked");
                            $(panel).addClass("unclicked");
                        } else {
                            $(".navmenu .panel-default").removeClass("clicked");
                            $(".navmenu .panel-default").addClass("unclicked");
                            $(panel).removeClass("unclicked");
                            $(panel).addClass("clicked");
                        }
                    })

                    $("[data-toggle='tooltip']").tooltip();

                    $('.navmenu .navbar-toggle').on('click', function() {
                        $(this).toggleClass('active');
                    });

                    $('.row').on('click', function() {
                        if($('.main').hasClass('canvas-slid')) {
                            $('.navmenu .navbar-toggle').removeClass('active');
                        }
                    });

                    $('.navmenu .navmenu-brand').on('click', function() {
                        $('.main.container-fluid').css('display', 'none');
                    });

                    $('.main .row #delete-btn').on('click', function() {
                        var check = $('form').serializeArray();
                        if (!$.isEmptyObject(check)) {
                            $.post (
                                "../controllers/delete_courses.php",
                                {checkArray: check},
                                function(responce) {
                                    if (responce == 1) {
                                        $('input:checked').parents('form').parent('.row').css('display', 'none');
                                    } else {
                                        $('.main .navbar-form').parent('.col-lg-7').parent('.row').css('display', 'none');
                                        $('input:checked').parents('form').parent('.row').css('display', 'none');
                                        $('.main').append("<div class='row navmenu-for-subjects' style='margin-top: 40px;'><div class='col-lg-offset-2 col-lg-7' style='padding-left: 8.35%;'><form class='navbar-form navbar-left' role='search'><button type='button' class='btn btn-success' data-toggle='modal' data-target='.modal-create-course'>Создать</button></form></div></div><div class='row no-courses'><div class='col-lg-offset-3 col-lg-7' style='padding-right: 5px;'><div class='well well-lg'>На данный момент, ни одного курса не было создано</div></div></div>");
                                    }
                                }
                            );
                        }
                    });

                    $('#menu-checks li:first-child').on('click', function() {
                        $('input[type=checkbox]').prop('checked','true');
                    });

                    $('#menu-checks li:last-child').on('click', function() {
                        $('input[type=checkbox]').removeAttr('checked');
                    });

                });
        }

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

        function inspectcreate_description(result) {
            if (result == 'empty') {
                $('#create_description').parent('div').addClass('has-error has-feedback');
            }
        }

        setTimeout(function() {
                $('a#manage-courses-a.left-menu-a-main').click();
        }, 350);

        $(document).ready(function() {
            $(function () {
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
                            getAllSubjectsForWatch();
                        } else {
                            inspectCourseTitle(responce['course_title']);
                            inspectSubject(responce['subject']);
                            inspectcreate_description(responce['description']);
                            $('#success_alert').css('display','none');
                            $('#error_alert').css('display', 'block');
                        }
                    }
                );
            });

            getAllSubjectsForWatch();
        });

        $(document).on('click', '.collapse .btn-warning', function() {
            edit_course_id = $(this).prop('value');
            $.post(
                "../controllers/getinfoForEdit.php",
                {edit_course_id: edit_course_id},
                function(responce) {
                    responce = JSON.parse(responce);
                    setValStart = responce['start_date'];
                    setValEnd = responce['end_date'];

                    $(function () {
                        $("#edit_start_date").datetimepicker({
                            locale: 'ru',
                            defaultDate: setValStart
                        });
                        $("#edit_end_date").datetimepicker({
                            locale: 'ru',
                            defaultDate: setValEnd
                        });
                    });

                    $('#edit_course_title').prop('placeholder', responce['title']);
                    $('.modal-edit-course select#edit_subjects option[value=' + responce['subject_id'] + ']').prop('selected', 'true');
                    $('#edit_description').prop('placeholder', responce['description']);
                }
            );

            $('.modal-edit-course').modal('show');
        });

        $(document).on('click', '#edit-save-btn', function() {
            var change_title = $('#edit_course_title').val();
            var change_start_date = $('#edit_start_date input[type=text]').val();
            var change_end_date = $('#edit_end_date input[type=text]').val();
            var change_subject = $('#edit_subjects').val();
            var change_description = $('#edit_description').val();
            $.post(
                "../controllers/saveChangesForCourse.php",
                {id: edit_course_id, title: change_title, start_date: change_start_date, end_date: change_end_date, subject_id: change_subject, description: change_description},
                function(responce) {
                    $('.row.subject-element').remove();
                    $('.row.navmenu-for-subjects').remove();
                    getAllSubjectsForWatch();
                }
            );
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
       <div class="modal fade modal-edit-course" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
          <div class="modal-dialog modal-lg">
              <div class="modal-content">
                   <div class="modal-header">
                       <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                       <h4 class="modal-title" id="myModalLabel">Редактирование курса</h4>
                   </div>
                   <div class="modal-body">
                       <form class="form-horizontal">
                           <div class="row">
                               <div class="col-lg-12">
                                    <label class="control-label" for="edit_course_title">Название курса</label>
                                    <input type="text" class="form-control" id="edit_course_title">
                               </div>
                           </div>
                           <div class="row">
                               <div class="col-lg-3">
                                  <label class="control-label" for="edit_start_date">Дата начала</label>
                                  <div class='input-group date' id='edit_start_date'>
                                      <span class="input-group-addon">
                                          <span class="glyphicon glyphicon-calendar"></span>
                                      </span>
                                      <input type='text' class="form-control">
                                  </div>
                               </div>
                               <div class="col-lg-3">
                                  <label class="control-label" for="edit_end_date">Дата окончания</label>
                                  <div class='input-group date' id='edit_end_date'>
                                      <span class="input-group-addon">
                                          <span class="glyphicon glyphicon-calendar"></span>
                                      </span>
                                      <input type='text' class="form-control">
                                  </div>
                               </div>
                               <div class="col-lg-6">
                                 <label class="control-label" for="edit_subjects">Дисциплина</label>
                                 <select id="edit_subjects" class="form-control">
                                     <?=getSubjectsForModal()?>
                                 </select>
                               </div>
                           </div>
                       <div class="row">
                           <div class="col-lg-12">
                              <label class="control-label" for="edit_description">Описание</label>
                              <textarea class="form-control" rows="12" cols="10" id="edit_description" style="resize: none;"></textarea>
                           </div>
                       </div>
                    </form>
                   </div>
                   <div class="modal-footer">
                       <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
                       <button type="button" class="btn btn-primary" id="edit-save-btn">Сохранить</button>
                   </div>
              </div>
          </div>
       </div>
       <div class="navmenu navmenu-default navmenu-fixed-left offcanvas-sm">
           <a class="navmenu-brand" href="main.php">
               Панель администрирования openEDX
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
                            Редактировать профили пользователей
                          </div>
                          <div class="panel-body">
                            Назначить права
                          </div>
                          <div class="panel-body">
                            Удалить пользователя
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
   </div>
</body>
</html>
