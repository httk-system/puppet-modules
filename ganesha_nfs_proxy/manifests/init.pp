class ganesha_nfs_proxy(
   $remote_server_ip,
   $remote_path,
   $export_path,
   $bind_ip,
){

    package {
        'nfs-ganesha-proxy':
          ensure => present,
        ;
        'nfs-ganesha':
          ensure => present,
        ;
    } ->
    file { '/etc/ganesha/ganesha.conf':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template( 'ganesha_nfs_proxy/etc-ganesha-ganesha.conf.erb'),
        notify  => Service['nfs-ganesha'],
    }

    if find_file('/usr/lib/x86_64-linux-gnu/ganesha/libfsalproxy.so') and !find_file('/usr/lib/x86_64-linux-gnu/ganesha/libfsalproxy_v4.so') {
      file { '/usr/lib/x86_64-linux-gnu/ganesha/libfsalproxy_v4.so':
        ensure  => 'link',
        target   => '/usr/lib/x86_64-linux-gnu/ganesha/libfsalproxy.so',
        before  => Service['nfs-ganesha'],
        after   => Package['nfs-ganesha-proxy'],
     }
    }

    service { 'nfs-ganesha':
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
    }

    firewall { '04 ganesha_udp':
        dport   => [111, 2049, 4002],
        proto  => 'udp',
	ctstate => ['NEW','ESTABLISHED','RELATED'],
        action => 'accept',
    }

    firewall { '04 ganesha_tcp':
        dport   => [111, 2049, 4002],
        proto  => 'tcp',
	ctstate => ['NEW','ESTABLISHED','RELATED'],
        action => 'accept',
    }
}
