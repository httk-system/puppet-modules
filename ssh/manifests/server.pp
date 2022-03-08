class ssh::server(
  $port = 22,
  $password_auth = false,
  $fail2ban = true,
){

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

    firewall { '04 ssh':
        dport   => "$port",
        proto  => 'tcp',
	ctstate => ['NEW','ESTABLISHED','RELATED'],
        action => 'accept',
    }

    if $failtoban {

      class { 'fail2ban':
        package_ensure => 'latest',
        email => 'root@localhost',
        action => 'action_'
      }

      file {
        '/root/control/fail2ban-unban':
         content => template('ssh/root-control-fail2ban-unban.erb'),
         ensure => present,
         owner => 'root', group => 'root', mode => '0700',
      }
   }
}
