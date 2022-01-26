class certbot_apache {

    include public_init

    package {
	'certbot':
            ensure => installed,
	    ;
	'python3-certbot-apache':
            ensure => installed,
	    ;
    }
}
