class public_init() {

    ensure_resource('file','/usr/control',{ensure => 'directory',owner => 'root',mode => '0744'})
    ensure_resource('file','/root/control',{ensure => 'link', target => '/usr/control'})
    ensure_resource('file','/root/secrets',{ensure => 'directory',owner => 'root',mode => '0700'})
    ensure_resource('file','/root/flags',{ensure => 'directory',owner => 'root',mode => '0700'})
    ensure_resource('file','/root/collectors',{ensure => 'directory',owner => 'root',mode => '0700'})
    ensure_resource('file','/root/bin',{ensure => 'directory',owner => 'root',mode => '0700'})
    ensure_resource('file','/root/puppet',{ensure => 'directory',owner => 'root',mode => '0700'})
    ensure_resource('file','/root/puppet/installers',{ensure => 'directory',owner => 'root',mode => '0700', require=>File['/root/puppet']})
}
