class motd(
  $motd_message,
){

    package { 'update-motd':
        ensure => present,
    } ->	
    file {
        '/etc/update-motd.d/50-puppet-motd.erb':
         content => template('motd/etc-update-motd.d-50-puppet-motd.erb'),
         ensure => present,
         owner => 'root', group => 'root', mode => '0755',
    } ~>
    exec { 'update-motd':
        command   => 'update-motd',
    }
}
