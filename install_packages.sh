#!/bin/bash
# This script installs all my packages and configs on arch.

packages="
bash-completion
breath-dark-icon-theme
clipmenu
cmake
compton
cronie
cups
dunst
feh
figlet
firefox
fzf
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
ranger
redshift
scrot
stalonetray
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
neovim
wget
xarchiver
xautolock
xclip
xdotool
xorg-drivers
xorg-server
xorg-xbacklight
xorg-xprop
xorg-xinit
xorg-xinput
xorg-xev
zathura
zathura-pdf-poppler
zip
unzip
"

aur_packages="
polybar
dropbox
xnee"

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

# dotfiles
cd
if [ ! -d dotfiles ]; then
    git clone --recurse-submodules https://github.com/jojokitten/dotfiles.git dotfiles
fi
echo "Installing dotfiles"
cd dotfiles
./install_requirements.sh
./dotdrop.sh install -f -p laptop-i3

# Vundle (vim plugin manager)
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

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

# python support for neovim
sudo pip install neovim

echo "Done!
Things that have to be done manually:
 - install vim plugins
 - set git user name and email globally
 - sync firefox
 - set up thunderbird
 - set up dropbox"

