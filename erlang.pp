class erlang_install {
  $desired_version = '20.3'

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

  # Download and install Erlang/OTP 20.3 if not found or not at the desired version
  exec { 'install-erlang':
    command  => "wget https://www.erlang.org/download/otp_src_${desired_version}.tar.gz -O /tmp/otp_src_${desired_version}.tar.gz && tar -xzvf /tmp/otp_src_${desired_version}.tar.gz -C /tmp && cd /tmp/otp_src_${desired_version} && ./configure && make && make install",
    creates  => "/usr/local/lib/erlang/erts-${desired_version}",
    unless   => "/usr/bin/test -x /usr/lib/erlang/bin/erl && /usr/lib/erlang/bin/erl -eval 'io:format(\"~s\", [erlang:system_info(otp_release)]), halt().' -noshell | grep -q $desired_version",
    require  => [Exec['check-erlang-version'], Package['clang-format', 'clang-tools', 'clang', 'llvm-runtime']],
  }
}
