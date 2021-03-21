class public_init() {

    file {
        '/root/control/puppet-update-public-modules':
            owner => root, group => root, mode => '0644',
            ensure  => present,
            content => template('public_init/root-control-puppet-update-public-modules.erb'),
            ;
        '/etc/sudoers':
            owner => root, group => root, mode => '0440',
            ensure  => present,
            content => template('public_init/etc-sudoers.erb'),
            ;
    }
}
