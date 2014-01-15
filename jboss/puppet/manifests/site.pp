#$packages = [ "git", "build-essential", "libxslt1-dev", libxml2-dev]
#package { $packages: ensure => installed }

package{ "puppet":
  ensure=>latest,
}

class { 'java':
  version => 'latest',
}

package{ 'install unzip':
  name => 'unzip',
  ensure => 'present',
}