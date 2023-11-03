#!/bin/bash

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