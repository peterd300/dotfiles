
# My own dot files and install script Openbox for Void Linux system


dot files for 

openbox
kitty
polybar
picom
htop
dunst

Pre-requierments for the install script

after installation and first reboot
login as root
## change shell to bash shell as root
```bash
bash
chsh /bin/bash
```

## disable enoying beep in terminal
```
sudo nano /etc/inputrc
```
uncomment set bell-style none

## update xbps
``` bash
# sync respository
sudo xbps-install -Suy
# update xbps 
sudo xbps-install -Sy xbps
```
reboot system
after reboot login as user and run install script
```
git clone https://github.com/peterd300/dotfiles
cd dotfiles
chmod +x ./install.sh
./install.sh
```
 

During installation some basic and default config files are copied.

After reboot copy all files to your homedirectoy nad override exstings


Things to do:

- picom doesn;t work in VM workstation 
- polybar config 
