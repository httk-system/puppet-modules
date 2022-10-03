# A bit of an opininated rant on handling packages with Puppet
#
# Resources, in general, should really be "owned" only by a single
# puppet module. If a resource is shared between modules, then it needs
# its own abstraction - probably a class - that all models that use it
# refers to.
#
# This is however a fairly rare problem for general resources,
# think, e.g., apache virtual hosts. However, software packages are
# *all* potentially in this category, and it is impossible to know
# when writing one module if there may later be collisions with
# another one. Hence, it would have fitted better with the Puppet
# paradigm if they all had been created as classes so we could include them.
#
# This function uses the dreaded "defined" statment to enable this type
# of behavior specifically for packages. Since packages essentially only
# have a single binary parameter (ensure present or absent, you should never
# use latest) this implementation shouldn't really cause parse order issues.
#
function manage_packages::present(
  $packages = [],
  $present = true,
) {

  $packages.each |$pkg| {
      if ! defined($pkg) {
        if $present {
	  create_resources('package', {$pkg => {}}, {ensure => 'present'})
	} else {
          create_resources('package', {$pkg => {}}, {ensure => 'absent'})
	}
      } else {
        # TODO: Verify that it is created the same way
      }
  }

}
