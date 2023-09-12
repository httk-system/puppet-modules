class helpful_user_defaults(
) {

  # Convoluted way to find puppet-executing user's home directory
  $home = generate("/usr/bin/bash","-c",'echo -n ~')

  # Overengineered emacs config

  file { "${home}/.emacs":
          ensure  => present,
          mode    => '0664',
          source => "puppet:///modules/helpful_user_defaults/dot-emacs",
  }

  file { "${home}/.emacs.d":
    ensure => 'directory',
    mode    => '0775',
  }
  ->
  file { "${home}/.emacs.d/init.d":
    ensure => 'directory',
    mode    => '0775',
  }

  file { "${home}/.emacs.d/init.d/unfill.el":
    ensure  => present,
    mode    => '0664',
    source => "puppet:///modules/helpful_user_defaults/dot-emacs-unfill",
    require => File["${home}/.emacs.d/init.d"],
  }

  file { "${home}/.emacs.d/init.d/sane-whitespace.el":
    ensure  => present,
    mode    => '0664',
    source => "puppet:///modules/helpful_user_defaults/dot-emacs-sane-whitespace",
    require => File["${home}/.emacs.d/init.d"],
  }

  file { "${home}/.emacs.d/init.d/indent.el":
    ensure  => present,
    mode    => '0664',
    source => "puppet:///modules/helpful_user_defaults/dot-emacs-indent",
    require => File["${home}/.emacs.d/init.d"],
  }

  notice("Consider turning off idle brightness change using this command: gsettings set org.gnome.settings-daemon.plugins.power idle-brightness 100")

  file { "${home}/.bashrc.d":
    ensure => 'directory',
    mode    => '0775',
  }

  file_line { "${home}/.bashrc handle .bashrc.d":
    ensure => "present",
    path => "${home}/.bashrc",
    line => "for file in \"$(find ~/.bashrc.d -maxdepth 1 -name '*.sh' -print -quit)\"; do source \${file}; done",
  }

  file { "${home}/.bashrc.d/history-search.sh":
    ensure => 'present',
    mode    => '0664',
    content => "
bind '\"\\e[A\": history-search-backward'
bind '\"\\e[B\": history-search-forward'
",
    require => File["${home}/.bashrc.d"]
  }

  file { "${home}/.bashrc.d/quoting-literal.sh":
    ensure => 'present',
    mode    => '0664',
    content => "
export QUOTING_STYLE=literal
",
    require => File["${home}/.bashrc.d"]
  }

}
