define dhcpd::config(
   $dnsdomains = [],
   $nameservers = [],
   $ntpservers = [],
   $interfaces = [],
   $pxeserver = undef,
   $pxefilename = undef,
) {

  ensure_resource('dhcpd::final','dhcpd_final')

  collect::store("dhcpd", $name, {
    "dnsdomains" => $dnsdomains,
    "nameservers" => $nameservers,
    "ntpservers" => $ntpservers,
    "interfaces" => $interfaces,
    "pxeserver" => $pxeserver,
    "pxefilename" => $pxefilename,
  }, Dhcpd::Final['dhcpd_final'])

  #ensure_resource('file','/root/collectors/dhcpd',{ensure => 'directory',owner => 'root',mode => '0700'})
  #ensure_resource('dhcpd::final','dhcpd_final')

  #file { "/root/collectors/dhcpd/dnsdomains.$name":
  #  ensure  => 'present',
  #  mode    => '0755',
  #  content => join($dnsdomains,'|'),
  #  before  => Dhcpd::Final['dhcpd_final'],
  #}

  #file { "/root/collectors/dhcpd/nameservers.$name":
  #  ensure  => 'present',
  #  mode    => '0755',
  #  content => join($dnsdomains,'|'),
  #  before  => Dhcpd::Final['dhcpd_final'],
  #}

  #file { "/root/collectors/dhcpd/ntpservers.$name":
  #  ensure  => 'present',
  #  mode    => '0755',
  #  content => join($dnsdomains,'|'),
  #  before  => Dhcpd::Final['dhcpd_final'],
  #}

  #file { "/root/collectors/dhcpd/interfaces.$name":
  #  ensure  => 'present',
  #  mode    => '0755',
  #  content => join($dnsdomains,'|'),
  #  before  => Dhcpd::Final['dhcpd_final'],
  #}

  #file { "/root/collectors/dhcpd/pxeserver.$name":
  #  ensure  => 'present',
  #  mode    => '0755',
  #  content => join($dnsdomains,'|'),
  #  before  => Dhcpd::Final['dhcpd_final'],
  #}

  #file { "/root/collectors/dhcpd/pxefilename.$name":
  #  ensure  => 'present',
  #  mode    => '0755',
  #  content => join($dnsdomains,'|'),
  #  before  => Dhcpd::Final['dhcpd_final'],
  #}
}


#   @dhcpd::dummy { $name:
#     dnsdomains => $dnsdomains,
#     before => Class['dhcpd'],
#   }
