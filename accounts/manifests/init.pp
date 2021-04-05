class accounts() {

    file {
        '/root/accounts':
	    {ensure => 'directory',owner => 'root',mode => '0700'},
    }
    ->
    file {
        '/root/accounts':
	    {ensure => 'directory',owner => 'root',mode => '0700'},
        '/root/accounts/create.d':
	    {ensure => 'directory',owner => 'root',mode => '0700'},
	'/root/accounts/destroy.d':
	    {ensure => 'directory',owner => 'root',mode => '0700'},
	'/root/accounts/setpass.d':
	    {ensure => 'directory',owner => 'root',mode => '0700'},
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
        '/root/accounts/destroy.d/100_destroy_unix.sh':
            owner => root, group => root, mode => '0700',
            ensure  => present,
            source => 'puppet:///modules/accounts/destroy_unix.sh',
            ;	    	    
        '/root/accounts/setpass.d/100_setpass_unix.sh':
            owner => root, group => root, mode => '0700',
            ensure  => present,
            source => 'puppet:///modules/accounts/setpass_unix.sh',
            ;	    
        '/root/accounts/create.d/100_create_unix.sh':
            owner => root, group => root, mode => '0700',
            ensure  => present,
            source => 'puppet:///modules/accounts/create_unix.sh',
            ;	    
    }

}
