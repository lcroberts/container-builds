#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"
export RELEASE

. /tmp/scripts/wmbazzite-functions.sh

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
    ghostty \
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
    fish \
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

# Developer Stuff
# install-docker
# install-vscode

# Example for enabling a System Unit File
systemctl enable podman.socket
systemctl disable btrfs-dedup@var-home.timer

update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/kitty 50
update-alternatives --set x-terminal-emulator /usr/bin/kitty
