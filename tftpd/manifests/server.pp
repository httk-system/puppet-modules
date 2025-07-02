class tftpd::server(
   $ip,
   $port = 69
){

    package { 'tftpd-hpa':
        ensure => present,
    } ->
    file { '/etc/default/tftpd-hpa':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
        content => template( 'tftpd/etc-default-tftpd-hpa.erb'),
    } ~>
    service { 'tftpd-hpa':
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
    }

    firewall { '104 tftpd':
        dport   => "69",
        proto  => 'udp',
	ctstate => ['NEW','ESTABLISHED','RELATED'],
        jump => 'accept',
    }

}
