#!/usr/bin/bash

# install binaries for nvim
sudo xbps-install -Sy neovim shellcheck bash-language-server tree-sitter tree-sitter-bash luarocks-lua54

:' obsolete
# install devel modules for building treesitter-cli
sudo xbps-install -Sy lua54.devel lua53-devel luarocks-lua53 luarocks-lua54


# install tree-sitter-cli v.0.26 via github, in repo v.0.25

mkdir -p $HOME/src
cd $HOME/src
git clone https://github.com/FourierTransformer/tree-sitter-cli.git
pause 1
cd tree-sitter-cli
sudo luarocks install tree-sitter-cli
pause 1
'

# copy config files
cp -r $HOME/dotfiles/scripts/nvim/ $HOME/.config/

