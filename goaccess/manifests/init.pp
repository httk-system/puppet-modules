class goaccess (
){

  include provide_control

  package { 'goaccess':
    	ensure => 'installed',
  }

  file { '/usr/control/goaccess-update-static':
      content => template('goaccess/goaccess-update-static.erb'),
      ensure => present,
      owner => 'root', group => 'root', mode => '0755',
  }

}
