define veewee::install(
  $veewee_directory  = $title,
  $user
) {

  $ruby_version='1.9.2-p320'
  $user_name=$user
  $user_home='/home/vagrant'
  $rbenv_root="${user_home}/.rbenv"
  $rbenv_path = [ "${rbenv_root}/shims", "${rbenv_root}/bin", "/bin/", "/usr/bin" ]

  rbenv::install { "vagrant rbenv":
    user => $user_name,
    root => $rbenv_root,
  }

  rbenv::compile { 'vagrant rbenv install veewee ruby' :
    user => $user_name,
    ruby => $ruby_version,
    require => Rbenv::Install["vagrant rbenv"],
  }

  exec { 'veewee set used ruby version':
    require => Rbenv::Compile['vagrant rbenv install veewee ruby'],
    user => $user_name,
    environment => ["HOME=${user_home}"],
    cwd => $veewee_directory,
    path => $rbenv_path,
    command => "rbenv local ${ruby_version} && rbenv rehash",
    creates =>  "${veewee_directory}/.ruby-version",
    #  command => '/bin/echo $HOME > /tmp/command && /bin/pwd >> /tmp/command ',
    #  logoutput => true,
  }

  exec { 'veewee fetch required gems':
    require => Exec['veewee set used ruby version'],
    user => $user_name,
    environment => ["HOME=${user_home}"],
    cwd => $veewee_directory,
    path => $rbenv_path,
    command => "bundle install && rbenv rehash",
  }
}