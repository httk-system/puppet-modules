class control() {

  file { '/usr/control':
    ensure => 'directory',
    owner => 'root',
    mode => '0744',
  }

}
