#!/bin/bash
# This script installs all my packages.

packages="
breath-dark-icon-theme
clipmenu
compton
cronie
cups
dunst
emacs
figlet
firefox
fish
git
i3-gaps
lxappearance
menda-themes-dark
morc_menu
mpv
networkmanager
network-manager-applet
openssh
openvpn
pcmanfm
pulseaudio
python
python-pip
xf86-input-synaptics
ranger
redshift
rofi
sxiv
system-config-printer
termite
thunderbird
tmux
translate-shell
trizen
ttf-dejavu
ttf-font-awesome
adobe-source-code-pro-fonts
vim
wget
xarchiver
xclip
xdotool
xorg-xbacklight
xorg-server
xorg-xprop
xorg-xinit
xorg-xinput
xorg-xev
zip
unzip
"

aur_packages="
polybar
dropbox"

# install packages from the main repos
for p in $packages; do
    echo "Installing $p ..."
    sudo pacman --needed --noconfirm -S $p > /dev/null
done

# install packages from AUR
for p in $aur_packages; do
    echo "Installing $p from AUR ..."
    trizen --needed --noconfirm --sudo-autorepeat -S $p > /dev/null
done

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
./dotdrop.sh install -f -p laptop-i3

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
