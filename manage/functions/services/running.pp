function manage::services::running(
  $services = [],
) {

  $services.each |$srv| {
      if ! defined("service-running-$srv") {
	  create_resources('service', {"service-running-$srv" => {}}, {name => "$srv", ensure => 'running'})
      }
  }
}
