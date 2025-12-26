#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"
export RELEASE

# Fix the os-release so that isos can be built
# https://github.com/ublue-os/image-template/issues/99
sed -i 's/ID=bazzite/ID=fedora/g' /etc/os-release 

. /ctx/functions.sh

dnf5 copr enable -y lcroberts/WMBazzite

uninstall-plasma

install-cosmic
systemctl enable cosmic-greeter

### Install packages

# GUI/Input/Theming Stuff
dnf5 install -y \
    firewall-config \
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

dnf5 install -y https://cdn.filen.io/@filen/desktop/release/latest/Filen_linux_x86_64.rpm

# CLI Stuff
dnf5 install -y \
    nodejs \
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
    yq \
    lazygit

# Misc Stuff
install-fonts
install-kmonad
install-yazi

# Desktops
install-hyprland

# Example for enabling a System Unit File
systemctl enable podman.socket
systemctl disable btrfs-dedup@var-home.timer
