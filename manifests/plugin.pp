# @summary Render a Telegraf plugin config fragment.
#
# @param order File ordering prefix.
# @param conf Plugin configuration hash.
# @param plugin_name Rendered plugin section name.
# @param sensitive Wrap rendered content in Sensitive.
define telegraf::plugin (
  Variant[String, Integer] $order       = '10',
  Optional[Hash]           $conf        = undef,
  Optional[String]         $plugin_name = undef,
  Boolean                  $sensitive   = false,
) {
  $real_name = pick($plugin_name, $title) ### used for fragment.erb

  # Hide the rendered config from catalog/reports when it contains secrets.
  $content = $sensitive ? {
    true    => Sensitive(template('telegraf/fragment.erb')),
    default => template('telegraf/fragment.erb'),
  }

  $plugin_file = regsubst($title, '\[|\]', '', 'G')
  file { "/etc/telegraf/telegraf.d/${order}-${plugin_file}.conf":
    ensure  => file,
    content => $content,
    notify  => Service[$telegraf::service_name],
  }
}
