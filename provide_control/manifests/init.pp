class provide_control() {

  include stddirs
  
  file { '/etc/profile.d/puppet-setups-control.sh':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/provide_control/etc-profile.d-puppet-setups-control.sh',
    require => File['/usr/control'],
  }

  file { '/etc/sudoers.d/control_set_default_path':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    content => "Defaults secure_path = \"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/usr/control\"\n"
  }
}
