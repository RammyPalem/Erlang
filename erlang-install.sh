#!/bin/bash

#Install prerequisites
sudo apt-get update
sudo apt-get install wget apt-transport-https -y

# Add erlang repository key
sudo wget -0- https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | sudo apt-key add -
sudo wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.d

#Add erlang Repository
echo "deb https://packages.erlang-solutions.com/ubuntu focal contrib" | sudo tee /etc/apt/sources.list.d/erlang-solution.list

#Install erlang
sudo apt-get update
sudo apt-get  install erlang
sudo apt-get install clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang automake autoconf
