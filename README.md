# dotfiles
My own dot files

# first attempt to use github for my .dot files for void linux

dot files for

openbox
polybar
picom
htop

Prerequierment for the install script

after installation and first reboot
login as root
#change bash shellroot
```bash
bash
chsh /bin/bash
```

## disable enoying beep in terminal
sudo nano /etc/inputrc
uncomment set bell-style none

## update xbps
sudo xbps-install -Suy
sudo xbps-install -Sy xbps

reboot system
after reboot login as user and reu install script
