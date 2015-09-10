
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


Package["libaugeas-ruby"] -> Augeas <| |>