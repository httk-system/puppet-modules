class timesyncd (
  $ntpservers
) {
  
  package { 'systemd-timesyncd':
    ensure => 'installed'
  }
  ->
  file { '/etc/systemd/timesyncd.conf':
    content => template('timesyncd/etc-systemd-timesyncd.conf.erb'),
    ensure => present,
    owner => 'root', group => 'root', mode => '0744',
  } ~>
  service { 'systemd-timesyncd':
    ensure => 'running',
    enable => true
  }
}
