define telegraf::plugin (
  Variant[String, Integer] $order       = '10',
  Optional[Hash]           $conf        = undef,
  Optional[String]         $plugin_name = undef,
) {

  $real_name = pick($plugin_name, $title) ### used for fragment.erb

  $plugin_file = regsubst($title, '\[|\]', '', 'G')
  file { "/etc/telegraf/telegraf.d/${order}-${plugin_file}.conf":
    ensure  => file,
    content => template('telegraf/fragment.erb'),
  }
  if $telegraf::manage_service {
    service { "plugin_${telegraf::service_name}_reload":
      name      => $telegraf::service_name,
      restart   => "service ${telegraf::service_name} reload",
      subscribe => File["/etc/telegraf/telegraf.d/${order}-${plugin_file}.conf"],
    }
  }

}
