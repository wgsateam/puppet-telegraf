class telegraf(
  Boolean              $manage_service = true,
                       $version = 'installed',
                       $telegraf_hostname = $::hostname,
  String               $package_name = 'telegraf',
  Hash                 $package_options = {},
  String               $service_name = 'telegraf',
  Stdlib::Absolutepath $conf_path = $telegraf::params::conf_path,
  Array[String]        $plugins = ['mem', 'cpu', 'disk', 'swap', 'system', 'io', 'net'],
                       $tags = undef,
                       $interval = '10s',
) inherits telegraf::params {
  package { $package_name:
    ensure => $version,
    name   => $package_name,
    *      => $package_options
  }
  file { $conf_path:
    ensure  => file,
  }
  file { '/etc/telegraf/telegraf.d':
    ensure => directory,
    group  => 'telegraf',
    mode   => '0775',
  }

  if $manage_service {
    service { $service_name:
      ensure  => running,
      enable  => true,
      name    => $service_name,
      require => Package[$package_name],
    }
  }

  telegraf::plugin { 'global_tags':
    order => '01',
    conf  => $tags,
  }

  telegraf::plugin { 'agent':
    order => '00',
    conf  => {
      'interval'  => $interval,
      'utc'       => true,
      'precision' => 'n',
      'debug'     => false,
      'hostname'  => $telegraf_hostname,
    }
  }
  $plugins.each |$plugin| {
    include "telegraf::plugin::${plugin}"
  }
}
