class php5::cgi(
  $version = 'installed'
) inherits php5 {
  $sapi = 'cgi'

  package { 'php5-cgi':
    ensure => $version,
    before => Package['php5-common'],
  }

  augeas { 'php.ini/cgi/PHP':
    context => '/files/etc/php5/cgi/php.ini/PHP/',
    changes => $config_changes,
    require => Package['php5-cgi'],
  }
}
