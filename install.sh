#!/bin/bash

#install open-vmtools-agent for guest in Vmware workstation
sudo xbps-install -Sy open-vm-tools
sudo ln -s /etc/sv/vmware-vmblock-fuse /var/service/
sudo ln -s /etc/sv/vmtoolsd /var/service/


# install qemu-agent for promox
# check qemu-agent vm config
#  sudo xbps-install -S qemu-guest-agent
# sudo ln -s /etc/sv/qemu-guest-agent /var/service/


# install X11 in Voidlinux guest

# first install some usefull programs
sudo xbps-install -Sy htop btop make git wget unzip nano cmake curl gcc net-tools fastfetch


# install xorg
sudo xbps-install -Syu
sudo xbps-install -Sy xorg xorg-server xorg-apps xrandr xterm xscreensaver twm


# install openbox
sudo xbps-install -Sy openbox obconf obmenu-generator obconf-qt lxappearance lxappearance-obconf

mkdir -p ~/.config/openbox
sleep 1
cp /etc/xdg/openbox/rc.xml ~/.config/openbox/

cp /etc/xdg/openbox/autostart ~/.config/openbox/
cp /etc/xdg/openbox/menu.xml ~/.config/openbox/
obmenu-generator -p -i
sleep 2

echo "exec xterm & " >> ~/.xinitrc
echo "exec openbox-session" >> ~/.xinitrc
echo "# exec twm" >> ~/.xinitrc


## install openbox utils
sudo xbps-install -Sy polybar tint2 feh xdg-user-dirs xdg-utils nitrogen 
mkdir -p ~/.config/polybar



## install elogind
sudo xbps-install -Sy elogind dbus-elogind 
sleep 1
sudo ln -s /etc/sv/elogind /var/service/

## install lightdm
# sudo xbps-install -Sy lightdm lightdm-gtk-greeter
# sudo ln -s /etc/sv/lightdm /var/service/

## install dbus
sudo xbps-install -Sy dbus
sudo ln -s /etc/sv/dbus /var/service/


## install x11 utils (icon theme switch werkt nog niet)
sudo xbps-install -Sy adwaita-plus turnstile nerd-fonts font-awesome 
sudo ln -sf /etc/sv/turnstiled/ /var/service/

## install favorite X11 programs
sudo xbps-install -Sy alacritty falkon kitty st flameshot
mkdir -p ~/Screenshots

#install filemanager + jpg viewer
sudo xbps-install -Sy Thunar thunar-archive-plugin thunar-media-tags-plugin tumbler lximage-qt  

#install X11 icon themes
sudo xbps-install -Sy papirus-icon-theme lxde-icon-theme xcursor-themes


#install geany
sudo xbps-install -Sy geany geany-editorconfig-plugin geany-plugins geany-plugins-extra

#install several apps
sudo xbps-install acpid  
sudo ln -s /etc/sv/acpid /var/service/

## picon
sudo xbps-install -Sy picom
sleep 2
mkdir -p ~/.config/picom
cp /usr/share/examples/picom/picom.sample.conf ~/.config/picom/picom.conf


## install sound support
sudo xbps-install -Sy pipewire alsa-plugins-pulseaudio wireplumber pavucontrol pamixer


## give user access to audio and video device

sudo usermod -aG audio,video $(whoami)


# create tmp dir for pipewire, wthout pipwire  don't start
#.bashrc
# insert 
# mkdir /tmp/$(id -u)
# export XDG_RUNTIME_DIR=/tmp/$(id -u)

# create again menu
obmenu-generator -p -i

# ~/.config/openbox/autostart

echo "sleep 1 && pipewire &" >> ~/.config/openbox/autostart
echo " sleep 1 && wireplumber &" >> ~/.config/openbox/autostart
echo "sleep 1 && pipewire-pulse &" >> ~/.config/openbox/autostart
echo "sleep 1 " >> ~/.config/openbox/autostart
echo "sleep 1 && polybar &" >> ~/.config/openbox/autostart
echo "# sleep 1 && picom &" >> ~/.config/openbox/autostart
