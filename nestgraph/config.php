<?php

$config = array(
        'db_ip' => getenv('MYSQL_HOST'),
        'db_user' => getenv('MYSQL_USER'),
	    'db_pass' => getenv('MYSQL_PASSWORD'),
	    'db_name' => getenv('MYSQL_DB_NAME'),
	    'nest_user' => getenv('NEST_USERNAME'),
	    'nest_pass' => getenv('NEST_PASSWORD'),
        'local_tz' => getenv('TZ')
    );

?>
