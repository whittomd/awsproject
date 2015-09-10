# Default path
Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

file { "/root/.ssh/id_rsa":
   source => "/vagrant/resources/vagrant.key"
}
include bootstrap

include apache
include php
include phpmyadmin
include xdebug
import "includes/*.pp"