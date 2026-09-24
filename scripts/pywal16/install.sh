#!/usr/bin/env bash

source ~/.bashrc

config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
cache_dir="${XDG_CACHE_DIR:-$HOME/.cache}"

# 1. Maak de template map aan en kopieer het sjabloon
mkdir -p "$config_dir/wal/templates"
cp themerc "$config_dir/wal/templates/themerc"

# 2. Genereer de kleuren (dit maakt het bestand aan in $cache_dir/wal/themerc)
wal -nqi "$(cat "$cache_dir/wal/wal")"

# 3. Kopieer de Openbox thema map
mkdir -p "$HOME/.local/share/themes"
cp -Rv Walbox "$HOME/.local/share/themes/."

# 4. Verwijder een eventuele oude symlink of bestand om fouten te voorkomen
rm -f "$HOME/.local/share/themes/Walbox/openbox-3/themerc"

# 5. Maak de juiste symlink naar het gegenereerde cache-bestand
ln --symbolic "$cache_dir/wal/themerc" "$HOME/.local/share/themes/Walbox/openbox-3/themerc"
