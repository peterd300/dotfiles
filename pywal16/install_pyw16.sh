#!/bin/bash

# install pywal16 via pip3
sudo xbps-install -Sy python3-pipenv python3-pipx ImageMagick

pipx install pywal16

pipx ensurepath
echo " eval "$(register-python-argcomplete pipx)" " >> ~/.bashrc

source ~/.bashrc



# install walbox theme for openbox
git clone https://github.com/edisile/walbox.git
cp install.sh walbox/.
cd walbox
./install.sh
cd ..


rm -rf .git


# copy several config files
cp -Rv ~/dotfiles/pywal16/.config/* ~/.config

# copy script for changing wallpaper, because wal runs in pip sandbox
cp -v ~/dotfiles/pywal16/chwal.sh ~/.local/bin/.

source ~/.bashrc

# which wal
~/.local/bin/wal -v

~/.local/bin/chwal.sh  ~/.wallpaper/blue-mountains.jpg
openbox --reconfigure

