<?php

	session_start();
    require_once('../controllers/db.php');

	switch($_POST['mode']){
		case 'users':
			unset($_POST['mode']);
			usersRating($_POST);
			break;
		case 'courses':
			unset($_POST['mode']);
			coursesRating($_POST);
	}

	exit();

function usersRating($data){
	$query = "SELECT `student_id`, `name`, LEFT(`group_number`, 1) AS `course_number`, `group_number`, SUM(`grade`*10/`max_grade`) + COUNT(`grade`) as `result`, COUNT(`grade`) as `count`, SUM(`grade`*10/`max_grade`) as `sum` FROM `courseware_studentmodule` LEFT JOIN `auth_userprofile` ON `user_id` = `student_id` LEFT JOIN `auth_userprofile_extension` ON `auth_userprofile`.`user_id` = `auth_userprofile_extension`.`user_id` WHERE `grade` IS NOT NULL";
	if($data['only-students'] == 1) $query .= " AND `student_id` IN (SELECT `id` FROM `auth_user` WHERE `is_staff` = '0' AND `is_superuser` = '0')";
	$query .= " GROUP BY `student_id`";
	switch($data['sort']){
		case 'regular':
			$query .= "ORDER BY `result` DESC";
			break;
		case 'activity':
			$query .= "ORDER BY `count` DESC";
			break;
		case 'performance':
			$query .= "ORDER BY `sum` DESC";
	}
	$result = mysql_query($query) or die(mysql_error());
	$answer = "";
	$i = 1;
	while($row = mysql_fetch_assoc($result)){
		$answer .= "<tr>
						<th scope='row'>$i</th>
						<td>$row[name]</td>
						<td>$row[course_number]</td>
						<td>$row[group_number]</td>
					</tr>";
		$i++;
	}
	echo json_encode($answer);
}

function coursesRating($data){
	$query = "SELECT `student_courseenrollment`.`course_id`, `T1`.`count`, IFNULL(`T2`.`verified`, '0') as `verified`, IFNULL(`T1`.`count`+`verified`, `T1`.`count`) as `result` FROM `student_courseenrollment` LEFT JOIN (SELECT `course_id`, count(`user_id`) as `count` FROM `student_courseenrollment` WHERE `is_active`='1'";
	switch($data['period']){
		case 'today': $query .= " AND `user_id` IN (SELECT `student_id` FROM `courseware_studentmodule` WHERE `modified` >= CURDATE())";
			break;
		case 'week': $query .= " AND `user_id` IN (SELECT `student_id` FROM `courseware_studentmodule` WHERE `modified` >= DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY))";
			break;
		case 'month': $query .= " AND `user_id` IN (SELECT `student_id` FROM `courseware_studentmodule` WHERE `modified` >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))";
			break;
		case 'year': $query .= " AND `user_id` IN (SELECT `student_id` FROM `courseware_studentmodule` WHERE `modified` >= DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))";
			break;
	}
	$query .= " GROUP BY `course_id`) `T1` ON `T1`.`course_id`=`student_courseenrollment`.`course_id` LEFT JOIN (SELECT `course_id`, count(`mode`) as `verified` FROM `student_courseenrollment` WHERE `mode` LIKE 'verified' GROUP BY `course_id`) `T2` ON `T2`.`course_id`=`T1`.`course_id` WHERE `count` IS NOT NULL GROUP BY `course_id` ORDER BY `result` DESC";
	$result = mysql_query($query) or die(mysql_error());
	$answer="";
	$i = 1;
	while($row = mysql_fetch_assoc($result)){
		$title = explode(':', $row['course_id']);
		if(isset($title[1])){
			$title = explode('+', $title[1]);
			$title = isset($title[1]) ? $title[1] : $row['course_id'];
		}
		else $title = $row['course_id'];
		$answer .= "<tr>
						<th scope='row'>$i</th>
						<td>$title</td>
						<td>$row[count]</td>
					</tr>";
		$i++;
	}
	echo json_encode($answer);
}
?>