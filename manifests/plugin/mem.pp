# @summary Configure the Telegraf memory input plugin.
class telegraf::plugin::mem {
  telegraf::plugin { '[inputs.mem]': }
}
