$packages = [ "git", "build-essential"]
package { $packages: ensure => installed }

vcsrepo { '/agora/arbeitskopie':
  require => Package['git'],
  ensure => present,
  provider => git,
  source => "https://github.com/softwerkskammer/Agora.git",
  user => 'vagrant',
}

class{ 'nodejs':
  version => '0.8.25-2chl1~precise1',
  dev_package => true,
  manage_repo => true,
}

exec{'configure logging with winston':
  require => Vcsrepo['/agora/arbeitskopie'],
  command => 'sed \'/^\/\//d\' example-winston-config.json > winston-config.json',
  cwd => '/agora/arbeitskopie/config',
  creates => '/agora/arbeitskopie/winston-config.json',
  user => 'vagrant',
  path => '/bin',
}

exec{'download node dependencies':
  require => Class['nodejs'],
  command => 'npm install',
  cwd => '/agora/arbeitskopie',
  creates => '/agora/arbeitskopie/node_modules',
  user => 'vagrant',
  path => '/usr/bin',
}

exec{'write test data into database':
  require => Exec['download node dependencies'],
  command => 'node initialDBSetup.js really > log/databasesetup.log',
  cwd => '/agora/arbeitskopie/',
  creates => '/agora/arbeitskopie/log/databasesetup.done',
  user => 'vagrant',
  path => ['/usr/bin', '.'],
}

class{ 'mongodb':
  enable_10gen => true,
}