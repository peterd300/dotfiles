#!/bin/bash

# install pywal16 via pip3
sudo xbps-install -S python3-pipenv python3-pipx ImageMagick

pipx install pywal16

pipx ensurepath
echo " eval "$(register-python-argcomplete pipx)" " >> ~/.bashrc

source ~/.bashrc



# install walbox theme for openbox
git clone https://github.com/edisile/walbox.git
cd install.sh walbox/.
cd walbox
./install.sh
cd ..


rm -rf .git


# copy several config files
cp -Rv ~/dotfiles/pywal16/.config/* ~/.config
which wal
wal -v

wal -i ~/.wallpaper/blue-mountains.jpg
openbox --reconfigure

