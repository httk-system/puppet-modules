class aptcacher {

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
