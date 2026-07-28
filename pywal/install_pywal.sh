#!/bin/sh
# installation of pywall via the repo
# install walbox - pywal theme for openbox
# copy several config files for implementing for pywall theme

cd ~/dotfiles/pywal

sudo xbps-install -Suy
sudo xbps-install -Sy gtk2-engines pywal

# install walbox theme for openbox
git clone https://github.com/edisile/walbox.git
cd walbox
./install.sh
cd ..

cp -Rv ~/dotfiles/pywall/.config/* ~/.config
