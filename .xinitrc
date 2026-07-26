# Vraag het exacte pad van de Documents map op via xdg-user-dir
DOCS_DIR=$(xdg-user-dir DOCUMENTS)

# Controleer of de map NIET bestaat
if [ ! -d "$DOCS_DIR" ]; then
    echo "De map Documents bestaat niet op het pad: $DOCS_DIR"
    echo "Mappen aanmaken/herstellen via xdg-user-dirs-update..."
    
    # Herstel de standaard XDG mappen van de gebruiker
    xdg-user-dirs-update
else
    echo "De map Documents bestaat al op: $DOCS_DIR"
fi



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
