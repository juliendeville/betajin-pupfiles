class jinteki::scripts {
  ensure_packages([
    'cronie',
    'python',
  ])

  file {'/usr/local/bin/rebuild.sh':
    source => 'puppet:///modules/jinteki/scripts/rebuild.sh',
    owner => 'root',
    group => 'root',
    mode => '0755',
  }

  cron {'rebuild':
    command => '/usr/local/bin/rebuild.sh',
    user => 'jinteki',
    hour => [0, 6, 12, 18],
    minute => 0,
    require => [File['/usr/local/bin/rebuild.sh']],
    notify => Service['cronie'],
  }

  service {'cronie':
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
    require => Package['cronie'],
  }
}
