class certbot_apache {

    package {
	'certbot':
            ensure => installed,
	    ;
	'python3-certbot-apache':
            ensure => installed,
	    ;
    }
}
