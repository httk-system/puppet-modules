class provide_managed() {

  include 'provide_control'
  
  file { '/usr/control/manage':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/provide_managed/manage',
    require => File['/usr/control'],
  }

  file { '/etc/sudoers.d/puppet-setups-manage':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    source  => 'puppet:///modules/provide_managed/etc-sudoers.d-puppet-setups-manage',
  }
  
}
