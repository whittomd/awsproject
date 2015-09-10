# Class: phalconphp::framework
# Installs the actual phalconphp framework
class phalconphp::framework (
  $version,
  $zephir_build = false,
  $ini_file     = "phalcon.ini",
  $debug        = false,
  $tmpdir       = '/tmp/cphalcon') {
  vcsrepo { "phalcon":
    ensure   => latest,
    path     => $tmpdir,
    provider => git,
    source   => 'https://github.com/phalcon/cphalcon.git',
    revision => $version
  }

  if $version == '2.0.0' or $version == 'dev' {
    if $zephir_build == true {
      exec { 'generate':
        require   => [
          Class['phalconphp::deps::zephir'],
          Vcsrepo['phalcon'],
          ],
        command   => 'zephir generate',
        cwd       => $tmpdir,
        path      => [
          '/bin',
          '/usr/bin',
          '/sbin',
          '/usr/sbin'],
        onlyif    => "test -f ${tmpdir}/config.json",
        logoutput => $debug,
        timeout   => 0
      } ->
      exec { 'install':
        command   => 'zephir build',
        cwd       => $tmpdir,
        path      => [
          '/bin',
          '/usr/bin',
          '/sbin',
          '/usr/sbin'],
        logoutput => $debug,
        timeout   => 0
      }
    } else {
      exec { 'install':
        require   => [
          Vcsrepo['phalcon'],
          Class['phalconphp::deps::sys'],
          ],
        command   => "${tmpdir}/ext/install-test",
        cwd       => "${tmpdir}/ext",
        path      => [
          '/bin',
          '/usr/bin',
          '/sbin',
          '/usr/sbin'],
        onlyif    => "test -f ${tmpdir}/ext/install-test",
        logoutput => $debug,
        timeout   => 0
      }
    }
  } else {
    exec { 'install':
      require   => [
        Vcsrepo['phalcon'],
        Class['phalconphp::deps::sys'],
        ],
      onlyif    => "test -f ${tmpdir}/build/install",
      command   => './install',
      cwd       => "${tmpdir}/build",
      path      => [
        '/bin',
        '/usr/bin',
        '/sbin',
        '/usr/local/bin',
        '/usr/sbin'],
      logoutput => $debug,
      timeout   => 0
    }
  }

  file { "${php::config_dir}/${ini_file}":
    ensure  => file,
    require => [Class['phalconphp::deps::sys']]
  }

  php::augeas { "load-phalcon-${version}":
    entry   => 'phalconphp/extension',
    value   => 'phalcon.so',
    target  => "${php::config_dir}/${ini_file}",
    require => [
      Exec['install'],
      File["${php::config_dir}/${ini_file}"]]
  }
}
