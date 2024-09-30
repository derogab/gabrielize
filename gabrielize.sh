#! /bin/bash

### UTILS ###
# Add lines to a file
# Usage: add_lines_to_file /path/to/file lines_to_add
add_lines_to_file() {
  local file="$1"
  local lines="$2"
  local added_lines=""

  if [ -f "$file" ]; then
    while IFS= read -r line; do
      line=$(echo "$line" | sed 's/^\s*#\s*//')  # Remove leading '#' and whitespace
      if ! grep -Fq "$line" "$file"; then
        echo "$line" >> "$file"
        added_lines="${added_lines}\n$line"
      fi
    done <<< "$lines"
  else
    echo "File $file not found."
  fi
}

### GABRIELIZE ###
## Install, update & configure

# Permissions
# Check if the script is run as root.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root. Please use sudo or log in as the root user."
  exit 1
fi

# Home
# Ask the user the main user home folder.
echo -n "Enter home folder (ex. /home/user): " 
read USER_HOME
USER_HOME=$(realpath -s "$USER_HOME")
if [ ! -d "$USER_HOME" ]; then
  echo "$USER_HOME does not exist. Insert the correct home folder."
  exit 1
fi

# Wallpaper
# Set a wonderful custom wallpaper.
# https://gitlab.manjaro.org/artwork/wallpapers/wallpapers-2018/raw/master/nature-3058859.jpg
wget -q -O $USER_HOME/.wallpaper.jpg https://gitlab.manjaro.org/artwork/wallpapers/wallpapers-2018/raw/master/nature-3058859.jpg
if [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]] || [[ "$DESKTOP_SESSION" == "gnome" ]]; then
  echo "Setting up the wallpaper for GNOME."
  gsettings set org.gnome.desktop.background picture-uri "file://$USER_HOME/.wallpaper.jpg" >/dev/null 2>&1
  gsettings set org.gnome.desktop.background picture-uri-dark "file://$USER_HOME/.wallpaper.jpg" >/dev/null 2>&1
fi

# BASH
# Add personal BASH data to BASHRC.
echo "Setup customized BASH data."
personal_bash_data='if [ -f ~/.bash_derogab ]; then . ~/.bash_derogab; fi # Gabrielize: plug-in from @derogab'
add_lines_to_file $USER_HOME/.bashrc "$personal_bash_data"

# SBIN
# Add SBIN to PATH.
echo "Adding sbin folder in PATH."
add_lines_to_file /root/.bashrc 'export PATH=$PATH:/usr/sbin # Gabrielize: add sbin to PATH'

# Remove games
# Remove all games installed by GNOME.
echo "Removing all games."
apt purge -y gnome-games >/dev/null 2>&1

# Update
# Update all packages.
echo "Updating all packages."
apt update >/dev/null 2>&1
apt upgrade -y >/dev/null 2>&1
apt autoremove -y >/dev/null 2>&1

# NodeJS & NPM
# Evented I/O for V8 javascript / npm is the world's largest software registry.
# https://nodejs.org/en / https://github.com/nvm-sh/nvm
echo "Installing Node Version Manager (NVM)."
curl -so- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash >/dev/null 2>&1
source ~/.bashrc
echo "Installing Node."
nvm install 20 >/dev/null 2>&1
nvm use 20

# Podman
# Podman is an open source Open Container Initiative-compliant container management tool from Red Hat used for 
# handling containers, images, volumes, and pods on the Linux operating system.
# https://podman.io
echo "Installing Podman."
apt install -y podman >/dev/null 2>&1

# Flatpak
# Flatpak is a utility for software deployment and package management for Linux.
# https://www.flatpak.org/setup/Debian / https://www.flatpak.org
echo "Installing Flatpak."
apt install -y flatpak gnome-software-plugin-flatpak >/dev/null 2>&1
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo >/dev/null 2>&1

# Telegram
# Telegram is a cloud-based mobile and desktop messaging app with a focus on security and speed.
# https://www.archlinux.org/packages/community/x86_64/telegram-desktop / https://desktop.telegram.org
echo "Installing Telegram Desktop."
flatpak install -y flathub org.telegram.desktop >/dev/null 2>&1

# Thunderbird
# Standalone mail and news reader from mozilla.org.
# https://www.thunderbird.net
echo "Installing Thunderbird."
apt install -y thunderbird >/dev/null 2>&1

# Security setup by Turtlecute
# It's a script for automatically hardening your linux system.
echo "Running hardening script by Turtlecute."
wget -q https://raw.githubusercontent.com/Turtlecute33/Hardening-linux-script/f959c1f988f7cc0af87db124dcbb3875b71e3462/hardening-script.sh -O /tmp/hardening-script.sh
chmod +x /tmp/hardening-script.sh
/tmp/hardening-script.sh
