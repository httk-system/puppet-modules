define netplan::bridge (
  $bridge_ifs,
) {
    include public_init

    file { "/etc/netplan/30-bridge-$name.yaml":
	content => template('netplan/etc-netplan-30-bridge.yaml.erb'),
	ensure => present,
	owner => 'root', group => 'root', mode => '0700',
    }
    ~>
    exec { 'netplan bridge apply':
      command => '/usr/sbin/netplan apply',
    }

}
