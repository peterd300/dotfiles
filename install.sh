#!/usr/bin/env bash

# Define the log file and clear it out at startup
LOG_FILE="$HOME/log/install.log"
mkdir -p "$HOME/log"

> "$LOG_FILE"
# Cache sudo credentials upfront so password prompts don't get hidden inside logs
echo "Please enter your sudo password to begin the installation:"
sudo -v

# Keep-alive: update user's sudo timestamp until the script finishes
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "============================================================================="
echo " Starting Void Linux & Openbox Installer "
echo "============================================================================="

echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[1/15] Syncing repositories & preparing detection tools..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1

(
    sudo xbps-install -Suy
    sudo xbps-install -Sy virt-what
) >> "$LOG_FILE" 2>&1
sleep 2

# Hypervisor detection
VIRT_TYPE=$(sudo virt-what)

if [ "$VIRT_TYPE" = "vmware" ]; then

		echo "========================================================================================================" >> "$LOG_FILE" 2>&1
		echo "[2/15] VMware detected! Installing VMware Tools..." | tee -a "$LOG_FILE"
		echo "========================================================================================================" >> "$LOG_FILE" 2>&1

    (
        sudo xbps-install -Sy open-vm-tools mesa-vaapi mesa-vmwgfx-dri
        sudo ln -s /etc/sv/vmware-vmblock-fuse /var/service/
        sudo ln -s /etc/sv/vmtoolsd /var/service/
        sudo sv up vmtoolsd
        sudo sv up vmware-vmblock-fuse
        if [ -d "/etc/xdg/autostart" ]; then
            sudo cp /etc/xdg/autostart/vmware-user.desktop /etc/xdg/autostart/ 2>/dev/null
        fi
    ) >> "$LOG_FILE" 2>&1
else
    echo "========================================================================================================" >> "$LOG_FILE" 2>&1
    echo "[2/15] Virtual environment is: '${VIRT_TYPE:-bare-metal}'. Skipping VMware Tools."
    echo "========================================================================================================" >> "$LOG_FILE" 2>&1

fi

sleep 5


echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[3/15] Installing core CLI utilities..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1
(
	# install some bash utils
    sudo xbps-install -Sy tree multitail bash-completion fastfetch trash-cli
	sudo xbps-install -Sy delta htop btop make micro git wget xz zip unzip nano cmake curl gcc net-tools gping ncdu tree mlocate glow jq
) >> "$LOG_FILE" 2>&1
sleep 2

echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[4.1/15] Installing Xorg server ..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1
sudo xbps-install -Sy xorg xorg-server xorg-apps xrandr xterm xscreensaver twm xinit xsel xclip xcolor >> "$LOG_FILE" 2>&1

echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[4.2/15] Installing X11 apps  ..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1
sudo xbps-install -Sy gpick CopyQ zathura zathura-cb zathura-pdf-mupdf octoxbps >> "$LOG_FILE" 2>&1


echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[4.3/15] Installing Openbox window manager..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1
(
    sudo xbps-install -Sy openbox obconf obmenu-generator obconf-qt lxappearance lxappearance-obconf nwg-look
    mkdir -p ~/.config/openbox
    mkdir -p ~/.local
    cp /etc/xdg/openbox/rc.xml ~/.config/openbox/
    cp /etc/xdg/openbox/autostart ~/.config/openbox/
    cp /etc/xdg/openbox/menu.xml ~/.config/openbox/
) >> "$LOG_FILE" 2>&1
sleep 2


echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[5/15] Creating X11 environment configuration (.xinitrc)..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1

(
    echo "xrandr --output Virtual-1 --mode 1920x1080 " >> ~/.xinitrc
    echo "exec xterm & " >> ~/.xinitrc
    echo "exec openbox-session" >> ~/.xinitrc
    echo "# exec twm" >> ~/.xinitrc
) >> "$LOG_FILE" 2>&1


echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[6/15] Installing polybar ..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1

(
    mkdir -p ~/.config/polybar
    sudo xbps-install -Sy polybar dunst rofi feh xdg-user-dirs xdg-utils xfce4-appfinder
) >> "$LOG_FILE" 2>&1

echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[7/15] Installing and initializing D-Bus & system daemons..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1

(
    sudo xbps-install -Sy dbus elogind dbus-elogind polkit polkit-elogind turnstile
    sudo ln -s /etc/sv/dbus /var/service/
    sudo ln -sf /etc/sv/elogind /var/service/
    sudo ln -sf /etc/sv/polkitd /var/service/
    sudo ln -sf /etc/sv/turnstiled/ /var/service/
    sudo sv up dbus
    sudo sv up turnstiled
    sudo sv up elogind
    sudo dbus-uuidgen --ensure=/etc/machine-id
    sudo ln -sf /etc/machine-id /var/lib/dbus/machine-id
) >> "$LOG_FILE" 2>&1

echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[8.1/15] Installing some X11 applications..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1

(
    sudo xbps-install -Sy adwaita-plus firefox-esr kitty flameshot gmrun xbindkeys xdotool xev gpick
    mkdir -p ~/screenshots
) >> "$LOG_FILE" 2>&1

echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[8.2/15] Installing Thunar, file manager..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1

(
    sudo xbps-install -Sy Thunar thunar-archive-plugin thunar-media-tags-plugin tumbler lximage-qt gvfs xarchiver
 ) >> "$LOG_FILE" 2>&1


echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[8.3/15] Installing icons and themes ..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1

(
    sudo xbps-install -Sy papirus-icon-theme lxde-icon-theme xcursor-themes arc-theme
    ./scripts/install-kora.sh
    
) >> "$LOG_FILE" 2>&1

echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[8.4/15] Installing Geany, text editor..." | tee -a "$LOG_FILE" |
echo "========================================================================================================" >> "$LOG_FILE" 2>&1

(
    sudo xbps-install -Sy geany geany-editorconfig-plugin geany-plugins geany-plugins-extra
) >> "$LOG_FILE" 2>&1


echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[9/15] Setting up Picom compositor..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1

(
    mkdir -p ~/.config/picom
    sudo xbps-install -Sy picom
    cp /usr/share/examples/picom/picom.sample.conf ~/.config/picom/picom.conf
)>> "$LOG_FILE" 2>&1
sleep 2

echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[10/15] Configuring system audio permissions..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1

(
    sudo xbps-install -Sy pipewire alsa-plugins-pulseaudio wireplumber pavucontrol pamixer
    sudo usermod -aG audio,video,input $(whoami)
) >> "$LOG_FILE" 2>&1

echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[11/15] Generating dynamic Openbox menus and autostart profiles..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1
(
    obmenu-generator -p -i
    cat <<EOF > ~/.config/openbox/autostart
sleep 1 && /usr/bin/vmware-user &
sleep 1 && pipewire &
sleep 1 && wireplumber &
sleep 1 && pipewire-pulse &
sleep 1
sleep 1 && polybar &
sleep 1 && picom &
EOF
) >> "$LOG_FILE" 2>&1

echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[12.1/15] Awesome  fonts..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1

(
    sudo xbps-install -Sy font-awesome
    # sudo xbps-install -Sy font-firacode font-iosevka font-awesome
) >> "$LOG_FILE" 2>&1


echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[12.2/15] Installing Jetbrain (Nerd) System and other fonts..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1


(
# comment out fonts, if you don't need or use them

# ./scripts/install-font-firacode.sh
# ./scripts/install-font-firamono.sh
# ./scripts/install-font-hacknerd.sh
./scripts/install-font-iosevka.sh
./scripts/install-font-iosevkaterm.sh
# ./scripts/install-font-jetbrainsmono.sh
./scripts/install-font-jetbrainsnerd-mono.sh


) >> "$LOG_FILE" 2>&1
sleep 2


echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[13/15] Customizing interactive shells (Fish & other components)..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1

(    # install UFW firewall
    ./scripts/install-firewall.sh

     # installing Fish shell
    ./scripts/install-fish.sh

    # installing Bibita cursor
    ./scripts/install-bibita-cursor.sh
) >> "$LOG_FILE" 2>&1

echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[14/15] Deploying customized dotfiles and configuration sets..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1

(
    cp -Rv ~/dotfiles/dot_home/.* ~/.
) >> "$LOG_FILE" 2>&1
sleep 1

echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo "[15/15] Compiling and configuring Pywal themes..." | tee -a "$LOG_FILE"
echo "========================================================================================================" >> "$LOG_FILE" 2>&1

(
    cd ~/dotfiles/scripts/pywal16
    ./install_pyw16.sh
) >> "$LOG_FILE" 2>&1
sleep 2

echo "========================================================================================================" >> "$LOG_FILE" 2>&1
echo " Installation Complete!                  " >> "$LOG_FILE" 2>&1
echo "========================================================================================================" >> "$LOG_FILE" 2>&1

echo "============================================================================="
echo " Installation Complete!                  "
echo " All configuration files copied.         "
echo " Please review '$LOG_FILE' for details.  "
echo "============================================================================="
