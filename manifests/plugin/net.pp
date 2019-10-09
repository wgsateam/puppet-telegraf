class telegraf::plugin::net (
  Array[String] $interfaces = [],
) {
  telegraf::plugin { '[inputs.net]':
    conf => {
      'interfaces' => $interfaces,
    }
  }
}
