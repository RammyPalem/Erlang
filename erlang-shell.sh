#!/bin/bash

# Create a directory for the installation
mkdir -p ~/erlang

# Download the Erlang/OTP 20.3 package
wget https://packages.erlang-solutions.com/debian/pool/esl-erlang_20.3-1~ubuntu~focal_amd64.deb -O ~/erlang/erlang.deb

# Extract the package contents
dpkg-deb -x ~/erlang/erlang.deb ~/erlang

# Add the bin directory to your PATH
echo 'export PATH=~/erlang/usr/lib/erlang/bin:$PATH' >> ~/.bashrc

# Reload your shell environment
source ~/.bashrc

# Clean up the downloaded package
rm ~/erlang/erlang.deb

echo "Erlang/OTP 20.3 has been installed. Please open a new terminal to use it."