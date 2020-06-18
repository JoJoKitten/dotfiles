#!/bin/bash
# This script installs all my packages and configs on arch.

packages="
bash-completion
breath-dark-icon-theme
clipmenu
cmake
cronie
cups
dnsutils
dunst
exa
fd
feh
figlet
firefox
fzf
git
gnuplot
gpick
ttf-jetbrains-mono
jq
lxappearance
menda-themes-dark
mlocate
morc_menu
mpv
networkmanager
network-manager-applet
openssh
openvpn
pamixer
pcmanfm
picom
pulseaudio
pulsemixer
pwgen
python
python-pip
redshift
scrot
shellcheck
stalonetray
sxhkd
sxiv
system-config-printer
task
termite
thunderbird
tmux
translate-shell
trizen
ttf-dejavu
ttf-font-awesome
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
zsh
zsh-syntax-highlighting
"

aur_packages="
dropbox
libxft-bgra
linopen
lf-bin
sc-im
tdrop-git
xmouseless-git
xnee"

# install packages from the main repos
for p in $packages; do
    echo "Installing $p ..."
    sudo pacman --needed --noconfirm -S "$p" > /dev/null
done

# install packages from AUR
for p in $aur_packages; do
    echo "Installing $p from AUR ..."
    trizen --needed --noconfirm --sudo-autorepeat -S "$p" > /dev/null
done

# dotfiles
cd
if [ ! -d dotfiles ]; then
    git clone --recurse-submodules https://github.com/jbensmann/dotfiles.git dotfiles
fi
echo "Installing dotfiles"
cd dotfiles
./install_requirements.sh
./dotdrop.sh install -f

# vim-plug
if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# cht.sh
curl https://cht.sh/:cht.sh > /tmp/cht.sh
sudo cp /tmp/cht.sh /usr/local/bin/cht.sh
sudo chmod +x /usr/local/bin/cht.sh

# python support for neovim
sudo pip install neovim

echo "Done."
