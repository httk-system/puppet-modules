class bridge (
  $main_net_if,
  $bridge_net_if,
) {
    include public_init

    file { '/etc/netplan/02-bridge.yaml':
	content => template('bridge/etc-netplan-bridge.yaml.erb'),
	ensure => present,
	owner => 'root', group => 'root', mode => '0700',
    }
    ~>
    exec {
	'/usr/sbin/netplan apply'
    }

}
