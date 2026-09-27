#!/usr/bin/bash

# install kora icons


tempdir="$HOME/temp"

mkdir $tempdir
cd $tempdir

git clone https://github.com/bikass/kora.git --depth=1

sudo mv kora/kora/ /usr/share/icons/
sudo mv kora/kora-pgrey/ /usr/share/icons/

rm -rf $tempdir
