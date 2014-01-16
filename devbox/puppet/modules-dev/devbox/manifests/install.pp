define devbox::install(
  $home,
  $user
) {

  $ruby_version='1.9.2-p320'
  $user_name=$user
  $user_home=$home
  $rbenv_root="${home}/.rbenv"
  $rbenv_path = [ "${rbenv_root}/shims", "${rbenv_root}/bin", "/bin/", "/usr/bin" ]

  rbenv::install { "signed rbenv":
    user => $user_name,
    root => $rbenv_root,
  }

  rbenv::compile { 'signed rbenv install ruby' :
    require => Rbenv::Install["signed rbenv"],
    user => $user_name,
    ruby => $ruby_version,
    global => true,
  }

  rbenv::gem { "gem install librarian-puppet":
    require => Rbenv::Compile["signed rbenv install ruby"],
    user => $user_name,
    ruby => $ruby_version,
    gem => "librarian-puppet",
  }
}