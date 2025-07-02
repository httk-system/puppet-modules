class provide_control() {

  include stddirs

  ensure_resource('package','pdsh', {'ensure' => 'present'})

  file { '/etc/bash.bashrc.d':
    ensure => 'directory',
    owner => 'root',
    mode => '0744',
  }

  file_line { "/etc/bash.bashrc handle bash.bashrc.d":
    ensure => "present",
    path => "/etc/bash.bashrc",
    line => "for file in \"$(find /etc/bash.bashrc.d/ -maxdepth 1 -name '*.sh' -print -quit)\"; do source \"\${file}\"; done",
  }

  class { 'gssh':
    path => '/usr/control/gssh',
    require => File['/usr/control'],
  }

  # Without this, the default /etc/bash.bashrc prints out "-bash: : No such file or directory" on every login if /etc/bash.bashrc.d is empty
  file { '/etc/bash.bashrc.d/puppet_dummy.sh':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { '/etc/profile.d/puppet-setups-control.sh':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/provide_control/etc-profile.d-puppet-setups-control.sh',
    require => File['/usr/control'],
  }

  file { '/etc/profile.d/puppet-bashrc.sh':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/provide_control/etc-profile.d-puppet-bashrc.sh',
  }

  file { '/etc/sudoers.d/control_set_default_path':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    content => "Defaults secure_path = \"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/usr/control\"\n"
  }
}
