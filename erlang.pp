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
    command => "/usr/lib/erlang/bin/erl -eval 'io:format(\"~s\", [erlang:system_info(otp_release)]), halt().' -noshell | grep -q $desired_version",
    path    => ['/usr/lib/erlang/bin', '/bin', '/usr/bin'],
    onlyif  => "/usr/bin/test -x /usr/lib/erlang/bin/erl",
  }

  # Install Clang-related packages and llvm-runtime
  package { [
    'clang-format',
    'clang-tools',
    'clang',
    'llvm-runtime',  # Add llvm-runtime package here
  ]:
    ensure => 'installed',
  }

  # Install Erlang/OTP from the repository
  package { 'esl-erlang':
    ensure => $desired_version,
    require => [Exec['check-erlang-version'], Package['clang-format', 'clang-tools', 'clang', 'llvm-runtime']],
  }
}