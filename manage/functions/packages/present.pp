function manage::packages::present(
  $packages = [],
) {

  $packages.each |$pkg| {
      if ! defined(Package["package-present-$pkg"]) {
	  create_resources('package', {"package-present-$pkg" => {}}, {name => "$pkg", ensure => 'present'})
      }
  }
}
