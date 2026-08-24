#!/usr/bin/env bash

#sync xbps database
echo "Syncing Repository"
sudo xbps-install -Suy
sudo xbps-install -Sy virt-what
sleep 10

# Automatische detectie van de hypervisor
VIRT_TYPE=$(sudo virt-what)

if [ "$VIRT_TYPE" = "vmware" ]; then
    echo "[FINDING] VMware detected! Starting VMware Tools installation..."
    
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
sudo xbps-install -Sy delta htop btop make git wget xz unzip nano cmake curl gcc net-tools fastfetch mlocate
sleep 5



# install xorg
sudo xbps-install -Sy xorg xorg-server xorg-apps xrandr xterm xscreensaver twm xinit xsel xclip xcolor

# install openbox
sudo xbps-install -Sy openbox obconf obmenu-generator obconf-qt lxappearance lxappearance-obconf nwg-look
mkdir -p ~/.config/openbox
mkdir -p ~/.local
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
mkdir -p ~/.config/polybar
sudo xbps-install -Sy polybar dunst rofi feh xdg-user-dirs xdg-utils xfce4-appfinder 


## install dbus
sudo xbps-install -Sy dbus
sudo ln -s /etc/sv/dbus /var/service/
sudo sv up dbus


## install some services

sudo xbps-install -Sy elogind dbus-elogind polkit polkit-elogind turnstile
sleep 1
sudo ln -sf /etc/sv/elogind /var/service/
sudo ln -sf /etc/sv/polkitd /var/service/
sudo ln -sf /etc/sv/turnstiled/ /var/service/
sudo sv up turnstiled
sudo sv up dbus
sudo sv up elogind

## install lightdm
# sudo xbps-install -Sy lightdm lightdm-gtk-greeter
# sudo ln -sf /etc/sv/lightdm /var/service/


## install x11 utils 
sudo xbps-install -Sy adwaita-plus   



# install favorite X11 programs
sudo xbps-install -Sy falkon kitty flameshot gmrun xbindkeys xdotool xev
mkdir -p ~/screenshots

#install Thunar filemanager + jpg viewer
sudo xbps-install -Sy Thunar thunar-archive-plugin thunar-media-tags-plugin tumbler lximage-qt gvfs xarchiver

#install X11 icon themes
sudo xbps-install -Sy papirus-icon-theme lxde-icon-theme xcursor-themes

#install geany
sudo xbps-install -Sy geany geany-editorconfig-plugin geany-plugins geany-plugins-extra

# picom
mkdir -p ~/.config/picom
sudo xbps-install -Sy picom
sleep 2
cp /usr/share/examples/picom/picom.sample.conf ~/.config/picom/picom.conf

## install sound support
sudo xbps-install -Sy pipewire alsa-plugins-pulseaudio wireplumber pavucontrol pamixer

## give local user access to audio and video device
sudo usermod -aG audio,video,input  $(whoami)


# create again openbox menu
obmenu-generator -p -i

# create ~/.config/openbox/autostart

cat <<EOF > ~/.config/openbox/autostart
sleep 1 && /usr/bin/vmware-user &
sleep 1 && pipewire &
sleep 1 && wireplumber &
sleep 1 && pipewire-pulse &
sleep 1 
sleep 1 && polybar &
sleep 1 && picom &
EOF


# 1. Generate a new UUID and populate the machine-id file
sudo dbus-uuidgen --ensure=/etc/machine-id

# 2. Ensure the D-Bus library can also find it in its standard location
sudo ln -sf /etc/machine-id /var/lib/dbus/machine-id


# install Jetbrains Mono and some other fonts,  used in kitty
sudo xbps-install -Sy font-firacode font-iosevka font-awesome nerd-fonts-ttf

echo install JetbrainsMono fonts
# sudo mkdir -p /usr/local/share/fonts/JetbrainsMono/
mkdir -p ~/.local/share/fonts/JetbrainsMono/
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
unzip JetBrainsMono-2.304.zip -d /tmp/jetbrains-mono
sleep 1
mv /tmp/jetbrains-mono/fonts/ttf/* ~/.local/share/fonts/JetbrainsMono/.
rm -f ~/dotfiles/JetBrainsMono-2.304.zip
rm -f /tmp/jetbrains-mono


# re-generate font-cache
fc-cache -f -v

sleep 5

# install fish shel
./fish/install.sh
sleep 1

#openbox bibita cursor
./bibita-cursor.sh
sleep 1

# copy dot files to homedir
cp -Rv ~/dotfiles/dot_home/.* ~/.
sleep 1

cd ~/dotfiles
cd pywal16
./install_pyw16.sh
sleep 3

cd ..

# installation of zsh
# big thanks this for Dreams of Automony
# https://github.com/dreamsofautonomy/zensh/blob/main/.zshrc
# sudo xbps-install -Sy zsh fzf zoxide




echo
echo " end of the installation script, "cp -R ~/dotfiles/dot_home/.* ~/."  copy the .config files to homedir" "
echo
