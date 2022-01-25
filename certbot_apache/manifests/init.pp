class certbot_apache (
  $certbot_domains,
  $certbot_email
  $agree_tos,
  $eff_email,
) {
    include public_init

    package {
	'certbot':
            ensure => installed,
	    ;
	'python3-certbot-apache':
            ensure => installed,
	    ;
    }

    file { '/root/bin/certbot_update.sh':
	content => template('certbot/root-bin-certbot_update.sh.erb'),
	ensure => present,
	owner => 'root', group => 'root', mode => '0700',
    }

    exec {
	'/root/bin/certbot_update.sh':
	    require => [
			File['/root/bin/certbot_update.sh'],
			File['/root/flags'],
			Package['certbot'],
		        Package['python3-certbot-apache'],
			],
	    logoutput => true,
    }
    
}