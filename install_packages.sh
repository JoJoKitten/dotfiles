#!/bin/bash
# This script installs all my packages.

packages="
compton
cronie
cups
emacs
feh
firefox
git
i3-gaps
networkmanager
network-manager-applet
pcmanfm
python
python-pip
ranger
rofi
termite
thunderbird
tmux
ttf-dejavu
vim
xorg-server
xorg-xinit
zsh"

yaourt_packages="
polybar
megasync"

# install git (which is used to install trizen)
echo "Installing git ..."
pacman --noconfirm -S git &> /dev/null

# install trizen (AUR helper) first because it needs the user
# to enter the password once
echo "Installing trizen ..."
rm -rf /tmp/trizen
sudo -u jbensmann git clone https://aur.archlinux.org/trizen.git /tmp/trizen &> /dev/null
cd /tmp/trizen
sudo -u jbensmann makepkg -si --noconfirm &> /dev/null

# install packages from the main repos
for p in $packages; do
    echo "Installing $p ..."
    pacman --noconfirm -S $p &> /dev/null
done

# install packages from AUR
for p in $yaourt_packages; do
    echo "Installing $p from AUR ..."
    trizen --noconfirm -S $p &> /dev/null
done

# install oh-my-zsh
echo "Installing oh-my-zsh ..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install spacemacs
echo "Installing spacemacs ..."
rm -r ~/.emacs.d
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# dotfiles
echo "Installing dotfiles"
git clone --recurse-submodules https://github.com/jojokitten/dotfiles.git ~/dotfiles
cd ~/dotfiles
~/dotfiles/install_requirements.sh
~/dotfiles/dotdrop.sh install -p laptop-i3

echo "Done!"

