class slurm (
  $is_controller=false,
  $is_node=false,
) {
    include public_init

    package { [
      'slurm-wlm',
    ]:
      ensure => 'present'
    }
    ->
    file { '/etc/slurm-llnl/slurm.conf':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0664',
        content => template( 'slurm/etc-slurm-llnl-slurm.conf'),
	notify => [ Service['slurmctld'], Service['slurmd'] ],
    }

    if $is_controller {
      service { ['slurmctld']:
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
	
      }
    }

    if $is_node {
      service { ['slurmd']:
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
      }
    }
    
}



