#/usr/bin/env bash

latest_version=v2.0.7

mkdir -p ~/.local/share/icons

wget https://github.com/ful1e5/Bibata_Cursor/releases/download/$latest_version/Bibata-Modern-Classic.tar.xz
wget https://github.com/ful1e5/Bibata_Cursor/releases/download/$latest_version/Bibata-Modern-Ice-Right.tar.xz


tar -xvf Bibata-Modern-Classic.tar.xz
sleep 2                # extract `Bibata.tar.gz`
tar -xvf Bibata-Modern-Ice-Right.tar.xz
sleep 2
mv Bibata-Modern-Classic/ ~/.local/share/icons/
mv Bibata-Modern-Ice-Right/ ~/.local/share/icons/   # Install to local users

rm -rf Bibata-Modern-*.tar.xz
