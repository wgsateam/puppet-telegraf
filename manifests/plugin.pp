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
    notify  => Service[$telegraf::service_name],
  }

}
