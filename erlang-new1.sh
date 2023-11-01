#!/bin/bash
# Check if Erlang/OTP is installed
erl_version=$(erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell 2>/dev/null)

if [ -z "$erl_version" ]; then
  echo "Erlang/OTP is not installed."
else
  # Check if Erlang/OTP version is 20.3
  if [ "$erl_version" == "20.3" ]; then
    echo "Erlang/OTP version 20.3 is already installed. Exiting."
    exit 0
  else
    echo "Erlang/OTP version $erl_version is installed, but we need version 20.3."
    echo "Proceeding with the installation..."
  fi
fi

# Rest of the installation script
# Update the package manager
sudo apt-get update

# Install required dependencies
sudo apt-get install -y build-essential autoconf libncurses5-dev m4 java-common wget libssl-dev clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang automake

# Download the Erlang/OTP source code (adjust the version if needed)
wget --no-check-certificate https://www.erlang.org/download/otp_src_20.3.tar.gz

# Build and install Erlang/OTP
cd otp_src_20.3
./otp_build autoconf
./configure
make
sudo make install

# Clean up
cd ..
rm -rf otp_src*

# Verify Erlang/OTP installation
erl -version
