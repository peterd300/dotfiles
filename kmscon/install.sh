!#/usr/env bash

# install kmscon on TTY2


#remove agetty on tty2
sudo sv down agetty-tty2
sudo rm /var/service/agetty-tty2
sleep 2

sudo xbps-install -S kmscon pango
sudo xbps-install -S seatd
sudo ln -s /etc/sv/seatd /var/service/
sudo sv start seatd



sudo mkdir -p /etc/sv/kmsconvt-tty2
sudo tee /etc/sv/kmsconvt-tty2/run << 'EOF'
#!/bin/sh
exec kmscon --vt=2 --seat=seat0 --login -- /bin/login
EOF

sudo chmod +x /etc/sv/kmsconvt-tty2/run

#
# create config file
#
sudo mkdir -p /etc/kmscon
sudo tee /etc/kmscon/kmscon.conf << 'EOF'
# /etc/kmscon/kmscon.conf

# Font settings

font-engine=pango
# font-name= JetBrains Mono
font-name=DejaVu Sans Mono
font-size=16

# Terminal palette (options: default, linux, solarized, solarized-black, solarized-white)
palette=linux

# Keyboard layout (xkb)
xkb-layout=us
# xkb-variant=
# xkb-options=

# Render backend: pixman (software, safe default) or gltex (GPU-accelerated)
render-engine=pixman

# Enable hardware acceleration for DRM if you want it (needs gltex)
#hwaccel
EOF



#
#enable service
#
sudo ln -s /etc/sv/kmsconvt-tty2 /var/service/

