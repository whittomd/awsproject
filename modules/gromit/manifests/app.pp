class gromit::app (
   $site_name = false,
   $repository = '',
) inherits gromit {
   vcsrepo { "${gromit::install_dir}/sites/${gromit::app::site_name}":
      require => [vcsrepo["${gromit::install_dir}/gromit"], File["${gromit::install_dir}/sites"],
      ensure   => present,
      provider => git,
      remote   => 'origin',
      revision => 'dev',
      source   => {
        'origin'       => $repository,
      },
    }

    file { "/var/cache/${gromit::app::site_name}":
        require => vcsrepo["${gromit::install_dir}/gromit"],
        ensure => "directory",
        owner  => "www-data",
        group  => "www-data",
        mode   => 750,
    }

    file { "/var/cache/${gromit::app::site_name}/annotations":
        require => vcsrepo["${gromit::install_dir}/gromit"],
        ensure => "directory",
        owner  => "www-data",
        group  => "www-data",
        mode   => 750,
    }

    file { "/var/cache/${gromit::app::site_name}/data":
        require => vcsrepo["${gromit::install_dir}/gromit"],
        ensure => "directory",
        owner  => "www-data",
        group  => "www-data",
        mode   => 750,
    }

    file { "/var/cache/${gromit::app::site_name}/languages":
        require => vcsrepo["${gromit::install_dir}/gromit"],
        ensure => "directory",
        owner  => "www-data",
        group  => "www-data",
        mode   => 750,
    }

    file { "/var/cache/${gromit::app::site_name}/metadata":
        require => vcsrepo["${gromit::install_dir}/gromit"],
        ensure => "directory",
        owner  => "www-data",
        group  => "www-data",
        mode   => 750,
    }

    file { "/var/cache/${gromit::app::site_name}/view":
        require => vcsrepo["${gromit::install_dir}/gromit"],
        ensure => "directory",
        owner  => "www-data",
        group  => "www-data",
        mode   => 750,
    }
}