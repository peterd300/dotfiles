#!/usr/bin/env bash


sudo xbps-install -Sy

sudo xbps-install fish-shell


mkdir -p ~/.config/fish/functions

# cp prompt function to config dir
cp ./fish_prompt.fish ~/.config/fish/functions/
