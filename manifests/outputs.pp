# @summary Configure a Telegraf output plugin.
#
# @param conf Output plugin configuration hash.
define telegraf::outputs (
  Optional[Hash] $conf = undef,
) {
  $plugin_name = split($title, '[.]')[0]
  telegraf::plugin { "[outputs.${title}]":
    plugin_name => "[outputs.${plugin_name}]",
    conf        => $conf,
  }
}
