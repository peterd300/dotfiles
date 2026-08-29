#/usr/bin/env bash
# look at https://github.com/ryanoasis/nerd-fonts#patched-fonts

mkfonts -p ./fonts
cd ./fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Iosevka.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/IosevkaTerm.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip

unzip ./Hack.zip -d ./Hack
unzip ./FiraCode.zip -d ./FiraCode
unzip ./FiraMono.zip -d ./FiraMono
unzip ./Iosevka.zip -d ./Iosevka
unzip ./IosevkaTerm.zip -d ./IosevkaTerm
unzip ./JetBrainsMono.zip -d ./JetBrainsNerdMono
unzip ./JetBrainsMono-2.304.zip -d ./JetbBrainsMono




mkdir -p ~/.local/share/fonts/{HackNerd,FiraCode,FiraMono,Iosevka,IosevkaTerm,JetBrainsNerdMono,JetBrainsMono}

mv ./Hack/*.ttf  ~/.local/share/fonts/HackNerd
mv ./FiraCode/*.ttf  ~/.local/share/fonts/FiraCode
mv ./FiraMono/*.ttf  ~/.local/share/fonts/FiraMono
mv ./Iosevka/*.ttf  ~/.local/share/fonts/Iosevka
mv ./IosevkaTerm/*.ttf  ~/.local/share/fonts/IosevkaTerm
mv ./JetBrainsNerdMono/*.ttf  ~/.local/share/fonts/JetBrainsNerdMono
mv ./JetRrainsMono/fonts/ttf/*.ttf ~/.local/share/fonts/JetbrainsMono


fc-cache -f -v
cd ..
rm -rf ./fonts/

