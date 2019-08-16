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

