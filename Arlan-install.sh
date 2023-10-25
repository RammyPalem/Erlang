#!/bin/bash

# Set the desired Erlang/OTP version
OTP_VERSION="20"

# Check if Erlang/OTP version is already installed
ERL_CHECK=$(erl -eval "erlang:display(erlang:system_info(otp_release)), halt()." -noshell 2> /dev/null)
if [[ $ERL_CHECK == $OTP_VERSION* ]]; then
    echo "Erlang/OTP $OTP_VERSION is already installed."
    exit 0
fi

# Update package lists
sudo apt-get update

# Install dependencies
sudo apt-get install -y build-essential wget

# Download Erlang/OTP source code
wget "https://github.com/erlang/otp/archive/OTP-${OTP_VERSION}.tar.gz" -O otp-${OTP_VERSION}.tar.gz
tar -xf otp-${OTP_VERSION}.tar.gz
rm otp-${OTP_VERSION}.tar.gz
cd otp-OTP-${OTP_VERSION}

# Configure and build Erlang/OTP
./otp_build autoconf
./configure
make
sudo make install

# Cleanup
cd ..
rm -rf otp-OTP-${OTP_VERSION}

echo "Erlang/OTP $OTP_VERSION has been successfully installed."
