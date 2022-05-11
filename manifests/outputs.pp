define telegraf::outputs (
  Optional[Hash] $conf = undef
) {
  $plugin_name = split($title, '[.]')[0]
  telegraf::plugin { "[outputs.${title}]":
    plugin_name => "[outputs.${plugin_name}]",
    conf        => $conf
  }
}
