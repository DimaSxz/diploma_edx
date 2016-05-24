<?php

    session_start();
    require_once('../controllers/is_auth.php');
    if(isset($_SESSION['is_auth']) && $_SESSION['is_auth'])
    {
        if(is_auth()){
            header("Location: ../index.php?action=lk");
        }
    }

?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Модуль администрирования Open edX</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=0.85, user-scalable=no">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/normalize.css">
    <link rel="stylesheet" href="../css/entry.css">
    <script src="../js/jquery-2.1.4.js"></script>
    <script src="../js/bootstrap.js"></script>

    <script>
        $(function() {
            $('#login_login, #password_login').focus(function() {
                $(this).parents('.form-group').removeClass('has-error has-feedback');
                $(this).next('.glyphicon-remove').css('display', 'none');
            });

            $('#enter_btn').on('click', function() {
                var user_login = $('#login_login').val();
                var user_password = $('#password_login').val();
                $.post (
                    "../controllers/auth.php",
                    {login: user_login, password: user_password},
                    function (responce) {
                        if (responce == "bad") {
                            $('#alert-check-correctness').css('display', 'none');
                            $('#alert-good').css('display', 'none');
                            $('#alert-check-login-pas').css('display','block');
                            $('#login_login').parents('.form-group').addClass('has-error has-feedback');
                            $('#login_login').next('.glyphicon-remove').css('display', 'inline');
                            $('#password_login').parents('.form-group').addClass('has-error has-feedback');
                            $('#password_login').next('.glyphicon-remove').css('display', 'inline');
                        } else {
                            $(location).attr('href','../index.php?action=lk');
                        }
                    }
                );
            });

            $(document).on('keyup','input', function(e){
                if(e.keyCode == 13)
                    $('.active .form-group button').click();
            });

        });
    </script>

</head>
<body>
    <div class="container">
       <div class="row">
          <div class="col-xs-10 col-xs-offset-1 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3" id="alert-check-correctness" style="display: none;">
              <div class="alert alert-danger alert-dismissible" role="alert" style="margin-top: 50px;">
                   <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                   <strong>Ошибка!</strong> Проверьте корректность ввода данных
              </div>
          </div>
          <div class="col-xs-10 col-xs-offset-1 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3" id="alert-check-login-pas" style="display: none;">
              <div class="alert alert-danger alert-dismissible" role="alert" style="margin-top: 50px;">
                   <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                   <strong>Ошибка!</strong> Неверный логин или пароль
              </div>
          </div>
          <div class="col-xs-10 col-xs-offset-1 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3" id="alert-good" style="display: none;">
             <div class="alert alert-success alert-dismissible" role="alert" style="margin-top: 50px;">
                   <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                   <strong>Успех!</strong> Регистрация успешно завершена
              </div>
          </div>
       </div>
        <div class="row">
            <div class="col-xs-10 col-sm-8 col-md-6 col-lg-4 centered center-block">
                <ul class="nav nav-tabs">
                    <li role="presentation" class="active">
                        <a href="#login" data-toggle="tab" aria-hidden="true">Вход</a>
                    </li>
                </ul>

                <div class="tab-content form-content">
                    <div id="login" class="tab-pane fade in active">
                        <form action="../controllers/auth.php" class="form-horizontal" method="post">
                            <div class="form-group">
                                <label for="login_login" class="col-xs-4 control-label">
                                    Логин:
                                </label>
                                <div class="col-xs-7 col-md-6">
                                    <input required type="text" class="form-control" id="login_login" name="login">
                                    <span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true" style="display: none;"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="password_login" class="col-xs-4 control-label">
                                    Пароль:
                                </label>
                                <div class="col-xs-7 col-md-6">
                                    <input required type="password" class="form-control" id="password_login" name="password">
                                    <span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true" style="display: none;"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <button type="button" class="center-block btn btn-success" id="enter_btn">Войти</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
   </div>
</body>
</html>
