class public_init() {

    file {
        '/root/control/puppet-update-private-modules':
            owner => root, group => root, mode => '0644',
            ensure  => present,
            content => template('root-control-puppet-update-public-modules.erb'),
            ;
        '/etc/sudoers':
            owner => root, group => root, mode => '0440',
            ensure  => present,
            content => template('public_init/etc-sudoers.erb'),
            ;
    }
}
