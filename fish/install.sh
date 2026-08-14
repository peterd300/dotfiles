#!/usr/bin/env bash


sudo xbps-install -Suy

sudo xbps-install -Sy fish-shell exa fd fzf starship fd zoxide


mkdir -p ~/.config/fish/functions

# cp prompt function to config dir
cp ./fish_prompt.fish ~/.config/fish/functions/
cp ./config.fish ~/.config/fish/.
