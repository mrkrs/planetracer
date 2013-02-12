<?php

header('Access-Control-Allow-Origin: *');

$c = curl_init();

$url = 'http://planefinder.net/endpoints/update.php?faa=1';

curl_setopt($c, CURLOPT_URL, $url );

curl_setopt($c, CURLOPT_RETURNTRANSFER, true);

curl_setopt($c, CURLOPT_HEADER, false);

$output = curl_exec($c);

if($output === false)
{
	trigger_error('Erreur curl : '.curl_error($c),E_USER_WARNING);
}
else
{
	echo ($output);
}
curl_close($c);

?>
