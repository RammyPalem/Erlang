class erlang_install {
  $desired_version = '20.3'

  # Check if Erlang is already installed at the desired version
  exec { 'check-erlang-version':
    command => "/usr/bin/dpkg -l | grep '^ii' | grep erlang | grep $desired_version",
    path    => ['/bin', '/usr/bin'],
  }

  # Execute your custom shell script to install Erlang
  exec { 'install-erlang':
    command  => '/path/to/your/install_erlang_script.sh', # Replace with the actual path to your shell script
    creates  => "/usr/local/lib/erlang/erts-${desired_version}",
    unless   => "/usr/bin/dpkg -l | grep '^ii' | grep erlang | grep $desired_version",
    require  => Exec['check-erlang-version'],
  }
}