<?php
session_start();

// Destroy the session to log the admin out
session_unset();
session_destroy();

// Redirect to login page
header('Location: admin_login.php');
exit();
?>
