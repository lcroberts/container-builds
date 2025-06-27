#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"
export RELEASE

# Fix the os-release so that isos can be built
# https://github.com/ublue-os/image-template/issues/99
sed -i 's/ID=bazzite/ID=fedora/g' /etc/os-release 

. /ctx/functions.sh

dnf5 copr enable -y lcroberts/WMBazzite

### Install packages

# GUI/Input/Theming Stuff
dnf5 install -y \
    firewall-config \
    virt-manager \
    gtk-murrine-engine \
    kvantum \
    kvantum-qt5 \
    qt6ct \
    qt5ct \
    zathura \
    kitty \
    imv \
    mpv \
    mpv-mpris \
    zathura-plugins-all \
    fcitx5 \
    fcitx5-configtool \
    fcitx5-gtk \
    fcitx5-qt5 \
    fcitx5-mozc \
    piper

# CLI Stuff
dnf5 install -y \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    starship \
    direnv \
    eza \
    neovim \
    fd-find \
    ripgrep \
    zoxide \
    trash-cli \
    tmux \
    iotop \
    tokei \
    tealdeer \
    yq

# Misc Stuff
install-fonts
install-kmonad

# Desktops
install-hyprland
# install-cosmic

# Example for enabling a System Unit File
systemctl enable podman.socket
systemctl disable btrfs-dedup@var-home.timer
