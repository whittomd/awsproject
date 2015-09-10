class gromit (
   $install_dir = '/usr/local/html',
   $version = 'dev',
) {
   file{ $gromit::install_dir:
      ensure => 'directory',
      user => 'www-data',
      group => 'www-data',
      mode   => 750,
   }
   vcsrepo { $gromit::install_dir: 
      ensure   => present,
      provider => git,
      remote   => 'origin',
      revision => $gromit::version,
      source   => {
        'origin'       => 'git@bitbucket.org:twengg/gromit.git',
      },
   }

   apache::vhost { "gromit":
   port => '80',
   priority => '1',
   serveradmin => 'webmaster@localhost',
   docroot => $install_dir,
   ssl     => false,
   rewrites => [
      {
        rewrite_cond => ['%{REQUEST_METHOD} ^(TRACE|TRACK)'],
        rewrite_rule => ['.* - [F]']
      },
      {
        rewrite_cond => ['%{REQUEST_FILENAME} !^/sites/([^.]+)'],
        rewrite_rule => ['^(.*) /sites/%{HTTP_HOST}$1 [NS,L]']
      }
   ],
   directories => [
      {
         path => '$gromit::install_dir',
         options => ['FollowSymLinks'],
         allow_override => ['AuthConfig'],
         order => ['allow,deny'],
      },
      {
         path => '$gromit::install_dir/sites/',
         allow_override => ['FileInfo'],
         order => ['allow,deny'],
      }
   ]
}

}