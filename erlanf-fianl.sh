#!/bin/bash

# Check the installed version using the erl command
installed_version=$(erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell 2>/dev/null)

if [ -z "$installed_version" ]; then
  echo "Erlang/OTP is not installed."
  # Proceed with the installation of Erlang/OTP version 20.0
  erl_version="20.0"
else
  echo "Installed Erlang/OTP version: $installed_version"
  if [ "$installed_version" = "20" ]; then
    echo "Erlang/OTP version 20 is already installed. No need to install."
    exit 0
  elif [ "$installed_version" != "20.0" ]; then
    echo "Erlang/OTP version $installed_version is installed, but we need version 20.0."
    echo "Proceeding with the installation of Erlang/OTP version 20.0..."
    erl_version="20.0"
  else
    echo "Erlang/OTP version 20.0 is already installed. No need to install."
    exit 0
  fi
fi