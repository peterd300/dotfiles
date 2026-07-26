#!/bin/bash

#sync xbps database
echo "Syncing Repository"
sudo xbps-install -Suy
sudo xbps-install -Sy virt-what
sleep 10

# Automatische detectie van de hypervisor
VIRT_TYPE=$(sudo virt-what)

if [ "$VIRT_TYPE" = "vmware" ]; then
    echo "[VINDING] VMware detected! Starting VMware Tools installation..."
    
    # Install base and graphical tools, including X11 clipboard support
    sudo xbps-install -Sy open-vm-tools mesa-vaapi mesa-vmwgfx-dri 
    
    # Enable and start the runit services
    sudo ln -s /etc/sv/vmware-vmblock-fuse /var/service/
    sudo ln -s /etc/sv/vmtoolsd /var/service/
    sudo sv up vmtoolsd
    sudo sv up vmware-vmblock-fuse
    
    # Force X11 clipboard integration for the current desktop environment
    if [ -d "/etc/xdg/autostart" ]; then
        sudo cp /etc/xdg/autostart/vmware-user.desktop /etc/xdg/autostart/ 2>/dev/null
    fi
    
    echo "[SUCCESS] VMware Tools successfully installed and activated."
else
    echo "[INFO] Virtual environment is: '${VIRT_TYPE:-bare-metal}'. VMware Tools skipped."
fi



# install X11 in Voidlinux guest

# first install some usefull programs
sudo xbps-install -Sy htop btop make git wget unzip nano cmake curl gcc net-tools fastfetch mlocate
sleep 10



# install xorg
sudo xbps-install -Sy xorg xorg-server xorg-apps xrandr xterm xscreensaver twm xinit xsel xclip xcolor

# install openbox
sudo xbps-install -Sy openbox obconf obmenu-generator obconf-qt lxappearance lxappearance-obconf nwg-look
mkdir -p ~/.config/openbox
sleep 1
cp /etc/xdg/openbox/rc.xml ~/.config/openbox/
cp /etc/xdg/openbox/autostart ~/.config/openbox/
cp /etc/xdg/openbox/menu.xml ~/.config/openbox/

sleep 2

# Create a basic .xinitrc

echo "xrandr --output Virtual-1 --mode 1920x1080 " >> ~/.xinitrc
echo "exec xterm & " >> ~/.xinitrc
echo "exec openbox-session" >> ~/.xinitrc
echo "# exec twm" >> ~/.xinitrc

## install openbox utils
sudo xbps-install -Sy polybar dunst rofi feh xdg-user-dirs xdg-utils nitrogen xfce4-appfinder 
mkdir -p ~/.config/polybar

## install dbus
sudo xbps-install -Sy dbus
sudo ln -s /etc/sv/dbus /var/service/
sudo sv up dbus


## install elogind
sudo xbps-install -Sy elogind dbus-elogind polkit polkit-elogind 
sleep 1
sudo ln -s /etc/sv/elogind /var/service/
sudo ln -sf /etc/sv/polkitd /var/service/
sudo sv up dbus

## install lightdm
# sudo xbps-install -Sy lightdm lightdm-gtk-greeter
# sudo ln -s /etc/sv/lightdm /var/service/



## install x11 utils (icon theme switch werkt nog niet)
sudo xbps-install -Sy adwaita-plus turnstile font-awesome 
# temporary disabled very big and slow download
# sudo xbps-install -Sy nerd-fonts

sudo ln -sf /etc/sv/turnstiled/ /var/service/
sudo sv up turnstiled

## install favorite X11 programs
sudo xbps-install -Sy alacritty falkon kitty st flameshot gmrun xbindkeys xdotool xev
mkdir -p ~/screenshots

#install filemanager + jpg viewer
sudo xbps-install -Sy Thunar thunar-archive-plugin thunar-media-tags-plugin tumbler lximage-qt gvfs

#install X11 icon themes
sudo xbps-install -Sy papirus-icon-theme lxde-icon-theme xcursor-themes

#install geany
sudo xbps-install -Sy geany geany-editorconfig-plugin geany-plugins geany-plugins-extra

# picom
sudo xbps-install -Sy picom
sleep 2
mkdir -p ~/.config/picom
cp /usr/share/examples/picom/picom.sample.conf ~/.config/picom/picom.conf

## install sound support
sudo xbps-install -Sy pipewire alsa-plugins-pulseaudio wireplumber pavucontrol pamixer

## give local user access to audio and video device
sudo usermod -aG audio,video $(whoami)

# create tmp dir for pipewire, wthout pipwire  don't start
#.bashrc
# insert 
# mkdir /tmp/$(id -u)
# export XDG_RUNTIME_DIR=/tmp/$(id -u)

# create again menu
obmenu-generator -p -i

# ~/.config/openbox/autostart

echo "sleep 1 && /usr/bin/vmware-user & " >> ~/.config/openbox/autostart
echo "sleep 1 && pipewire &" >> ~/.config/openbox/autostart
echo "sleep 1 && wireplumber &" >> ~/.config/openbox/autostart
echo "sleep 1 && pipewire-pulse &" >> ~/.config/openbox/autostart
echo "sleep 1 " >> ~/.config/openbox/autostart
echo "sleep 1 && polybar &" >> ~/.config/openbox/autostart
echo "# sleep 1 && picom &" >> ~/.config/openbox/autostart

# install Jetbrains Mono and Nerd fonts, fonts used in kitty

echo install JetbrainsMono fonts
sudo mkdir -p /usr/local/share/fonts/JetbrainsMono/
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip

unzip JetBrainsMono-2.304.zip -d /tmp/jetbrains-mono
sleep 1
sudo mv /tmp/jetbrains-mono/fonts/* /usr/local/share/fonts/JetbrainsMono/.

# re-generate font-cache
fc-cache -f -v

sleep 5
rm -rf /tmp/jetbrains-mono
rm -f ~/JetBrainsMono-2.304.zip

echo
echo "end of script"
echo
