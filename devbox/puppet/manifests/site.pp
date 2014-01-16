#$packages = [ "git", "build-essential", "libxslt1-dev", libxml2-dev]
#package { $packages: ensure => installed }

package{ "puppet":
  ensure=>latest,
}

$user= 'signed'
$user_home="/home/signed"

user{ 'create user signed':
  name => $user,
  managehome => true,
  shell => '/bin/bash',
  ensure => 'present',
}

devbox::install{ 'signed devbox install':
  require => User['create user signed'],
  home => $user_home,
  user => $user,
}