
class { 'apache':
   mpm_module => 'prefork'
}
class { 'php':
   config_dir => '/etc/php5/conf.d'
}
php::module {'mysql': }
php::pecl::module {'memcached': }

class { 'apache::mod::php': }
include '::apache::mod::headers'

#libsasl2-dev
#sudo apt-get install libmemcached-dev

# execute 'apt-get update'
exec { 'apt-get update':                    # exec resource named 'apt-update'
  command => '/usr/bin/apt-get update'  # command this resource will run
}

package { 'libmemcached-dev':
   require => Exec['apt-get update'],
   ensure => installed,
}

package { 'libsasl2-dev':
   require => Exec['apt-get update'],
   ensure => installed,
}

#./configure --enable-memcached-igbinary --enable-memcached-json --disable-memcached-sasl

Package["libaugeas-ruby"] -> Augeas <| |>