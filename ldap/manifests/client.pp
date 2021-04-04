class ldap::client (
) {
    package {
       'libnss-ldap':
            ensure => installed,
	    ;
       'libpam-ldap':
            ensure => installed,
	    ;
       'ldap-utils':
            ensure => installed,
	    ;	    
    }

    file {
       '/root/bin/ldap_client_install.sh':
       content => template('nscmodules/ldap/root-bin-ldap_client_install.sh.erb'),
       ensure => present,
       owner => 'root', group => 'root', mode => '0700',
    }

    exec {
       '/root/bin/ldap_client_install.sh':
           require => File['/root/bin/ldap_client_install.sh'],
	   creates => '/root/flags/ldap_client-installed',
    }
}
