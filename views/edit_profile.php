<?php

    session_start();
    require_once('../controllers/is_auth.php');
    if(!isset($_SESSION['is_auth']) || !$_SESSION['is_auth'])
    {
        header("Location: ../index.php?action=logout");
    }

    require_once('../controllers/lib/getProfileImage.php');
    
    $fio=explode(" ", $_SESSION['name']);

    $query = mysql_query("SELECT `crop`,`angle` FROM `auth_userprofile` WHERE `user_id` = '$_SESSION[id]'") or die(mysql_error());
    $select = mysql_fetch_assoc($query);
    if($select['crop'])
        $crop=explode(" ", $select['crop']);
    else{
        $crop[0]="";
        $crop[1]="";
        $crop[2]="";
        $crop[3]="";
        $crop[4]="";
        $crop[5]="";
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
    <link rel="stylesheet" href="../css/imgareaselect-default.css">
    <script src="../js/jquery.imgareaselect.pack.js"></script>
    <link rel="stylesheet" href="../css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style.css">

    <script>
        $(function() {
            $('.main.container-fluid .row').css('opacity','0');
            $('.main.container-fluid .row').animate({opacity: "1"}, 555);
            setTimeout(function() {
                $('a#manage-users-a.left-menu-a-main').click();    
            }, 350);
            
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
            
            $('#panel-default-manage-courses div:nth-child(2) div:nth-child(2) a').click();
            
                $('#form_edit_profile').on('submit',function(){
                if($('#last_name').val()=='')
                {
                    $('#last_name').val($('#last_name').attr('placeholder'));    
                }
                if($('#first_name').val()=='')
                {
                    $('#first_name').val($('#first_name').attr('placeholder'));    
                }
                if($('#middle_name').val()=='')
                {
                    $('#middle_name').val($('#middle_name').attr('placeholder'));    
                }
            });
            
            $('#selectImage').on('change', function(){
                
                $('#avatar').imgAreaSelect({
                    remove: true
                });

                $('#file_name').val($('#selectImage').val().replace(/\\/g, '/').replace(/.*\//, ''));
                var data = new FormData();
                data.append($('#selectImage').attr('name'), $('#selectImage')[0].files[0]);
                bufFileName = $('#file_name').val() ? $('#file_name').val() : null;
                $.ajax({
                    type: 'POST',
                    url: '../controllers/review_avatar.php',
                    data: data,
                    processData: false,
                    contentType: false,
                    dataType: "json",
                    success: function(data){
                        if(data['error'])
                        {
                            console.log(data);
                            $('#file_name').val(bufFileName);
                            $('#selectImage').val(null);
                        }
                        else{
                            img_name = data['file'];
                            rotate = 0;
                            $('input[name=r]').val(0);
                            $('#avatar').attr('src', data['file']);
                            $('#miniImage').attr('src', data['file']);
                        }
                    },
                    error: function(data){
                        console.log(data);
                        $('#file_name').val(bufFileName);
                        $('#selectImage').val(null);
                    }
                });
                if(!isset_preview)
                {
                    $('#review-row').css('display', 'block');
                    isset_preview=true;
                }
                startSelect();
            });
    
            /*РЕДАКТИРОВАНИЕ ИЗОБРАЖЕНИЯ*/
            
            var rotate=$('input[name=r]').val();
            
            $('.fa-repeat').on('click', function(){
                if(rotate <= 0)
                    rotate=270;
                else
                    rotate=Math.round(parseInt(rotate) - 90);
                $('input[name=r]').val(rotate);
                getRotateImg(rotate);
            });
            
            $('.fa-undo').on('click', function(){
                if(rotate >= 270)
                    rotate=0;
                else
                    rotate=Math.round(parseInt(rotate) + 90);
                $('input[name=r]').val(rotate);
                getRotateImg(rotate);
            });
            
            function getRotateImg(rotate)
            {
                var rotate_sourse = $('#avatar').attr('src');
                $.post
                (
                    "../controllers/returnRotateImg.php",
                    {
                        file: img_name,
                        angle: rotate
                    },
                    function(response)
                    {
                        response = JSON.parse(response);
                        console.log(response['file']);
                        if(!response['error'])
                        {
                            $('#avatar').attr('src', response['file']);
                            $('#miniImage').attr('src', response['file']);
                        }
                        else console.log(response['error']);
                    }
                );
            }
            
            function preview(img, selection) {
                var scaleX = 100 / (selection.width || 1);
                var scaleY = 100 / (selection.height || 1);
                            
                imgW = $('#avatar').width();
                imgH = $('#avatar').height();
                //костыль уровень бог.
                if(imgW==0)
//                  location.reload();
                    return 0;
 
                $('#miniImage').css({
                    width: Math.round(scaleX * imgW) + 'px',
                    height: Math.round(scaleY * imgH) + 'px',
                    marginLeft: '-' + Math.round(scaleX * selection.x1) + 'px',
                    marginTop: '-' + Math.round(scaleY * selection.y1) + 'px'
                });
                setSizes(selection.x1,
                         selection.y1,
                         selection.x2,
                         selection.y2,
                         selection.width,
                         selection.height
                        );
            }
            
            function setSizes(x1,y1,x2,y2,w,h){
                $('input[name=x1]').val(x1);
                $('input[name=y1]').val(y1);
                $('input[name=x2]').val(x2);
                $('input[name=y2]').val(y2);
                $('input[name=w]').val(w);
                $('input[name=h]').val(h);
            }
            
            function startSelect(x1,y1,x2,y2, w, h)
            {
                startX1 = x1 || ($('#avatar').width() / 2 - 50);
                startY1 = y1 || ($('#avatar').height() / 2 - 50);
                startX2 = x2 || ($('#avatar').width() / 2 + 50);
                startY2 = y2 || ($('#avatar').height() / 2 + 50);
                startW = w || 100;
                startH = h || 100;

                preview($('#avatar'),{x1: startX1, y1: startY1, x2: startX2, y2: startY2, width: startW, height: startH});
                
                $('#avatar').imgAreaSelect({
                    fadeSpeed: true,
                    aspectRatio: '1:1',
                    handles: true,
                    minWidth:100,
                    autohide:true,
                    minHeight: 100,
                    onSelectChange: preview
                });
            }
            
            var isset_preview = false;
            var img_name=$('#avatar_true_name').val();
            
            $(document).ready(function () {
                if($('input[name=x1]').val()){
                    console.log(img_name);
                    $('#miniImage').attr('src', $("#avatar").attr('src'));
                    $('#review-row').css('display', 'block');
                    isset_preview=true;
                    startSelect($('input[name=x1]').val(), $('input[name=y1]').val(), $('input[name=x2]').val(), $('input[name=y2]').val(), $('input[name=w]').val(), $('input[name=h]').val());
                }
            });
                        
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
                          <div class="panel-body" id="edit-profile-a">
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
            <div class="col-xs-12 col-md-offset-3 col-md-8 col-lg-offset-3 col-lg-7">
                <div class="row">
                    <form id="form_edit_profile" action="../controllers/save_profile.php" method="POST" class="form-horizontal" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-xs-12">
                                <img src="<?=getProfileImage()?>" id="avatar" alt="Аватар" class="center-block img-rounded img-responsive">
                                <div style="margin-top: 10px; display:none;" id="review-row" class="row">
                                    <div class="col-xs-offset-3 col-xs-6 col-sm-offset-4 col-sm-4">
                                        <div class="row">
                                            <div class="col-xs-2">
                                                <a class="pull-right fa fa-repeat"></a>
                                            </div>
                                            <div class="col-xs-8">
                                                <div class="center-block" style="width:100px; height: 100px; border-radius: 50%; box-shadow: 0px 0px 30px 1px rgba(0, 0, 0, 0.5); overflow: hidden;">
                                                    <img src="" id="miniImage">
                                                </div>
                                            </div>
                                            <div class="col-xs-2">
                                                <a class="pull-left fa fa-undo"></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-offset-2 col-xs-8 col-sm-offset-3 col-sm-6 col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6" style="margin-top:15px;">    
                                    <label class="text-center" for="selectImage">Изображение профиля</label>
                                    <div class="input-group-file-field">
                                        <input type="text" id="file_name" name="file_name" readonly class="form-control">
                                        <span class="input-group-btn">
                                            <span id="addImage" class="btn btn-primary btn-file"><span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span>
                                                <input type="file" accept="image/jpeg,image/gif" id="selectImage" name="avatar">
                                            </span>
                                            <a href="../index.php?action=delete_image" id="delImage" class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span></a>
                                        </span>
                                        <input type="hidden" name="x1" value="<?=$crop[0]?>">
                                        <input type="hidden" name="y1" value="<?=$crop[1]?>">
                                        <input type="hidden" name="x2" value="<?=$crop[2]?>">
                                        <input type="hidden" name="y2" value="<?=$crop[3]?>">
                                        <input type="hidden" name="w" value="<?=$crop[4]?>">
                                        <input type="hidden" name="h" value="<?=$crop[5]?>">
                                        <input type="hidden" name="r" value="<?=$select['angle']?>">
                                        <input id="avatar_true_name" type="hidden" value="<?=getProfileImage('first')?>">
                                    </div>
                                </div>
                                <div class="col-xs-offset-2 col-xs-8 col-sm-offset-3 col-sm-6 col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
                                <div class="form-group">
                                    <label for="last_name" class="col-sm-2 control-label">
                                        Фамилия:
                                    </label>
                                    <div class="col-sm-offset-1 col-sm-9">
                                        <input placeholder="<?=$fio[0]?>" type="text" class="form-control" id="last_name" name="last_name"> 
                                    </div>
                                </div>
                                <div class="form-group" class="col-sm-offset-1 col-sm-9">
                                    <label for="first_name" class="col-sm-2 control-label">
                                        Имя:
                                    </label>
                                    <div class="col-sm-offset-1 col-sm-9">
                                        <input placeholder="<?=$fio[1]?>" type="text" class="form-control" id="first_name" name="first_name">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="middle_name" class="col-sm-2 control-label">
                                        Отчество:
                                    </label>
                                    <div class="col-sm-offset-1 col-sm-9">
                                        <input placeholder="<?=$fio[2]?>" type="text" class="form-control" id="middle_name" name="middle_name">
                                    </div>
                                </div>
                                <div>
                                   <div class="form-group">
                                       <button id="save" type="submit" class="center-block btn btn-success">Сохранить</button>
                                   </div>
                               </div>
                            </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
       </div>
   </div>
</body>
</html>