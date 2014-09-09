define php5::config(
  $value,
  $target = '/etc/php5/conf.d/zzz_common.ini',
  $section = '',
  $setting = '',
  $ensure = 'present'
) {
  if ($section) {
    $use_section = $section
  }
  else {
    $use_section = '.anon'
  }

  if ($setting) {
    $use_setting = $setting
  }
  else {
    $use_setting = $name
  }

  $full_target = "files${target}/${use_section}"

  if ($ensure == 'absent') {
    $use_command = 'rm'
  }
  else {
    $use_command = 'set'
  }

  augeas { "php-config-${target}-${name}":
    context => $full_target,
    changes => "${use_command} ${use_setting} ${value}",
    require => Package['php5-common'],
  }
}
