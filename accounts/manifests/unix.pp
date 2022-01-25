class accounts::unix() {

    file {
        '/root/accounts/destroy.d/100_destroy_unix.sh':
            owner => root, group => root, mode => '0700',
            ensure  => present,
            source => 'puppet:///modules/accounts/destroy_unix.sh',
	    require => File['/root/accounts/destroy.d'],
            ;	    	    
        '/root/accounts/setpass.d/100_setpass_unix.sh':
            owner => root, group => root, mode => '0700',
            ensure  => present,
            source => 'puppet:///modules/accounts/setpass_unix.sh',
	    require => File['/root/accounts/setpass.d'],
            ;	    
        '/root/accounts/create.d/100_create_unix.sh':
            owner => root, group => root, mode => '0700',
            ensure  => present,
            source => 'puppet:///modules/accounts/create_unix.sh',
	    require => File['/root/accounts/create.d'],
            ;	    
    }

}
