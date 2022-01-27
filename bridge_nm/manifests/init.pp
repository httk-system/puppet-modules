class bridge (
  $main_net_if,
  $bridge_net_if,
) {
    include public_init

    package {
	'network-manager':
            ensure => installed,
	    ;
    }

    file { '/root/bin/bridge_install.sh':
	content => template('bridge/root-bin-bridge_install.sh.erb'),
	ensure => present,
	owner => 'root', group => 'root', mode => '0700',
    }

    exec {
	'/root/bin/bridge_install.sh':
	    require => [
			File['/root/bin/bridge_install.sh'],
			File['/root/flags'],
			Package['network-manager'],
			],
	    creates => '/root/flags/bridge-installed',
	    logoutput => true,
    }
    
}
