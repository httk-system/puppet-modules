class webserver {

      class { 'apache':
      	    default_vhost => false,
	    mpm_module => false,
      }

      class { 'apache::mod::prefork':
      	    startservers => '5',
      }

      class { 'apache::mod::ssl':
         ssl_compression => false,
      }
      class { 'apache::mod::php': }      

    firewall { '110 http 80':
        dport   => '80',
        proto  => 'tcp',
        action => 'accept',
    }

    firewall { '110 http 443':
        dport   => '443',
        proto  => 'tcp',
        action => 'accept',
    }

    package { 'php-sqlite3':
    	ensure => 'latest',
	notify => Class['Apache::Service']
    }

}
