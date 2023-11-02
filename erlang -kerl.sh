#!/bin/bash

# Install kerl
curl -o kerl https://raw.githubusercontent.com/kerl/kerl/master/kerl
chmod +x kerl
mv kerl /usr/local/bin

# List available releases
kerl list releases

# Install Erlang/OTP 20.3
kerl build 20.3 20.3
kerl install 20.3 ~/.kerl/installs/20.3

# Activate Erlang/OTP 20.3
. ~/.kerl/installs/20.3/activate

# Verify the installed Erlang version
erl -eval 'erlang:display(erlang:system_info(otp_release)), init:stop().'

echo "Erlang/OTP 20.3 has been installed and activated. Use 'erl' to access the Erlang shell."