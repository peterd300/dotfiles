
# My own dot files and install script Openbox for Void Linux system

I test this script in Vmware Workstation Pro 25 / 26

When you login on TTY1 , startx in automatic executed. (via .bash_profile)
With CRTL-ALT F2-F5, normal terminal

dot files for 

- openbox 	- windows manager
- kitty 		- terminal
- polybar 	- X11 Statusbar
- picom 		- X11 compositor
- htop 
- dunst 		- X11 notification tool

Pre-requierments for the install script

after installation and first reboot in Void Linux
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

After reboot, copy all from dotfiles directory to your homedirectoy with override exsiting files.
```bash
cd dotfiles
cp -R .* ..
```

Sources used:

- Just a linux guy:  openbox configuration files
- Big thank you for Radley Leweis for his zsh config files
  https://github.com/radleylewis/zsh for installation.
- pywal for generating color pallet
- walbox openbox theme for pywal

Things to do:
- implementing zsh shell

