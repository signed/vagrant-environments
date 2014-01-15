$packages = [ "git", "build-essential", "libxslt1-dev", libxml2-dev]
package { $packages: ensure => installed }

package{ "puppet":
  ensure=>latest,
}

class { 'virtualbox':
  require => Package['puppet'],
}

$user= 'vagrant'
$user_home="/home/vagrant"
$veewee_directory = "${user_home}/dev/arbeitskopie/veewee"

vcsrepo { $veewee_directory:
  ensure => present,
  provider => git,
  source => "https://github.com/signed/veewee.git",
  user => $user,
  require => Package['git'],
}

veewee::install{ $veewee_directory:
  user => $user,
}