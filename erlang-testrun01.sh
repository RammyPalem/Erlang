# Install required dependencies
sudo apt-get update -y
sudo apt-get install wget libssl-dev clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang automake autoconf libncurses5-dev

# Download and extract Erlang/OTP source code
wget https://github.com/erlang/otp/archive/OTP-20.3.tar.gz
tar -xvzf OTP-20.3.tar.gz
cd otp-OTP-20.3

# Configure, build, and install Erlang/OTP
./otp_build autoconf
./configure
make
sudo make install

# Verify the installation
erl -eval 'erlang:display(erlang:system_info(otp_release)), halt()' -noshell
