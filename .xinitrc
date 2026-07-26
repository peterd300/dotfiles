
# enable copy paste in vm
sleep 1 && vmware-user &

# set resolution in X11
xrandr --output Virtual-1 --mode 1920x1080

# X11 settings
xrdb merge ~/.Xresources 
xbacklight -set 10 &
xset r rate 200 30 &

# enable sound support
sleep 1 && pipewire & 
sleep 1 && wireplumber & 
sleep 1 && pipewire-pulse & 

# enable screensaver
xscreensaver --no-splash &

# open default terminal
kitty&

#start openbox
exec openbox-session
# exec twm
