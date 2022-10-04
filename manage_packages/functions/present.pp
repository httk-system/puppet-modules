# A bit of an opininated rant on handling resources in Puppet follows.
#
# Resources should really only be used for piecies of configuration that by nature is
# local to a sinlge module and can exist (or not) independently of what is going on
# in other modules. Think, e.g., of an Apache virtual host declaration (where all modules
# interacting with different virtual hosts would do an 'include apache').
#
# Nevertheless, specifically two standard resource types 'packages' and 'services'
# in Puppet act more according to a 'class' paradigm. It is very possible (and a common)
# that more than one module depend on the same package or relies on that the same
# service is running.
#
# Hence, we want to "convert" these resources into classes instead.
# Arguably, both 'packages' and 'services' only need to be either "present" or "absent".
# The 'ensure' arguments allow other options, but they can be argued (see below) to
# not be necessary.
#
#
#
#
#    We could require that *every* package dependency to be placed in its own mini-class,
#    and that the dependency on these packages be expressed as 'include <package-class>'.
#    This quickly gets bulky for modules with many dependencies.
#
#
#
#
#
#
# 2. For 'packages' one should only use ensure => 'present' or 'absent'.
#
#    * ensure => 'latest' should be used since Puppet is a configuration management tool
#       and really shouldn't be relied on to double-work as an 'inline' software
#       package upgrade tool.
#
#    * ensure => 'disabled' makes no sense, it is the corresponding services that should
#      be 'disabled'. For non-service-providing packages, what does it even mean for them
#      to be 'disabled'?
#
#    * ensure => 'purged': we are meant to manage configuration files with Puppet,
#      why do we try to also use the system package manager to manage the precense
#      of config files?
#
#    * ensure => 'installed': supposedly synonymous with 'present', but less used and
#      in some contexts mixing both generate issues with detecting that two
#      package declaration are equivalent.
#



should in general be "owned" only by a single puppet module.
#    A resource shared between modules, shouldn't really be tought of as
#    a resource (more as a class). It needs its own abstraction - probably a class - that all modules that use it
#    can refers to.
#
#    This is however a fairly rare problem for general resources,
#    think, e.g., apache virtual hosts. However, software packages are
#    *all* potentially in this category, and it is impossible to know
#    when writing one module if there may later be collisions with
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
