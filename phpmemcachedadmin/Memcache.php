<?php
return array (
  'stats_api' => 'Server',
  'slabs_api' => 'Server',
  'items_api' => 'Server',
  'get_api' => 'Server',
  'set_api' => 'Server',
  'delete_api' => 'Server',
  'flush_all_api' => 'Server',
  'connection_timeout' => '5',
  'max_item_dump' => '100',
  'refresh_rate' => 5,
  'memory_alert' => '80',
  'hit_rate_alert' => '90',
  'eviction_alert' => '0',
  'file_path' => 'Temp/',
  'servers' =>
  array (
    'Default' =>
    array (
      getenv('MEMCACHED_HOST').':'.getenv('MEMCACHED_PORT') =>
      array (
        'hostname' => getenv('MEMCACHED_HOST'),
        'port' => getenv('MEMCACHED_PORT'),
      ),
    ),
  ),
);
