# @summary Configure the Telegraf disk input plugin.
class telegraf::plugin::disk {
  telegraf::plugin { '[inputs.disk]': }
}
