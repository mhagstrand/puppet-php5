class php5::cli(
  $version = 'installed'
) inherits php5 {
  $sapi = 'cli'

  package { 'php5-cli':
    ensure => $version,
    before => Package['php5-common'],
  }

  $config_changes += [
    'set display_errors On',
  ]

  augeas { 'php.ini/cli/PHP':
    context => '/files/etc/php5/cli/php.ini/PHP/',
    changes => $config_changes,
    require => Package['php5-cli'],
  }
}
