#!/bin/bash

# Add the Erlang Solutions repository GPG key
wget -O - https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | sudo apt-key add -

# Add the Erlang Solutions repository to your apt sources
echo "deb https://packages.erlang-solutions.com/ubuntu focal contrib" | sudo tee /etc/apt/sources.list.d/erlang-solutions.list

# Update your apt package list
sudo apt-get update

# Install Erlang/OTP 20.3
sudo apt-get install -y erlang=1:20.3

# Verify the installed Erlang version
erl -eval "io:format(\"Erlang/OTP ~s~n\", [erlang:system_info(otp_release)]), halt()."

# Remove the repository file
sudo rm /etc/apt/sources.list.d/erlang-solutions.list

# Update apt once more
sudo apt-get update