class resolved(
   $ip,
){

    file { '/etc/systemd/resolved.conf':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template( 'resolved/etc-systemd-resolved.conf.erb'),
    } ~>
    service { 'systemd-resolved':
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
    }

    firewall { '105 resolved':
        dport   => "53",
        proto  => ['udp','tcp'],
	ctstate => ['NEW','ESTABLISHED','RELATED'],
        action => 'accept',
    }

}
