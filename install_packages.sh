#!/bin/bash
# This script installs all my packages.

packages="
clipmenu
compton
cronie
cups
dunst
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
xf86-input-synaptics
ranger
redshift
rofi
pulseaudio
termite
thunderbird
tmux
ttf-dejavu
vim
wget
xclip
xdotool
xorg-server
xorg-xinit
zsh"

aur_packages="
polybar
dropbox"

# install packages from the main repos
for p in $packages; do
    echo "Installing $p ..."
    sudo pacman --noconfirm -S $p > /dev/null
done

# install trizen (AUR helper)
if ! hash trizen; then
    echo "Installing trizen ..."
    cd /tmp
    rm -rf trizen
    git clone https://aur.archlinux.org/trizen.git > /dev/null
    cd trizen
    makepkg -si > /dev/null
fi

# install packages from AUR
for p in $aur_packages; do
    echo "Installing $p from AUR ..."
    trizen --noconfirm -S $p > /dev/null
done

# install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing oh-my-zsh ..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# install spacemacs
if [ ! -f ~/.emacs.d/spacemacs.mk ]; then
    echo "Installing spacemacs ..."
    rm -rf ~/.emacs.d.bak
    mv ~/.emacs.d ~/.emacs.d.bak
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

# dotfiles
cd
if [ ! -d dotfiles ]; then
    git clone --recurse-submodules https://github.com/jojokitten/dotfiles.git dotfiles
fi
echo "Installing dotfiles"
cd dotfiles
./install_requirements.sh
./dotdrop.sh install -p laptop-i3

# xmouseless
if ! hash xmouseless; then
    cd /tmp
    git clone https://github.com/jojokitten/xmouseless.git
    cd xmouseless && make && sudo make install
fi

# entr
if ! hash entr; then
    cd /tmp
    wget http://eradman.com/entrproject/code/entr-4.1.tar.gz
    tar -xf entr-4.1.tar.gz
    cd eradman-entr-* && ./configure && make test && sudo make install
fi

echo "Done!"

