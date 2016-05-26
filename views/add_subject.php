<?php

    session_start();
    require_once('../controllers/is_auth.php');
    require_once('../controllers/db.php');
    if(!isset($_SESSION['is_auth']) || !$_SESSION['is_auth'])
    {
        header("Location: ../index.php?action=logout");
    }

    function getAllSubjects() {
        $user_id = $_SESSION['id'];
        $result_from_db = mysql_query("SELECT id, full_title FROM subjects 
                                                            WHERE id NOT IN (SELECT subject_id FROM user_subjects WHERE user_id = '$user_id')") or die(mysql_error());
        $options_str = "";    

        while ($options = mysql_fetch_assoc($result_from_db)) {
            $options_str .= "<option value=" . $options['id'] . ">" . $options['full_title'] . "</option>";
        }

        return $options_str;
    }                       

    function getSelectedSubjects() {
        $user_id = $_SESSION['id'];
        $result_from_db = mysql_query("SELECT id, full_title FROM user_subjects JOIN subjects ON subject_id = id WHERE user_id = '$user_id'") or die(mysql_error());
        $options_str = "";    

        while ($options = mysql_fetch_assoc($result_from_db)) {
            $options_str .= "<option value=" . $options['id'] . ">" . $options['full_title'] . "</option>";
        }

        return $options_str;
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
            })
            
            $("[data-toggle='tooltip']").tooltip(); 
                        
            $('.navbar-toggle').on('click', function() {
                $(this).toggleClass('active');
            })
            
            $('.row').on('click', function() {
                if($('.main').hasClass('canvas-slid')) {
                    $('.navbar-toggle').removeClass('active');
                }
            })
            
            setTimeout(function() {
                $('a#manage-courses-a.left-menu-a-main').click();    
            }, 350);
            
            $('.navmenu-brand').on('click', function() {
                $('.main.container-fluid').css('display', 'none');                           
            })
            
            $('#to_right_select').on('click', function() {
               $('#selected_subjects').append($('#all_subjects option:selected')); 
               $('#selected_subjects option').prop('selected', false);
            });
            
            $('#to_left_select').on('click', function() {
               $('#all_subjects').append($('#selected_subjects option:selected')); 
               $('#all_subjects option').prop('selected', false);
            });
            
            $('#save_btn').on('click', function() {
                $('#selected_subjects option').prop('selected', true);  
                $.post (
                    "../controllers/add_subject_save.php",
                    {
                        selected_subjects: $('#selected_subjects').val()
                    },
                    function (responce) {
                        $('#selected_subjects option').prop('selected', false);
                        $('#alert_success').css('display','block');
                    }
                )
            });
            
          })
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
           <div class="col-xs-12 col-md-offset-3 col-md-8 col-lg-offset-3 col-lg-7">
               <div class="row">
                   <div class="col-lg-12 text-center">
                       <p>
                           Добавьте дисциплины, которые вы ведете из левого столбца в правый и по завершении нажмите кнопку "Сохранить".
                       </p>
                   </div>
               </div>
               <div class="col-xs-offset-1 col-xs-10 col-sm-offset-1 col-sm-10 col-md-offset-2 col-md-8 col-lg-offset-1 col-lg-10" id="alert_success" style="display: none;">
                      <div class="alert alert-success alert-dismissible" role="alert" style="margin-top: 5px;">
                          <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                          <strong>Успех!</strong> Изменения успешно сохранены
                      </div>
               </div>
                <form class="form-horizontal">
                    <div class="row">
                        <div class="col-lg-5 text-center">
                            <label for="all_subjects">Все предметы</label>
                            <select class="form-control" name="" id="all_subjects" multiple size="8">
                                <?=getAllSubjects()?>
                            </select>
                        </div>
                        <div class="col-lg-2 text-center">
                           <div class="row" style="margin-bottom: 0;">
                               <div class="col-lg-12">
                                   <button type="button" id="to_right_select" class="btn btn-warning" aria-label="Center Align" style="margin-top: 50%;" data-toggle="tooltip" data-placement="bottom" title="Нажмите, чтобы добавить дисциплину">
                                       <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                                   </button>
                               </div>
                           </div>
                            <div class="row" style="margin-bottom: 0;">
                                <div class="col-lg-12">
                                     <button type="button" id="to_left_select" class="btn btn-danger" aria-label="Center Align" style="margin-top: 20%;" data-toggle="tooltip" data-placement="bottom" title="Нажмите, чтобы удалить дисциплину">
                                      <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                                     </button>
                                 </div>
                            </div>
                        </div>
                        <div class="col-lg-5 text-center">
                            <label for="selected_subjects">Предметы, которые вы ведете</label>
                            <select class="form-control" id="selected_subjects" multiple size="8">
                                <?=getSelectedSubjects()?>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 text-center">
                            <button type="button" class="btn btn-success" id="save_btn">Сохранить</button>
                        </div>
                    </div>
                </form>
           </div>
       </div>
   </div>
</body>
</html>