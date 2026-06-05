# @summary Configure the Telegraf system input plugin.
class telegraf::plugin::system {
  telegraf::plugin { '[inputs.system]': }
}
