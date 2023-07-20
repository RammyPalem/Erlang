#!/bin/bash
## ubuntu


### install asdf 
apt install curl git
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc
source ~/.bashrc
asdf --version
if [ $? -eq 0 ]; then
    ## install prereq's for erlang
    apt update
    sudo apt-get install libssl-dev clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang automake autoconf libncurses5-dev
    ## install erlang
    asdf plugin add erlang
    ## this will take some time ~ 10 min
    asdf install erlang 25.3
    asdf global erlang 25.3
    exit 0
else
    echo "unable to find asdf"
    exit 0
fi
