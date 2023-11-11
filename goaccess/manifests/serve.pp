define goaccess::serve(
  $serverid,
  $host,
  $ws_url,
  $logfile,
  $outdir,
  $port,
  $dbpath,
) {

  include goaccess

  file { "/lib/systemd/system/goaccess-${serverid}.service":
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template("goaccess/lib-systemd-system-goaccess.service.erb"),
  }~>
  exec { "${serverid}-systemd-reload":
    command     => 'systemctl daemon-reload',
    path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
    refreshonly => true,
  }~>
  service { "goaccess-${serverid}":
    ensure => 'running',
    enable => true,
  }
}
