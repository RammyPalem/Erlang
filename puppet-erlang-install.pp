class erlang_check_and_execute {
  # Check the installed Erlang version
  exec { 'check_erlang_version':
    command   => 'erl -eval "io:format(\"~s~n\", [erlang:system_info(otp_release)])" -s init stop',
    path      => '/usr/local/bin:/usr/bin', # Adjust the path as needed
    logoutput => true,
    unless    => 'echo "$EXEC_OUTPUT" | grep -q "Erlang/OTP 20"',
    notify    => Exec['execute_script'], # Trigger script execution if version matches
  }

  # Execute the shell script
  exec { 'execute_script':
    command   => '/path/to/your_script.sh', # Replace with the actual path to your script
    path      => '/usr/local/bin:/usr/bin',  # Adjust the path as needed
    require   => Exec['check_erlang_version'],
    onlyif    => 'test -f /path/to/your_script.sh', # Ensure the script exists
  }
}