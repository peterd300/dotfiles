#/bin/bash
wal -i $1 -n && feh --bg-scale "$(< "${HOME}/.cache/wal/wal")"
openbox --reconfigure


# Custom 16-color wallpaper changer for Openbox, add this function to .bashrc
#
# wal16() {
#     wal -n -i "$1" && feh --bg-scale "$(< "${HOME}/.cache/wal/wal")"
# }
# example : wal16 wallpaper.jpg
