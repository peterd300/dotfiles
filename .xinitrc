
sleep 1 && vmware-user &
xrandr --output Virtual-1 --mode 1920x1080
xrdb merge ~/.Xresources 
xbacklight -set 10 &
xset r rate 200 30 &



sleep 1 && pipewire & 
sleep 1 && wireplumber & 
sleep 1 && pipewire-pulse & 
xscreensaver --no-splash &
kitty&
exec openbox-session
# exec twm
