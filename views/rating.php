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
    <link rel="stylesheet" href="../css/stats.css">
    <script src="../js/jquery-2.1.4.js"></script>
    <script src="../js/bootstrap.js"></script>
    <script src="../js/jasny-bootstrap.js"></script>'
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
        	<div class="col-xs-12">
        		<div class="filter">
        			
        		</div>
        	</div>
        </div>
        <div class="row">
        	<div class="col-xs-12 col-md-offset-2 col-md-10 col-lg-8">
				<div class="row">
					
				</div>
        	</div>
        </div>
    </div>
</body>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
</html>
