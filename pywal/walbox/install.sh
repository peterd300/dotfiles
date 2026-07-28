#!/bin/bash

config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
cache_dir="${XDG_CACHE_DIR:-$HOME/.cache}"

#create first wallpaper because creating directories in .config and .cache
wal -i ~/.wallpaper/blue-mountains.jpg
sleep 1


# 1. Create the template directory and copy the template
mkdir -p "$config_dir/wal/templates"
cp themerc "$config_dir/wal/templates/themerc"

# 2. Generate the colors (this creates the file in $cache_dir/wal/themerc)
wal -nqi "$(cat "$cache_dir/wal/wal")"

# 3. Copy the Openbox theme directory
mkdir -p "$HOME/.themes"
cp -r Walbox "$HOME/.themes/Walbox"

# 4. Remove any existing symlink or file to prevent errors
rm -f "$HOME/.themes/Walbox/openbox-3/themerc"

# 5. Create the correct symlink to the generated cache file
ln --symbolic "$cache_dir/wal/themerc" "$HOME/.themes/Walbox/openbox-3/themerc"

# copy config files 
cp -Rv ~/dotfiles/pywal/.config/* ~/.config 
