class anaconda (
  $version = "2022.05"
) {

  ensure_resource('package','libgl1-mesa-glx')
  ensure_resource('package','libegl1-mesa')
  ensure_resource('package','libxrandr2')
  ensure_resource('package','libxrandr2')
  ensure_resource('package','libxss1')  
  ensure_resource('package','libxcursor1')
  ensure_resource('package','libxcomposite1')
  ensure_resource('package','libasound2')
  ensure_resource('package','libxi6')    
  ensure_resource('package','libxtst6')    

  $installer = "Anaconda3-${version}-Linux-x86_64.sh"
    
  $url = "https://repo.anaconda.com/archive/${installer}"

  file { "/root/puppet/installers/${installer}":
    ensure => 'file',
    source => $url,
    checksum => 'sha256',
    checksum_value => 'a7c0afe862f6ea19a596801fc138bde0463abcbce1b753e8d5c474b506a2db2d',
    require => File["/root/puppet/installers"],
    mode => '744',
  }

  ensure_resource('file','/opt/anaconda',{ensure => 'directory',owner => 'root',mode => '0744'})
  
  exec { "install anaconda ${version}":
    command => "/root/puppet/installers/${installer} -b -p /opt/anaconda/${version}",
    creates => "/opt/anaconda/${version}",
    require => [ File["/root/puppet/installers/${installer}"], File["/opt/anaconda"] ],
  }

  file { "/opt/anaconda/conda.source":
    ensure => 'file',
    source => "https://raw.githubusercontent.com/httk/saneconda/main/conda.source",
    checksum => 'sha256',
    checksum_value => '3607ae84a8abffabaa68444908e90a0381a6da55da8d6e7222b6e747e9a0f84a',
    require => Exec["install anaconda ${version}"],
    mode => '644',
  }

  file { "/etc/profile.d/saneconda.sh":
    ensure => 'file',
    content => "export ANACONDA_PATH=/opt/anaconda/${version}\nalias conda=\"source /opt/anaconda/conda.source\"\n",
    mode => '644',
    require => File["/opt/anaconda/conda.source"],    
  }
  
}
