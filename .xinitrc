
xrdb merge ~/.Xresources 
xbacklight -set 10 &
xset r rate 200 50 &



sleep 1 && pipewire & 
sleep 1 && wireplumber & 
sleep 1 && pipewire-pulse & 
xscreensaver --no-splash &
xterm&
exec openbox-session
# exec twm
