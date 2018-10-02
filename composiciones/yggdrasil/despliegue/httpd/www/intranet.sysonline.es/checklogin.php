<?php
	session_start();
	?>
	<?php
	$host_db = "192.168.1.151";
	$user_db = "intranet";
	$pass_db = "esclarecido";
	$db_name = "intranet";
	$tbl_name = "users";
	$conexion = new mysqli($host_db, $user_db, $pass_db, $db_name);
	if ($conexion->connect_error) {
	 die("La conexion falló: " . $conexion->connect_error);
	}
	$username = $_POST['username'];
	$password = $_POST['password'];
	$sql = "SELECT * FROM $tbl_name WHERE username = '$username'";
	$result = $conexion->query($sql);
	if ($result->num_rows > 0) {
	 }
	 $row = $result->fetch_array(MYSQLI_ASSOC);
	 if (password_verify($password, $row['password'])) {
	    $_SESSION['loggedin'] = true;
	    $_SESSION['username'] = $username;
	    $_SESSION['start'] = time();
	    $_SESSION['expire'] = $_SESSION['start'] + (5 * 60);
	    echo "Bienvenido! " . $_SESSION['username'];
	    echo "<br><br><a href=panel-control.php>Panel de Control</a>";
	 } else {
	   echo "Username o Password estan incorrectos.";
	   echo "<br><a href='login.html'>Volver a Intentarlo</a>";
	 }
	 mysqli_close($conexion);
	 ?>
