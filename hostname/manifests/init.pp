# == Class: hostname
#
# Set the hostname
#
# === Parameters
#  [*hostname*] Hostname to use
#
# === Example
#
#   class { 'hostname':
#     hostname => 'potato',
#     domain   => 'example.com'
#   }
#

class hostname (
  $hostname,
  $domain = undef
) {
  case $facts['os']['family'] {
    'darwin': { include hostname::darwin }
    'archlinux': { include hostname::systemd }
    'arch': { include hostname::systemd }
    'debian': { include hostname::systemd }
    'ubuntu': { include hostname::systemd }
    default: { fail("Hostname module does not support ${::osfamily}") }
  }
}
