class intel (
  $fabric="shm"
) {
    include public_init

    include apt

    apt::key {'intel-graphics':
    	     source => 'https://repositories.intel.com/graphics/intel-graphics.key',
    	     id => '1C1B89D02C929514698AA8059B10C065DBB72B06'
    }
    ->
    apt::source { "intel-graphics":
      location => 'https://repositories.intel.com/graphics/ubuntu',
      release  => $::lsbdistcodename,
      repos    => 'main',
      notify   => [
        Class['apt::update'],
      ]
    }
    ->
    package { [
      'intel-opencl-icd',
      'intel-level-zero-gpu',
      'level-zero',
      'intel-media-va-driver-non-free',
      'libmfx1',
      'libigc-dev',
      'intel-igc-cm',
      'libigdfcl-dev',
      'libigfxcmrt-dev',
      'level-zero-dev',
    ]:
      ensure => 'present'
    }
    ->
    apt::key { 'intel1':
      source => 'https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB',
      id => '52ABD6E87E421793971873FFACFA9FC57E6C5DBE'
    }
    ->
    apt::key { 'intel2':
      source => 'https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB',
      id => '6113D31362A0D280FC025AAB640736427872A220'
    }
    ->
    apt::key { 'intel3':
      source => 'https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB',
      id => 'BF4385F91CA5FC005AB39E1C1A8497B11911E097'
    }
    ->
    apt::key { 'intel4':
      source => 'https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB',
      id => 'E1BA4ECEFB0656C61BF9794936B9569B3F1A1BC7'
    }
    ->
    apt::source { "intel":
      location => 'https://apt.repos.intel.com/oneapi',
      release  => 'all',
      repos    => 'main',
      notify   => [
        Class['apt::update'],
      ]
    }
    ->
    package { [
      'intel-basekit',
      'intel-hpckit',
    ]:
      ensure => 'present'
    }

    file { '/etc/profile.d/intel.sh':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0664',
        content => template( 'intel/etc-profile.d-intel.sh.erb'),
    }

}



