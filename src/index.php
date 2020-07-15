<h1>Intentando conectarnos a BD</h1>
<?php

$conn = new mysqli('10.28.0.2', 'eje', 'ejecutantes', 'test');

if ($conn->connect_errno) {
  echo "Error de conexión";
} else {
  echo "Conexión exitosa";
}

phpinfo();

?>
