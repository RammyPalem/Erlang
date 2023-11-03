class erlang_install {
  exec { 'install_erlang':
    command     => '/tmp/script.sh',
    user        => 'root',
    group       => 'root',
    timeout     => 1200, # Timeout in seconds (20 minutes)
    unless      => 'erl -eval "io:format(~p~n, [erlang:system_info(otp_release)])" -s init stop | grep -q "20.3"',
    path        => '/usr/bin:/bin',
    require     => File['/tmp/script.sh'], # Ensure the script is present
    logoutput   => true,
  }

  file { '/tmp/script.sh':
    source => 'puppet:///modules/your_module/script.sh', # Path to your script
    owner  => 'root',
    group  => 'root',
    mode   => '0755', # Make the script executable
  }
}