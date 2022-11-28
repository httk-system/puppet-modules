class control() {

  file { '/usr/control':
    ensure => 'directory',
    owner => 'root',
    mode => '0744',
  }

  file { '/etc/profile.d/puppet-setups-control.sh':
        ensure  => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        source  => 'puppet:///modules/control/etc-profile.d-puppet-setups-control.sh',
  }
  
}
