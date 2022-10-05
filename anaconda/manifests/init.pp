class anaconda (
  $flavor = 'Anaconda3',
    # Can be 'Anaconda3' or 'Mambaforge'
  $version = '2022.05',
  $arch = 'Linux-x86_64.sh',
  $installer = undef,
  $url = undef,
  # defaults to
  #  - https://repo.anaconda.com/archive/${installer} for Anaconda
  #  - https://github.com/conda-forge/miniforge/releases/download/${version}/${installer} for Mambaforge
  $installdir = undef,
) {

  include stddirs
  
  $pkgs = ['libgl1-mesa-glx',
          'libegl1-mesa',
          'libxrandr2',
          'libxss1',
          'libxcursor1',
          'libxcomposite1',
          'libasound2',
          'libxi6',
          'libxtst6']

  manage::packages::present($pkgs)

  case $flavor {
    'Anaconda3': {
      $use_installer = $installer ? {
        undef => "Anaconda3-${version}-${arch}",
        default => $installer,
      }
      $use_url = $url ? {
        undef => "https://repo.anaconda.com/archive/${use_installer}",
        default => $url,
      }
      $use_installdir = $installdir ? {
        undef => "/opt/anaconda",
        default => $installdir,
      }
      $saneconda_init="
export ANACONDA_PATH=\"${use_installdir}/${version}\"
function conda() {
  source \"${use_installdir}/conda.source\" \"\$@\"
}
"
    }

    'Miniconda3': {
      $use_installer = $installer ? {
        undef => "Miniconda3-${version}-${arch}",
        default => $installer,
      }
      $use_url = $url ? {
        undef => "https://repo.anaconda.com/miniconda/${use_installer}",
        default => $url,
      }
      $use_installdir = $installdir ? {
        undef => "/opt/miniconda",
        default => $installdir,
      }
      $saneconda_init="
export ANACONDA_PATH=\"${use_installdir}/${version}\"
function conda() {
  source \"${use_installdir}/conda.source\" \"\$@\"
}
"
    }

    'Mambaforge': {
      $use_installer = $installer ? {
        undef => "Mambaforge-${version}-${arch}",
        default => $installer,
      }
      $use_url = $url ? {
        undef => "https://github.com/conda-forge/miniforge/releases/download/${version}/${use_installer}",
        default => $url,
      }
      $use_installdir = $installdir ? {
        undef => "/opt/mambaforge",
        default => $installdir,
      }
      $saneconda_init="
export MAMBAFORGE_PATH=\"${use_installdir}/${version}\"
function mamba() {
  source \"${use_installdir}/conda.source\" \"\$@\"
}
function conda() {
  source \"${use_installdir}/conda.source\" \"\$@\"
}
"
    }
    
    default: {
      fail("Unsupported flavor: ${flavor}")
    }
  }

  $checksum = $use_url ? {
    "https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh" => 'a7c0afe862f6ea19a596801fc138bde0463abcbce1b753e8d5c474b506a2db2d',
    default => undef,
  }

  if ! find_file("/root/puppet/installers/${use_installer}") {
    file { "/root/puppet/installers/${use_installer}":
      ensure => 'file',
      source => "$use_url",
      checksum => $checksum ? {undef => undef, default => 'sha256'},
      checksum_value => $checksum,
      replace => 'no',
      require => File["/root/puppet/installers"],
      mode => '744',
    }
  } else {  
    file { "/root/puppet/installers/${use_installer}":
      ensure => 'file',
      replace => 'no',
      require => File["/root/puppet/installers"],
      mode => '744',
    }
  }

  file { "$use_installdir":
    ensure => 'directory',
    owner => 'root',
    mode => '0744',
  }
  
  exec { "install conda ${use_installer}":
    command => "/root/puppet/installers/${use_installer} -b -p ${use_installdir}/${version}",
    creates => "${use_installdir}/${version}",
    require => [ File["/root/puppet/installers/${use_installer}"], File["${use_installdir}"] ],
  }

  file { "${use_installdir}/conda.source":
    ensure => 'file',
    source => "https://raw.githubusercontent.com/httk/saneconda/main/conda.source",
    checksum => 'sha256',
    checksum_value => '3607ae84a8abffabaa68444908e90a0381a6da55da8d6e7222b6e747e9a0f84a',
    require => Exec["install conda ${use_installer}"],
    mode => '644',
  }

  file { "/etc/profile.d/saneconda.sh":
    ensure => 'file',
    content => $saneconda_init,
    mode => '644',
    require => File["${use_installdir}/conda.source"],    
  }
}
