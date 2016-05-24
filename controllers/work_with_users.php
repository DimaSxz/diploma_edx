<?php
  require_once("db.php");

  function getNames($name) {
    $arrNames = array();
    $select = mysql_query("SELECT `a`.`user_id`, `a`.`name`, `b`.`is_staff`, `b`.`is_superuser`
                           FROM `auth_userprofile` AS `a`
                           LEFT JOIN `auth_user` AS `b`
                           ON `b`.`id` = `a`.`user_id`
                           WHERE `name` LIKE '%$name%'")
                           or die(mysql_error());
    while ($result = mysql_fetch_assoc($select)) {
      $arrNames[] = $result;
    }
    return $arrNames;
  }

  function getInfoById($userId) {

  }

  function changePermissions($userId, $permissions) {
    switch($permissions) {
      case "1":
        mysql_query("UPDATE `auth_user`
                     SET `is_staff` = 0, `is_superuser` = 0
                     WHERE `id` = '$userId'") or die(mysql_error());
        break;
      case "2":
        mysql_query("UPDATE `auth_user`
                     SET `is_staff` = 1, `is_superuser` = 0
                     WHERE `id` = '$userId'") or die(mysql_error());
        break;
      case "3":
        mysql_query("UPDATE `auth_user`
                     SET `is_staff` = 1, `is_superuser` = 1
                     WHERE `id` = '$userId'") or die(mysql_error());
        break;
    }
    return "good";
  }

  function getUserPerm($username) {
    $select = mysql_query("SELECT `is_staff`, `is_superuser`
                           FROM `auth_user`
                           WHERE `username` = '$username'") or die(mysql_error());
    return mysql_fetch_assoc($select);
  }

  switch ($_POST["status"]) {
    case 1:
        $data = json_encode(getNames($_POST["name"]));
        break;
    case 2:
        $data = json_encode(getInfoById($_POST["userId"]));
        break;
    case 3:
        $data = json_encode(changePermissions($_POST["userId"], $_POST["permissions"]));
        break;
    case 4:
        $data = json_encode(getUserPerm($_POST["username"]));
        break;
  }
  echo $data;
?>
