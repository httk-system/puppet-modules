class ldap::server (
  $ldap_domain="home",
  $ldap_org="home",
) {

    include ldap::common
  
    package {
	'slapd':
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
	content => template('ldap/root-bin-ldap_server_install.sh.erb'),
	ensure => present,
	owner => 'root', group => 'root', mode => '0700',
    }

    file {
        '/root/accounts/create.d/100_create_unix.sh.disabled':
	  content => '',
	  ensure => present,
	  require => File['/root/accounts/create.d'],
	  owner => 'root', group => 'root', mode => '0700',
	;
        '/root/accounts/create.d/100_create_ldap.sh':
	  content => template('ldap/accounts-create_ldap.sh.erb'),
	  ensure => present,
	  require => File['/root/accounts/create.d'],
          owner => 'root', group => 'root', mode => '0700',
	;	
	'/root/accounts/destroy.d/100_destroy_unix.sh.disabled':
	  content => '',
	  ensure => present,
 	  require => File['/root/accounts/destroy.d'],
          owner => 'root', group => 'root', mode => '0700',
	;
        '/root/accounts/destroy.d/100_destroy_ldap.sh':
	  content => template('ldap/accounts-destroy_ldap.sh.erb'),
	  ensure => present,
 	  require => File['/root/accounts/destroy.d'],
          owner => 'root', group => 'root', mode => '0700',
	;
	'/root/accounts/setpass.d/100_setpass_unix.sh.disabled':
	  content => '',
	  ensure => present,
  	  require => File['/root/accounts/setpass.d'],
	  owner => 'root', group => 'root', mode => '0700',
	;
        '/root/accounts/setpass.d/100_setpass_ldap.sh':
	  content => template('ldap/accounts-setpass_ldap.sh.erb'),
	  ensure => present,
    	  require => File['/root/accounts/setpass.d'],
	  owner => 'root', group => 'root', mode => '0700',
	;	
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
