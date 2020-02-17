### Puppet module to install and configure telegraf --- an OSS influxdb client

Supports telegraf 0.1.9+

Example:

```puppet
class { 'telegraf':
  tags => {
    dc => $dc,
    # some other tags if you like...
  }
}
class { 'telegraf::outputs::amqp':
  url         => 'amqp://sample_user:sample_password@sample_mq_host:5672/sample_vhost',
  exchange    => 'telegraf',
  routing_tag => 'dc',
}
```

Custom output example:

```puppet
telegraf::outputs { "prometheus_client.${dc}":
  conf => {
    'listen'   => ":${port}",
    'path'     => $path,
    'namepass' => $namepass
  }
}

telegraf::outputs { "prometheus_client.${dc2}":
  conf => {
    'listen'   => ":${port}",
    'path'     => $path,
    'namepass' => $namepass
  }
}
```

Custom metrics example:

```puppet
telegraf::plugin { '[inputs.logparser.nginx_access_log]':
  plugin_name => '[inputs.logparser]',
  order       => '05',
  conf        => {
    'files'                   => ['/var/log/nginx/access.log'],
    'from_beginning'          => false,
    '[inputs.logparser.grok]' => {
      'patterns'        => ['%{RT_CACHE_LOG_FORMAT}'],
      'custom_patterns' => 'RT_CACHE_LOG_FORMAT %{IP:client_ip} %{NOTSPACE:ident} %{NOTSPACE:upstream_cache_status} \[%{HTTPDATE:timestamp}\]  "(?:%{WORD:verb} %{NOTSPACE:request}(?: HTTP/%{NUMBER:httpversion})?|%{DATA:rawrequest})" %{NUMBER:resp_code:tag} (?:%{NUMBER:resp_bytes:int}|-) %{QS:referrer} %{QS:agent} %{QS:request_time} %{QS:upstream_response_time} %{QS:upstream_addr}',
      'measurement'     => 'nginx_access_log'
    }
  }
}
```
