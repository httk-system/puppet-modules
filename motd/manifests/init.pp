class motd(
  $message,
){
      # Since Ubuntu jammy update-motd is no longer needed, the motd is dynamically generated during login time by pam,
      # and having update-motd installed may result in double motd being printed.

      package { 'update-motd':
        ensure => 'absent',
      }

      file {
        '/etc/update-motd.d/50-puppet-motd':
          content => template('motd/etc-update-motd.d-50-puppet-motd.erb'),
          ensure => present,
          owner => 'root', group => 'root', mode => '0755',
      }

}
