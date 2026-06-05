# @summary Configure the Telegraf disk I/O input plugin.
class telegraf::plugin::io {
  telegraf::plugin { '[inputs.io]': }
}
