# Install required dependencies
sudo apt-get update -y
sudo apt-get install -y build-essential autoconf m4 libncurses5-dev libwxgtk3.0-gtk3-dev libgl1-mesa-glx libgl1-mesa-dev libssl-dev

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