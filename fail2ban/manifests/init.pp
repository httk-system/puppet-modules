class fail2ban (
) {
  include public_init

  class { 'fail2ban':
      package_ensure => 'latest',
      email => 'root@localhost',
      action => 'action_'
   }

   file {
      '/root/control/fail2ban-unban':
       content => template('fail2ban/root-control-fail2ban-unban.erb'),
       ensure => present,
       owner => 'root', group => 'root', mode => '0700',
   }

}
