define telegraf::plugin (
  Variant[String, Integer]  $order      = 10,
  Optional[Hash]            $conf       = undef,
  Optional[String]          $plugin_name  = undef, 
) {

  if $plugin_name {
    $real_name = $plugin_name
  } else {
    $real_name = $title
  }
  $plugin_file = regsubst($title, '\[|\]', '', 'G')

  file { "/etc/telegraf/telegraf.d/${order}-${plugin_file}":
    ensure  => file,
    content => template('telegraf/fragment.erb'),
  }
}
