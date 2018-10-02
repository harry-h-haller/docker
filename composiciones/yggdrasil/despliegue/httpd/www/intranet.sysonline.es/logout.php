<?php

session_start();
unset ($SESSION['username']);
session_destroy();

header('Location: http://127.0.0.1/intranet/index.php');

?>
