class accounts() {

    file {
        '/root/accounts':
	    ensure => 'directory',owner => 'root',mode => '0700',
    }
    ->
    file {
        '/root/accounts/create.d':
	    ensure => 'directory',owner => 'root',mode => '0700',
	    ;
	'/root/accounts/destroy.d':
	    ensure => 'directory',owner => 'root',mode => '0700',
	    ;
	'/root/accounts/setpass.d':
	    ensure => 'directory',owner => 'root',mode => '0700',
	    ;
    }
    ->
    file {
        '/root/accounts/create.sh':
            owner => root, group => root, mode => '0700',
            ensure  => present,
            source => 'puppet:///modules/accounts/create.sh',
            ;
        '/root/accounts/destroy.sh':	    
            owner => root, group => root, mode => '0700',
            ensure  => present,
            source => 'puppet:///modules/accounts/destroy.sh',
            ;	    
        '/root/accounts/setpass.sh':
            owner => root, group => root, mode => '0700',
            ensure  => present,
            source => 'puppet:///modules/accounts/setpass.sh',
            ;
    }

}
