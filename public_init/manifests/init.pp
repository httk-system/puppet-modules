class public_init() {

    ensure_resource('file','/root/control',{ensure => 'directory',owner => 'root',mode => '0700'})
    ensure_resource('file','/root/secrets',{ensure => 'directory',owner => 'root',mode => '0700'})
    ensure_resource('file','/root/flags',{ensure => 'directory',owner => 'root',mode => '0700'})
    ensure_resource('file','/root/collectors',{ensure => 'directory',owner => 'root',mode => '0700'})
    ensure_resource('file','/root/bin',{ensure => 'directory',owner => 'root',mode => '0700'})
    ensure_resource('file','/root/puppet',{ensure => 'directory',owner => 'root',mode => '0700'})

    file {
        '/root/control/puppet-update-public-modules':
            owner => root, group => root, mode => '0755',
            ensure  => present,
	    require => File['/root/control'],
            content => template('public_init/root-control-puppet-update-public-modules.erb'),
            ;
        '/root/puppet/public-puppet-modules':
            ensure  => 'link',
	    require => File['/root/puppet'],
	    target => '/etc/puppet/code/local-modules/public',
            ;
    }
}
