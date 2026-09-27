#!/usr/bin/env bash

echo "Enter the sudo password:"
sudo -v

mkdir -p  ~/temp
cd ~/temp/

wget https://ziglang.org/download/0.16.0/zig-x86_64-linux-0.16.0.tar.xz
sleep 1
tar -xvf zig*.tar.xz
sleep 1
cd zig-x86_64-linux-0.16.0/
# bat README.md

sudo mkdir -p /usr/local/bin/doc
sudo mkdir -p /usr/local/lib/zig

sudo mv zig /usr/local/bin/.
sudo mv doc/* /usr/local/bin/doc/.
sudo mv lib/*  /usr/local/lib/zig/.

cd ~

rm -rf ~/temp
