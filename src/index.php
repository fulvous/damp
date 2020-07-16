<h1>Intentando conectarnos a BD</h1>
<?php

$conn = new mysqli('10.28.0.2', 'root', 'ejecutantes', 'mysql');

if ($conn->connect_errno) {
  echo "Error de conexión";
} else {
  echo "Conexión exitosa";
}

phpinfo();

?>
