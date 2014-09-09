define php5::ioncube(
  $version,
  $ensure = 'present',
  $enable = true
) {
  $loader_path = "/etc/php5/ioncube_loader_${name}.so"
  file { $loader_path:
    ensure => present,
    source => "puppet:///modules/php5/ioncube/ioncube_loader_lin_${version}.so",
    notify => $name ? {
      'fpm'   => Service['php5-fpm'],
      default => undef,
    }
  }

  if ($ensure == 'present' and $enable == true) {
    $changes = [
      "set zend_extension ${loader_path}",
    ]
  }
  else {
    $changes = 'rm zend_extension'
  }

  augeas { "php.ini/${name}/PHP - ioncube":
    context => "/files/etc/php5/${name}/php.ini/PHP/",
    changes => $changes,
    notify  => $name ? {
      'fpm'   => Service['php5-fpm'],
      default => undef,
    }
  }
}
