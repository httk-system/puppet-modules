class ssh::server(
  $port = 22,
  $password_auth = false,
  $fail2ban = true,
  $fail2ban_exclude = [],
){

    include provide_control

    package { 'ssh':
        ensure => present,
    } ->
    file { '/etc/ssh/sshd_config':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
        content => template( 'ssh/sshd_config.erb'),
    } ~>
    service { 'ssh':
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
    }

    firewall { '104 ssh':
        dport   => "$port",
        proto  => 'tcp',
	ctstate => ['NEW','ESTABLISHED','RELATED'],
        jump => 'accept',
    }

    if $fail2ban {

      case $facts['os']['distro']['codename'] {
        'nobel': {
          class { 'fail2ban':
            package_ensure => 'latest',
            email => 'root@localhost',
            action => 'action_',
	    config_file_template => "fail2ban/Ubuntu/24.04/etc/fail2ban/jail.conf.epp",
	    whitelist => $fail2ban_exclude,
          }	 
	}
        'jammy': {
          class { 'fail2ban':
            package_ensure => 'latest',
            email => 'root@localhost',
            action => 'action_',
	    config_file_template => "fail2ban/Ubuntu/22.04/etc/fail2ban/jail.conf.epp",
	    whitelist => $fail2ban_exclude,
          }	 
	}
        default: {
          class { 'fail2ban':
            package_ensure => 'latest',
            email => 'root@localhost',
            action => 'action_',
	    whitelist => $fail2ban_exclude,
          }
        }

      file {
        '/usr/control/fail2ban-unban':
         content => template('ssh/fail2ban-unban.erb'),
         ensure => present,
         owner => 'root', group => 'root', mode => '0700',
      }
   }
}
