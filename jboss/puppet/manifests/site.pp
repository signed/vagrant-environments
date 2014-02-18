#$packages = [ "git", "build-essential", "libxslt1-dev", libxml2-dev]
#package { $packages: ensure => installed }


node default {
  include stdlib

  class { 'apt':
    always_apt_update    => true,
  }

  class{ 'java':
    before  => Class['jboss'],
    version => 'latest',
  }

  package{ "install puppet":
    before  => Class['jboss'],
    name    => 'puppet',
    ensure  => latest,
  }

  package{ "install unzip":
    before => Class['jboss'],
    name   => 'unzip',
    ensure =>latest,
  }

  #change owner of extracted files
  class { 'jboss':
    install             => 'source',
    version             => '7',
    install_source      => 'http://192.168.9.138:8080/files/jboss/jboss-as-7.1.1.Final.zip',
    disable             => '',
  }

  jboss::instance { 'strom':
    createuser             => false, # Default user jboss is already created by jboss class
    bindaddr               => '0.0.0.0',
    bindaddr_admin_console => '0.0.0.0',
    port                   => '8080', # Configuration gets ignored, it will always be 8080
    conf_dir => "configuration/jboss",
  }

#  file { 'add managment user':
#    require => Jboss::Instance['strom'],
#    name => '/tmp/mgmt-users.properties',
#    source => 'puppet:///modules/configuration/jboss/mgmt-users.properties',
#    mode => "0600",
#    owner => "jboss",
#    group => "jboss",
#  }

}

#puppet apply --verbose --debug --modulepath '/etc/puppet/modules:/tmp/vagrant-puppet-1/modules-0:/tmp/vagrant-puppet-1/modules-1' --manifestdir /tmp/vagrant-puppet-1/manifests --detailed-exitcodes /tmp/vagrant-puppet-1/manifests/site.pp