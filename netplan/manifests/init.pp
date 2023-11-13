class netplan (
  $ifs,
  $ipforward,
) {
    # We no longer manage the basic interface config in puppet, networking is required to be up for puppet to work
    #
    #file { '/etc/netplan/20-interfaces.yaml':
    #	content => template('netplan/etc-netplan-20-interfaces.yaml.erb'),
    #	ensure => present,
    #	owner => 'root', group => 'root', mode => '0700',
    #}
    #~>
    #exec { 'netplan apply':
    #  command => '/usr/sbin/netplan apply',
    #}
    #notice("You may need to run netplan apply. Disabled due to problems re-running netplan apply with renderer: networkd.")

  if $ipforward {
    $ipforward_setting='1'
  } else {
    $ipforward_setting='0'
  }

  file { "/etc/sysctl.d/20-ip-forward.conf":
	content => "net.ipv4.ip_forward=$ipforward_setting\n",
	ensure => present,
	owner => 'root', group => 'root', mode => '0700',
  }

  exec {'netplan ipforward reread sysctl':
    command => "/usr/sbin/sysctl --system",
    subscribe => File["/etc/sysctl.d/20-ip-forward.conf"],
    refreshonly => true,
    notify => Exec["notify netplan change"],
  }

  exec { "notify netplan change":
    command => "/usr/bin/echo 'Changing netplan settings may sometimes cause issues with dns resolution; a temporary solution can be to force a dns server with: resolvectl dns <interface> <dns ip>.'",
    refreshonly => true,
  }


  #ini_setting { "sysconf ip_forward":
  #  ensure  => present,
  #  path    => '/etc/sysctl.conf',
  #  setting => 'net.ipv4.ip_forward',
  #  value => $ipforward_setting
  #}

}
