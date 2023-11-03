#!/bin/bash

# Function to check Erlang version
check_erlang_version() {
  installed_version=$(erl -eval "io:format(\"~s~n\", [erlang:system_info(otp_release)])" -s init stop)
  desired_version="20.3"  # Replace with your desired version

  # Extract only the digits from the version string
  installed_version_digits=$(echo "$installed_version" | awk '{print $1}')

  if [ "$installed_version_digits" = "$desired_version" ]; then
    echo "Erlang version is already the desired version ($desired_version). Exiting."
    exit 0
  else
    echo "Erlang version is not the desired version. Proceeding with script execution."
  fi
}

# Call the function to check Erlang version
check_erlang_version

# Add your script logic here
# ...