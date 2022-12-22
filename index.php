<?php 

require_once("vendor/autoload.php");

$app = new \Slim\Slim();

$app->config('debug', true);

$app->get('/', function() {
	$sql = new \felipesilva15\DB\Sql();

	$data = $sql->select('SELECT * FROM TB_USERS');

	echo(json_encode($data));


});

$app->run();

 ?>