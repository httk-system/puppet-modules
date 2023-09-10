class provide_managed() {

  include stddirs
  include 'provide_control'
  
  file { '/etc/sudoers.d/puppet-setups-manage':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    source  => 'puppet:///modules/provide_managed/etc-sudoers.d-puppet-setups-manage',
  }

  file { '/usr/control/manage':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/provide_managed/manage',
    require => File['/usr/control'],
  }  
  
  file { '/root/managed':
    ensure => 'directory',
    owner => 'root',
    mode => '0700',
  }
  
  file { '/root/managed/secrets':
    ensure => 'directory',
    owner => 'root',
    mode => '0700',
    require=>File['/root/managed'],
  }

  file { '/root/managed/flags':
    ensure => 'directory',
    owner => 'root',
    mode => '0700',
    require=>File['/root/managed'],
  }

  file { '/root/managed/collectors':
    ensure => 'directory',
    owner => 'root',
    mode => '0700',
    require=>File['/root/managed'],
  }

  file { '/root/managed/installers':
    ensure => 'directory',
    owner => 'root',
    mode => '0700',
    require=>File['/root/managed'],
  }
  
}
