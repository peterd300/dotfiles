
sleep 1 && vmware-user &
xrdb merge ~/.Xresources 
xbacklight -set 10 &
xset r rate 200 30 &



sleep 1 && pipewire & 
sleep 1 && wireplumber & 
sleep 1 && pipewire-pulse & 
xscreensaver --no-splash &
xterm&
exec openbox-session
# exec twm
