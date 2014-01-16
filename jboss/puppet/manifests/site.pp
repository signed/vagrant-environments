#$packages = [ "git", "build-essential", "libxslt1-dev", libxml2-dev]
#package { $packages: ensure => installed }


node default {
  include apt
  include stdlib

  class{ 'java':
    before => Class['jboss'],
    version => 'latest',
  }

  package{ "install puppet":
    before => Class['jboss'],
    name =>  'puppet',
    ensure=>latest,
  }

  package{ "install unzip":
    before => Class['jboss'],
    name => 'unzip',
    ensure=>latest,
  }


  #change owner of extracted files
  class { 'jboss':
    install             => 'source',
    version             => '6',
    install_source      => 'http://192.168.9.138:8080/files/jboss/jboss-as-distribution-6.1.0.Final.zip',
    disable  => '',
  }

  jboss::instance { 'strom':
    createuser => false, # Default user jboss is already created by jboss class
    bindaddr    => '0.0.0.0',
    port        => '8080', # Configuration gets ignored, it will always be 8080
  }
}