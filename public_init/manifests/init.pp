class public_init() {

    file {
        '/root/control':
	    ensure => 'directory',
	    owner => 'root',
	    mode => '0700',
	    ;
        '/root/secrets':
	    ensure => 'directory',
	    owner => 'root',
	    mode => '0700',
	    ;
        '/root/flags':
	    ensure => 'directory',
	    owner => 'root',
	    mode => '0700',
	    ;	    
        '/root/bin':
	    ensure => 'directory',
	    owner => 'root',
	    mode => '0700',
	    ;
        '/root/puppet':
	    ensure => 'directory',
	    owner => 'root',
	    mode => '0700',
	    ;	    	    
    }
    ->
    file {
        '/root/control/puppet-update-public-modules':
            owner => root, group => root, mode => '0644',
            ensure  => present,
            content => template('public_init/root-control-puppet-update-public-modules.erb'),
            ;
        '/root/puppet/public-puppet-modules':
            ensure  => 'link',
	    target => '/etc/puppet/code/local-modules/public',
            ;	    
        '/etc/sudoers':
            owner => root, group => root, mode => '0440',
            ensure  => present,
            content => template('public_init/etc-sudoers.erb'),
            ;
    }
}
