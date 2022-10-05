function manage::services::stopped(
  $services = [],
) {

  $services.each |$srv| {
      if ! defined("service-stopped-$srv") {
	  create_resources('service', {"service-stopped-$srv" => {}}, {name => "$srv", ensure => 'stopped'})
      }
  }
}
