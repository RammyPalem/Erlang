#!/bin/bash

required_version="20.3"

# Check if Erlang is installed
if erl -eval "erlang:display(erlang:system_info(otp_release)), halt()." -noshell | grep -q "$required_version"; then
  echo "Erlang/OTP $required_version is already installed."
else
  echo "Erlang/OTP $required_version is not installed. Installing..."

  # Add the Erlang Solutions repository and install Erlang/OTP 20.3
  wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
  sudo dpkg -i erlang-solutions_1.0_all.deb
  sudo apt-get update
  sudo apt-get install -y esl-erlang=1:20.3

  # Verify the installation
  if erl -eval "erlang:display(erlang:system_info(otp_release)), halt()." -noshell | grep -q "$required_version"; then
    echo "Erlang/OTP $required_version has been successfully installed."
  else
    echo "Failed to install Erlang/OTP $required_version."
  fi

  # Clean up the downloaded package
  rm erlang-solutions_1.0_all.deb
fi