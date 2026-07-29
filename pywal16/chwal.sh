#/bin/bash
wal -i $1 -n && feh --bg-scale "$(< "${HOME}/.cache/wal/wal")"
openbox --reconfigure
