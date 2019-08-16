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
yay -Syu

# Plank
# Plank is meant to be the simplest dock on the planet.
# https://github.com/ricotz/plank
yay -S plank

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