class stddirs() {

  file { '/usr/control':
    ensure => 'directory',
    owner => 'root',
    mode => '0744'
  }

  file { '/root/secrets':
    ensure => 'directory',
    owner => 'root',
    mode => '0700',
  }

  file { '/root/bin':
    ensure => 'directory',
    owner => 'root',
    mode => '0700'
  }

  file { '/root/puppet':
    ensure => 'directory',
    owner => 'root',
    mode => '0700',
  }
  
  file { '/root/puppet/installers':
    ensure => 'directory',
    owner => 'root',
    mode => '0700',
    require=>File['/root/puppet']
  }

  file { '/root/puppet/flags':
    ensure => 'directory',
    owner => 'root',
    mode => '0700',
    require=>File['/root/puppet']
  }  
}
