#!/usr/bin/env fish

# Configure my shell's prompt


# Make it easy to switch to commonly-used directories
# zoxide init fish | source
starship init fish | source
fzf --fish | source
zoxide init --cmd cd fish | source


# env vars
set -x VISUAL "geany --wait"
set -x EDITOR "nano --wait"



# Helpful expansions
abbr -a -g gp git push
abbr -a -g gc git commit -asm
abbr -a -g gst git status

# Helpful aliases
command -q exa; and alias la="exa -abghl --git --color=automatic"
command -q exa; and alias ll="exa -bghl --git --color=automatic"

# Fisher!
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end


