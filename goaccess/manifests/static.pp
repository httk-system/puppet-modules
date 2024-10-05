define goaccess::static(
  $serverid,
  $host,
  $logfile,
  $outdir,
  $dbpath,
  $hour = 23,
) {

  include goaccess

  cron { "cron-goaccess-static-${serverid}":
    command => "/usr/control/goaccess-update-static '${logfile}' '${dbpath}' 'https://${host}' '${outdir}'",
    user    => 'www-data',
    hour    => $hour,
    require => File['/usr/control/goaccess-update-static'],
  }

}
