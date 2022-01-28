class ssh::server(
  $port = 22,
){
    package { 'ssh':
        ensure => present,
    } ->
    file { '/etc/ssh/sshd_config':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
        content => template( 'profiles/ssh/sshd_config.erb'),
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
}
