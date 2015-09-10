# Default path
Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}
include bootstrap

include apache
include php
include phpmyadmin
include xdebug
import "includes/*.pp"