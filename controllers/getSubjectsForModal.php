<?php
    session_start();
    require_once('../controllers/db.php');

    function getSubjectsForModal() {
        $user_id = $_SESSION['user_id'];
        $result = mysql_query("SELECT id, full_title FROM subjects JOIN user_subjects ON id = subject_id WHERE user_id = '$user_id'");
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