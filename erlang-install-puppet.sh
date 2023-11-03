#!/bin/bash

# Add the Erlang/OTP repository to APT
echo "Adding Erlang/OTP repository..."
sudo sh -c 'echo "deb https://packages.erlang-solutions.com/ubuntu trusty contrib" > /etc/apt/sources.list.d/erlang.list'
wget -q -O - https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | sudo apt-key add -

# Update APT package lists
echo "Updating APT package lists..."
sudo apt-get update

# Install Erlang/OTP 20.3
echo "Installing Erlang/OTP 20.3..."
sudo apt-get install -y erlang=1:20.3

# Verify Erlang/OTP installation
erl -version

echo "Erlang/OTP 20.3 has been installed."