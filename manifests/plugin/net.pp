# @summary Configure the Telegraf network input plugin.
#
# @param interfaces Interface patterns to collect.
class telegraf::plugin::net (
  Array[String] $interfaces = [],
) {
  telegraf::plugin { '[inputs.net]':
    conf => {
      'interfaces' => $interfaces,
    },
  }
}
