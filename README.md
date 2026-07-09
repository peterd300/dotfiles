# dotfiles
My own dot files and install script for Void Linux system

# first attempt to use github for my .dot files for void linux

dot files for

openbox
polybar
picom
htop

Prerequierment for the install script

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
