class erlang_install {
  $desired_version = '20.3'

  # Check if Erlang is installed
  $erlang_installed = package { 'esl-erlang':
    ensure => 'installed',
  }

  # Check if Erlang is at the desired version (adjust the path to erl as needed)
  exec { 'check-erlang-version':
    command => "erl -eval 'io:format(\"~s\", [erlang:system_info(otp_release)]), halt().' -noshell | grep -q $desired_version",
    path    => ['/usr/lib/erlang/bin', '/bin', '/usr/bin'],
    notify  => Exec['install-erlang'],
  }

  # Download and install Erlang/OTP if not found or not at the desired version
  exec { 'install-erlang':
    command  => "wget https://packages.erlang-solutions.com/ubuntu/pool/esl-erlang_${desired_version}~ubuntu~$(lsb_release -c -s)_amd64.deb -O /tmp/esl-erlang.deb && dpkg -i /tmp/esl-erlang.deb",
    creates  => "/usr/lib/erlang/erts-${desired_version}",
    unless   => "erl -eval 'io:format(\"~s\", [erlang:system_info(otp_release)]), halt().' -noshell | grep -q $desired_version",
    require  => Package['esl-erlang'],
  }
}