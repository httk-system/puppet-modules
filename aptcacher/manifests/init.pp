class aptcacher {

    include public_init

    package { 'apt-cacher-ng':
    	ensure => 'present',
    }
    #->
    #file {
    #  '/etc/'
    #}
    ~>
    service {
        'apt-cacher-ng':
          enable => true,
          ensure => running,
    }
}
