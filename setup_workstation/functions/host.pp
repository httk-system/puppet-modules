function setup_workstation::host(
  $config,
) {

  $package_list = [
      'git',
      'puppet',
      'less',
      'nano',
      'gpg',
      'scdaemon',

      'bind9-dnsutils',
      'vim',
      'bzip2',
      'unison',
      'rsync',
      'screen',  
      'emacs',
      'python3',

      'ubuntu-gnome-desktop',
      'thunderbird',
      'cheese',
      'gnome-tweaks',
      'gnome-shell-extension-manager',
      'ttf-mscorefonts-installer',
      'sshfs',
      'elpa-puppet-mode',
  ]

  manage::packages::present($package_list)

  class { 'anaconda':
    flavor => "Mambaforge",
    version => "4.14.0-0"
  }

  # Dependencies
  []
}
