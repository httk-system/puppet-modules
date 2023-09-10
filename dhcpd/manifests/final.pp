define dhcpd::final() {

  #$content = glob("/root/collectors/dhcpd/dnsdomains.*").map |$file| {
  #  split(file($file),"\\|")
  #}.reduce([]) |$car, $cdr| {
  #  $car + $cdr
  #}

  $collected = collect::retrieve("dhcpd")

  if $collected {

    if length($collected['pxeserver']) > 1 {
      fail("dhcpd: can only have one pxeserver setting.")
    } else {
      $pxeserver = $collected['pxeserver'][0]
    }

    if length($collected['pxefilename']) > 1 {
      fail("dhcpd: can only have one pxefilename setting.")
    } else {
      $pxefilename = $collected['pxefilename'][0]
    }

    notice("dhcpd: $collected")

    #class { 'dhcp':
    #    service_ensure => running,
    #    dnsdomain    => $collected['dnsdomains'],
    #    nameservers  => $collected['nameservers'],
    #    ntpservers   => $collected['ntpservers'],
    #    interfaces   => $collected['interfaces'],
    #    pxeserver => $pxeserver,
    #    pxefilename => $pxefilename,
    #}

  }

}
