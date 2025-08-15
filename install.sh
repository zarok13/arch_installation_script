#!/bin/bash


# Author: zarok13
# Date: 11/08/2025
# Dependencies: git, aur
# Vars
config="$HOME/.config"
dotfiles="https://github.com/zarok13/dotfiles.git"
flatpaks="./flatpaks.txt"
packages="./packages.txt"
aur_packages="./aur_packages.txt"
yay_repo="https://aur.archlinux.org/yay.git"

mkdir -p $HOME/{Download,Documents,Pictures,Music,Templates,Videos}

#Install yay helper
if ! pacman -Q yay &> /dev/null; then
    git clone "$yay_repo"
    cd yay
    makepkg -si
fi


mkdir -p $HOME/{Download,Documents,Pictures,Music,Templates,Videos}

#Install yay helper
if ! pacman -Q yay &> /dev/null; then
    git clone "$yay_repo"
    cd yay
    makepkg -si
fi

#add flatpak repository
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#Pacman
sudo pacman -S --noconfirm --needed $(< "$packages")

#Aur
yay -S $(< "$aur_packages")

#Flatpak
sudo flatpak install -y $(< "$flatpaks")

#Dotfiles setup
cd
git clone "$dotfiles"
cd dotfiles
cp -r $HOME/dotfiles/* $config
