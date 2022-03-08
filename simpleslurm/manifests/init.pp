class simpleslurm (
) {
    include public_init

    $nodename=$facts['hostname']

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
        content => template( 'simpleslurm/etc-slurm-llnl-slurm.conf.erb'),
	notify => [ Service['slurmctld'], Service['slurmd'] ],
    }

    service { ['slurmctld']:
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
	
    }

    service { ['slurmd']:
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
    }
    
}



