#! /bin/bash

### GABRIELIZE ###
## Install, update & configure

# Yay
# Yet Another Yogurt - An AUR Helper Written in Go
# https://github.com/Jguer/yay 
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si

# Update
# Update all packages
yay -Syu --noconfirm

# Plank
# Plank is meant to be the simplest dock on the planet.
# https://github.com/ricotz/plank
yay -S plank --noconfirm
# https://github.com/derogab/dotfiles/tree/master/plank
wget -O ~/.config/autostart/plank.desktop https://raw.githubusercontent.com/derogab/dotfiles/master/plank/plank.desktop

# Wallpaper
# Set a wonderful wallpaper 
# https://gitlab.manjaro.org/artwork/wallpapers/wallpapers-2018/raw/master/nature-3058859.jpg
# and also in /usr/share/backgrounds/wallpapers-2018/
wget -O /tmp/wallpaper.jpg https://gitlab.manjaro.org/artwork/wallpapers/wallpapers-2018/raw/master/nature-3058859.jpg
cp /tmp/wallpaper.jpg $HOME/.wallpaper.jpg
for property in $(xfconf-query -c xfce4-desktop -l | grep "last-image$")
do
    xfconf-query -c xfce4-desktop -p $property -s $HOME/.wallpaper.jpg
done

# Panel
# Set default panel0 position to the upper border
# https://forum.xfce.org/viewtopic.php?pid=26514#p26514
xfconf-query -c xfce4-panel -p /panels/panel-0/position -s "p=11;x=0;y=0"

# Libinput
# Input device management and event handling library
# https://wiki.archlinux.org/index.php/Libinput
yay -S libinput --noconfirm

# NodeJS & NPM
# Evented I/O for V8 javascript / npm is the world's largest software registry
# https://www.archlinux.org/packages/community/x86_64/nodejs / https://nodejs.org
# https://www.archlinux.org/packages/community/any/npm / https://www.npmjs.com
yay -S nodejs npm --noconfirm

# VSCode
# Visual Studio Code is a lightweight but powerful source code editor which runs on your desktop.
# https://aur.archlinux.org/packages/visual-studio-code-bin / https://code.visualstudio.com
yay -S visual-studio-code-bin --noconfirm

# Telegram
# Telegram is a cloud-based mobile and desktop messaging app with a focus on security and speed.
# https://www.archlinux.org/packages/community/x86_64/telegram-desktop / https://desktop.telegram.org
yay -S telegram-desktop --noconfirm

# Thunderbird
# Standalone mail and news reader from mozilla.org
# https://www.thunderbird.net
yay -S thunderbird --noconfirm 