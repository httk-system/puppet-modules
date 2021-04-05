class ldap::common {

    package {
	'ldap-utils':
            ensure => installed,
	    ;	    
    }
}
