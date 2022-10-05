function manage::packages::absent(
  $packages = [],
) {

  $packages.each |$pkg| {
      if ! defined("package-absent-$pkg") {
	  create_resources('package', {"package-absent-$pkg" => {}}, {name => "$pkg", ensure => 'absent'})
      }
  }
}
