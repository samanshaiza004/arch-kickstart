#!/bin/bash

# Exit if any command fails
set -e

# Log everything
exec > >(tee -i setup.log)
exec 2>&1

# update and upgrade system

sudo pacman -Syu --noconfirm

# install core packages

sudo pacman -S --noconfirm \
	wayland hyprland git neovim vscode \
	foot firefox hyprpaper

# Clone dotfiles repo if it doesn't already exist
if [ ! -d "$HOME/dotfiles" ]; then
    git clone https://github.com/samanshaiza004/dotfiles.git ~/dotfiles
fi


cd ~/dotfiles
chmod +x setup.sh
./setup.sh

# Clone yay if it doesn't already exist
if [ ! -d "yay" ]; then
    git clone https://aur.archlinux.org/yay.git
fi

cd yay
makepkg -si --noconfirm
