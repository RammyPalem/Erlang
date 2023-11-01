#!/bin/bash

# Update the package manager
sudo yum update -y

# Install required dependencies
sudo yum install -y gcc gcc-c++ glibc-devel make ncurses-devel openssl-devel autoconf java-1.8.0-openjdk-devel

# Download the Erlang/OTP source code (adjust the version if needed)
wget https://github.com/erlang/otp/archive/OTP-20.3.tar.gz
tar xvzf OTP-20.3.tar.gz

# Build and install Erlang/OTP
cd otp-OTP-20.3
./otp_build autoconf
./configure
make
sudo make install

# Clean up
cd ..
rm -rf OTP-20.3.tar.gz otp-OTP-20.3

# Verify Erlang/OTP installation
erl -version