class php5 {
	package { 'php5-common':
		ensure => 'present',
	}

	package { [
		'php5-suhosin',
		'php5-pspell',
		'php5-mysql',
		'php5-memcache',
		'php5-mcrypt',
		'php5-gd',
		'php5-curl',
		'php5-imap',
		'php5-imagick',
		'php5-intl',
	]:
		ensure  => 'present',
		require => Package['php5-common'],
	}

	file { '/etc/php5/conf.d/zzz_common.ini':
		ensure  => present,
		owner   => root,
		group   => root,
		mode    => 0644,
		content => "; managed by puppet\n",
		replace => false,
		require => Package['php5-common'],
	}

	$config_changes = [
		"set register_globals Off", # Basic security
		"set expose_php Off", # Required for Nessus / Netsparker scans to succeed
		"set display_errors Off", # Basic security
		"set log_errors On", # Basic security
		"set allow_url_include Off",
		"set allow_url_fopen On",
		"set short_open_tag Off",
		"set asp_tags Off",
		"set allow_call_time_pass_reference Off",
		"set date.timezone America/Chicago",
	]
}