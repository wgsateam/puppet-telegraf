# @summary Configure the Telegraf CPU input plugin.
#
# @param percpu Collect per-CPU metrics.
# @param totalcpu Collect total CPU metrics.
class telegraf::plugin::cpu (
  Boolean $percpu   = true,
  Boolean $totalcpu = true,
) {
  telegraf::plugin { '[inputs.cpu]':
    conf => {
      'percpu'   => $percpu,
      'totalcpu' => $totalcpu,
    },
  }
}
