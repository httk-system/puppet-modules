class webserver(
  $php_version = undef
  ){

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

      class { 'apache::mod::rewrite':
      }

      if ! $php_version {
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
      } else {

        class { 'apache::mod::php':
          php_version => "$php_version"
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

    apache::vhost { "default_catch:80":
      priority   => '01',
      vhost_name => '_default_',
      port       => '80',
      options    => ['None'],
      override   => ['None'],
      docroot => "/var/www/html",
      docroot_owner => 'www-data',
      docroot_group => 'www-data',
      directories    => [{
        'path'               => '/',
        'require'               => 'all denied',
      }],
      custom_fragment => 'ErrorDocument 403 Forbidden.',
      use_servername_for_filenames => true,
      use_port_for_filenames => true,
    }

    apache::vhost { "default_catch:443":
      priority   => '01',
      vhost_name => '_default_',
      port       => '443',
      options    => ['None'],
      override   => ['None'],
      docroot => "/var/www/html",
      docroot_owner => 'www-data',
      docroot_group => 'www-data',
      ssl => true,
      directories    => [{
        'path'               => '/',
        'require'               => 'all denied',
      }],
      custom_fragment => 'ErrorDocument 403 Forbidden.',
      use_servername_for_filenames => true,
      use_port_for_filenames => true,
    }

}
