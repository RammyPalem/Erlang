class erlang_install {
  $desired_version = '20.3'

  # Add the Erlang Solutions repository
  apt::source { 'erlang-solutions':
    location   => 'https://packages.erlang-solutions.com/ubuntu',
    key        => {
      id     => '9F77F57AEF05CA5D',
      source => 'https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc',
    },
    release    => 'focal', # Use 'focal' for Ubuntu 20.04
    repos      => 'contrib',
    include    => {
      src  => false,
      deb  => true,
    },
  }

  # Check if Erlang is already installed at the desired version
  exec { 'check-erlang-version':
    command => "dpkg -l | grep '^ii' | grep esl-erlang | grep $desired_version",
    path    => ['/bin', '/usr/bin'],
  }

  # Install additional packages like Clang
  package { [
    'esl-erlang',    # Install Erlang/OTP
    'clang',         # Add other packages here
    'clang-format',
    'clang-tools',
    'llvm-runtime',
  ]:
    ensure  => $desired_version, # Specify the version if applicable
    require => Apt::Source['erlang-solutions'], # Ensure the source is added first
    unless  => "dpkg -l | grep '^ii' | grep $_ | grep $desired_version",
  }
}