class ldap::server (
) {
  
    package {
	'slapd':
            ensure => installed,
	    ;
	'ldap-utils':
            ensure => installed,
	    ;	    
    }
    ~>    
    service {
	'slapd':
	    enable => true, 
	    ensure => running,
    }

    file { '/root/bin/ldap_server_install.sh':
	content => template('nscmodules/ldap/root-bin-ldap_server_install.sh.erb'),
	ensure => present,
	owner => 'root', group => 'root', mode => '0700',
    }

    file { '/root/control/ldap_refresh_users.sh':
	content => template('nscmodules/ldap/root-bin-ldap_refresh_users.sh.erb'),
	ensure => present,
	owner => 'root', group => 'root', mode => '0700',
    }

    exec {
	'/root/bin/ldap_server_install.sh':
	    require => [
			File['/root/bin/ldap_server_install.sh'],
			Service['slapd'],
			File['/root/secrets'],
			File['/root/flags'],
                        Package['slapd'],
			Package['ldap-utils'],
			],
	    creates => '/root/flags/ldap_server-installed',
	    logoutput => true,
    }
    
}
