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

      case $::lsbdistcodename {
        'focal': {
          class { 'apache::mod::php':
            php_version => '7.4'
          }
        }
        'jammy': {
          class { 'apache::mod::php':
            php_version => '8.1'
          }
        }
        default: {
            fail("Unsupported major of ${facts}['operatingsystem']")
        }
      }


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
