# telegraf

Puppet module to install and configure Telegraf.

## Compatibility

This module requires Puppet or OpenVox `>= 7.34.0 < 9.0.0`.

The module metadata declares support for:

- CentOS 7
- OracleLinux 7, 8, 9
- RedHat 7, 8, 9
- Debian 10, 11, 12, 13
- Ubuntu 20.04, 22.04, 24.04, 26.04

## Dependencies

- `puppetlabs-stdlib >= 9.0.0 < 10.0.0`

## Usage

Example:

```puppet
class { 'telegraf':
  tags => {
    dc => $dc,
    # some other tags if you like...
  }
}
```

Every plugin, including outputs, is a `telegraf::plugin` resource. The title
names the file in `/etc/telegraf/telegraf.d` (`<order>-<title>.conf`), and
`plugin_name` sets the TOML table. Use distinct titles to run several
instances of the same plugin.

Output example:

```puppet
telegraf::plugin { 'prometheus_client':
  plugin_name => '[outputs.prometheus_client]',
  conf        => {
    'listen'   => ':9273',
    'path'     => '/metrics',
    'namepass' => ['prometheus*'],
  },
}
```

Custom metrics example (nginx access log parsed with grok):

```puppet
telegraf::plugin { '[inputs.tail.nginx_access_log]':
  plugin_name => '[inputs.tail]',
  order       => '05',
  conf        => {
    'files'         => ['/var/log/nginx/access.log'],
    'data_format'   => 'grok',
    'grok_patterns' => ['%{COMBINED_LOG_FORMAT}'],
    'name_override' => 'nginx_access_log',
  },
}
```

Sub-tables such as tags are passed as hash keys with the full table name:

```puppet
telegraf::plugin { '[inputs.exec.my_check]':
  plugin_name => '[inputs.exec]',
  conf        => {
    'commands'           => ['/usr/local/bin/my_check'],
    'data_format'        => 'influx',
    '[inputs.exec.tags]' => {
      'team' => 'wgsa',
    },
  },
}
```

Sensitive values example:

When a plugin config contains a secret (e.g. a DSN with a password), set
`sensitive => true` and wrap the secret value in `Sensitive(...)`. The plaintext
is still written to the telegraf config file (telegraf needs it), but the
rendered file content is wrapped in `Sensitive`, so the secret does not leak
into the catalog, reports or run diffs.

```puppet
telegraf::plugin { '[inputs.mysql.db]':
  plugin_name => '[inputs.mysql]',
  sensitive   => true,
  conf        => {
    'metric_version' => 2,
    'servers'        => [Sensitive("telegraf:${password}@tcp(127.0.0.1:3306)/")],
  },
}
```
