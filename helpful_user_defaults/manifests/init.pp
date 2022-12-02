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

}
