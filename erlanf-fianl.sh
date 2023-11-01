#!/bin/bash

# Proceed with the installation of Erlang/OTP version 20.0
erl_version="20.0"

# Rest of the installation script (install Erlang/OTP version $erl_version)
# ...

# Update the package manager
sudo apt-get update

# Install required dependencies
sudo apt-get install -y build-essential autoconf libncurses5-dev libssl-dev m4 java-common clang clang-format

# Download the Erlang/OTP source code (official Erlang site, adjust the version if needed)
wget --no-check-certificate "https://www.erlang.org/download/otp_src_$erl_version.tar.gz"
tar xvzf "otp_src_$erl_version.tar.gz"

# Build and install Erlang/OTP
cd "otp_src_$erl_version"
./otp_build autoconf
./configure
make
sudo make install

# Clean up
cd ..
rm -rf "otp_src_$erl_version.tar.gz" "otp_src_$erl_version"

# Verify Erlang/OTP installation
erl -version