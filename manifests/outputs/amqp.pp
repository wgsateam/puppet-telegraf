define telegraf::outputs::amqp (
  $amqp_hub,
  $amqp_user,
  $amqp_pass,
  $amqp_vhost,
  $amqp_port            = '5672',
  $exchange             = '',
  $routing_tag          = '',
  $ssl_ca               = '',
  $ssl_cert             = '',
  $ssl_key              = '',
  $precision            = 'n',
  $retention_policy     = 'default',
  $database             = 'telegraf',
  $namepass             = [],
  $namedrop             = [],
  $insecure_skip_verify = false,
) {

  if $facts['os']['name'] == 'CentOS' and $facts['os']['release']['major'] == '7' {

    telegraf::plugin { "[outputs.amqp.${title}]":
      plugin_name => '[outputs.amqp]',
      order       => 3,
      conf        => {
        'brokers'              => ["amqp://${amqp_hub}:${amqp_port}/${amqp_vhost}"],
        'headers'              => "{\"database\" = \"${database}\", \"retention_policy\" = \"${retention_policy}\"}",
        'exchange'             => $exchange,
        'routing_tag'          => $routing_tag,
        'ssl_ca'               => $ssl_ca,
        'ssl_cert'             => $ssl_cert,
        'ssl_key'              => $ssl_key,
        'precision'            => $precision,
        'namepass'             => $namepass,
        'namedrop'             => $namedrop,
        'insecure_skip_verify' => $insecure_skip_verify,
      }
    }
  } else {
    telegraf::plugin { "[outputs.amqp.${title}]":
      plugin_name => '[outputs.amqp]',
      order       => 3,
      conf        => {
        'url'                  => "amqp://${amqp_user}:${amqp_pass}@${amqp_hub}:${amqp_port}/${amqp_vhost}",
        'exchange'             => $exchange,
        'routing_tag'          => $routing_tag,
        'ssl_ca'               => $ssl_ca,
        'ssl_cert'             => $ssl_cert,
        'ssl_key'              => $ssl_key,
        'precision'            => $precision,
        'retention_policy'     => $retention_policy,
        'database'             => $database,
        'namepass'             => $namepass,
        'namedrop'             => $namedrop,
        'insecure_skip_verify' => $insecure_skip_verify,
      }
    }
  }
}
