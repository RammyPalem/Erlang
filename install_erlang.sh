#!/bin/bash
#!/bin/bash

# Function to compare Erlang version
check_erlang_version() {
  installed_version=$(erl -eval "io:format(\"~s~n\", [erlang:system_info(otp_release)])" -s init stop)
  desired_version="20.3"  # Replace with your desired version

  if [ "$installed_version" = "$desired_version" ]; then
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
# Install dependencies for building Erlang
sudo apt-get update
sudo apt-get install -y build-essential libncurses5-dev libssl-dev m4

# Clone the kerl repository if not already installed
if [ ! -d ~/.kerl ]; then
  git clone https://github.com/kerl/kerl.git ~/.kerl
fi

# Build and install Erlang/OTP 20.3
~/.kerl/kerl build 20.3 20.3
~/.kerl/kerl install 20.3 ~/.erlang/20.3

# Activate Erlang/OTP 20.3
. ~/.kerl/installs/20.3/activate

# Verify the installed Erlang version
erl -eval "io:format(\"Erlang/OTP ~s~n\", [erlang:system_info(otp_release)])" -s init stop