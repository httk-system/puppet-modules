# MDI puppet modules

Some useful puppet modules.

To install a new workstation:

  sudo apt install puppet git
  mkdir ~/Puppet
  cd ~/Puppet
  git clone https://github.com/rartino/puppet-modules.git
  cd puppet-modules
  puppet apply manifests/install_workstation.pp --modulepath=.
  