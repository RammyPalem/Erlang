"UserData": {
					"Fn::Base64": {
						"Fn::Join": [
							"\n", [
								"#!/bin/bash",
								"apt-get update",
								"apt-get install -y build-essential autoconf libncurses5-dev m4 java-common wget libssl-dev clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang automake",
								"wget https://www.erlang.org/download/otp_src_20.3.tar.gz",
								"tar xvzf OTP-20.3.tar.gz",
								"cd otp-OTP-20.3",
								"./otp_build autoconf && ./configure",
								"make",
								"sudo make install",
								"cd ..",
								"rm -rf OTP-20.3.tar.gz otp-OTP-20.3",

							]
						]
					}
				},
