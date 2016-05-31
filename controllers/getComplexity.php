<?php
if($_SESSION['is_superuser'] == 1)
	$courses = mysql_query("SELECT `course_id` FROM `courseware_studentmodule` WHERE `grade` IS NOT NULL GROUP BY `course_id`") or die(mysql_error());
elseif($_SESSION['is_superuser'] == 0 && $_SESSION['is_staff'] == 1)
	$courses = mysql_query("SELECT DISTINCT `course_id` FROM `courseware_studentmodule` WHERE `grade` IS NOT NULL AND `course_id` IN (SELECT `course_id` FROM `student_courseaccessrole` WHERE `user_id`='$_SESSION[id]') GROUP BY `course_id`") or die(mysql_error());
else die("Студенты не могут просматривать эту информацию!");
if(mysql_num_rows($courses) <= 0) die("Не найдено кусров, прошедших оценку"); 
$i = 0;
?>

<div class="panel-group" role="tablist" aria-multiselectable="true">
<?php 
	while($course = mysql_fetch_assoc($courses)):
		$j = 0;
		$course_title = explode(':', $course['course_id']);
		$course_title = explode('+', $course_title[1]);
		$course_title = isset($course_title[1]) ? $course_title[1] : $course['course_id'];
		$parts = mysql_query("SELECT `module_type`, `module_id`, `max_grade` FROM `courseware_studentmodule` WHERE `grade` IS NOT NULL AND `course_id`='$course[course_id]' AND `module_type` <> 'course' GROUP BY `module_id`") or die(mysql_error());
?>
	<div class="panel panel-default">
		<div class="panel-heading" role="tab" id="heading" 1="">
			<h3 class="panel-title"><?=$course_title?><a class="btn-more-info" role="button" data-toggle="collapse" data-parent="#accordion-user-courses" href="#collapse<?=$i?>"><span class="glyphicon glyphicon-plus"></span></a></h3>
		</div>
		<div id="collapse<?=$i?>" class="panel-collapse collapse" role="tabpanel" aria-labeledby="heading1">
			<div class="panel-body">
				<div class="panel-group" role="tablist" aria-multiselectable="true">
				<?php 
					while($part = mysql_fetch_assoc($parts)):
						$part_title = explode('@',$part['module_id']);
						$part_title = isset($part_title[2]) ? $part_title[2] : $part['module_id'];
				?>
					<div class="panel panel-default">
						<div class="panel-heading" role="tab" id="heading" 1="">
							<h3 class="panel-title"><?=$part['module_type'].' : '.$part_title?><a class="btn-more-info" role="button" data-toggle="collapse" data-parent="#accordion-user-courses" href="#collapse<?=$i.'_'.$j?>"><span class="glyphicon glyphicon-plus"></span></a></h3>
						</div>
						<div id="collapse<?=$i.'_'.$j?>" class="panel-collapse collapse" role="tabpanel" aria-labeledby="heading1">
							<div class="panel-body">
								<div class="row text-center">
									<div class="col-xs-12">
										<div id="chart<?=$i.'_'.$j?>"></div>
											<script>
											$(function(){
												$('#chart<?=$i.'_'.$j?>').highcharts({
													chart: {
														type: 'column'
													},
													title: {
														text: 'Анализ сложности части курса'
													},
													xAxis: {
														type: 'category',
														title: {
															text: 'Оценка'
														}
													},
													yAxis: {
														title: {
															text: 'Количество пользователей'
														}

													},
													legend: {
														enabled: false
													},
													tooltip: {
														headerFormat: '',
														pointFormat: '{point.y} студентов получили оценку: {point.name}'
													},

													series: [{
														name: 'Оценка',
														colorByPoint: true,
														data: [
										<?php
											$grades['result'] = mysql_query("SELECT count(`grade`) as `count`, `grade` FROM `courseware_studentmodule` WHERE `grade` IS NOT NULL AND `module_id`='$part[module_id]' GROUP BY `grade` ORDER BY `grade`") or die(mysql_error());
											$numerator = 0;
											$denominator = 0;
											$data = "";
											while($grade = mysql_fetch_assoc($grades['result'])){
												$grades[]=$grade;
												$numerator += ($grade['count'] * $grade['grade']);
												$denominator += $grade['count'];
												$data .= "{name: '$grade[grade]',y:$grade[count]},";
											}
											echo substr($data,0,-1);
											unset($grades['result']);
											$result = round(10 - $numerator / $denominator / $part['max_grade'] * 10);
										?>
														]
													}]
												})
											})
										</script>
									</div>
									<p class="col-xs-6">
										Максимальная оценка: <?=$part['max_grade']?>
									</p>
									<p class="col-xs-6">
										Сложность: <?=$result?>
									</p>
								</div>
							</div>
						</div>
					</div>
					<?php
						$j++;
						endwhile;
					?>
				</div>
<!--		ВЫВОД СЛОЖНОСТИ САМОМГО КУРСА		-->
			<?php 
				$courseComplexity = mysql_query("SELECT `module_type`, `module_id`, `max_grade` FROM `courseware_studentmodule` WHERE `grade` IS NOT NULL AND `course_id`='$course[course_id]' AND `module_type`='course' GROUP BY `module_id`") or die(mysql_error());
				if(mysql_num_rows($courseComplexity) > 0):
					while($complexity = mysql_fetch_assoc($courseComplexity)):
			?>
				<div class="row text-center">
					<div class="col-xs-12">
						<div id="chart<?=$i?>"></div>
							<script>
							$(function(){
								$('#chart<?=$i?>').highcharts({
									chart: {
										type: 'column'
									},
									title: {
										text: 'Анализ сложности курса <?=$course_title?>'
									},
									xAxis: {
										type: 'category',
										title: {
											text: 'Оценка'
										}
									},
									yAxis: {
										title: {
											text: 'Количество пользователей'
										}

									},
									legend: {
										enabled: false
									},
									tooltip: {
										headerFormat: '',
										pointFormat: '{point.y} студентов получили оценку: {point.name}'
									},

									series: [{
										name: 'Оценка',
										colorByPoint: true,
										data: [
										<?php
											$grades['result'] = mysql_query("SELECT count(`grade`) as `count`, `grade` FROM `courseware_studentmodule` WHERE `grade` IS NOT NULL AND `module_id`='$complexity[module_id]' GROUP BY `grade` ORDER BY `grade`") or die(mysql_error());
											$numerator = 0;
											$denominator = 0;
											$data = "";
											while($grade = mysql_fetch_assoc($grades['result'])){
												$grades[]=$grade;
												$numerator += ($grade['count'] * $grade['grade']);
												$denominator += $grade['count'];
												$data .= "{name: '$grade[grade]',y:$grade[count]},";
											}
											echo substr($data,0,-1);
											unset($grades['result']);
											$result = round(10 - $numerator / $denominator / $complexity['max_grade'] * 10);
										?>
										]
									}]
								})
							})
						</script>
					</div>
					<p class="col-xs-6">
						Максимальная оценка: <?=$complexity['max_grade']?>
					</p>
					<p class="col-xs-6">
						Сложность: <?=$result?>
					</p>
				</div>
				<?php
					endwhile;
					endif;
				?>
			</div>
		</div>
	</div>
	<?php
		$i++;
		endwhile;
	?>
</div>