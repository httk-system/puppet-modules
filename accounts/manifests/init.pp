class accounts() {

    include provide_managed

    file {
        '/root/managed/accounts':
	    ensure => 'directory',owner => 'root',mode => '0700',
    }
    ->
    file {
        '/root/managed/accounts/create.d':
	    ensure => 'directory',owner => 'root',mode => '0700',
	    ;
	'/root/managed/accounts/destroy.d':
	    ensure => 'directory',owner => 'root',mode => '0700',
	    ;
	'/root/managed/accounts/setpass.d':
	    ensure => 'directory',owner => 'root',mode => '0700',
	    ;
    }
    ->
    file {
        '/root/managed/accounts/create.sh':
            owner => root, group => root, mode => '0700',
            ensure  => present,
            source => 'puppet:///modules/accounts/create.sh',
            ;
        '/root/managed/accounts/destroy.sh':	    
            owner => root, group => root, mode => '0700',
            ensure  => present,
            source => 'puppet:///modules/accounts/destroy.sh',
            ;	    
        '/root/managed/accounts/setpass.sh':
            owner => root, group => root, mode => '0700',
            ensure  => present,
            source => 'puppet:///modules/accounts/setpass.sh',
            ;
    }

}
