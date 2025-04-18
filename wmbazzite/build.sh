#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"
export RELEASE

. /tmp/scripts/wmbazzite-functions.sh

### Install packages

# this installs a package from fedora repos
rpm-ostree --idempotent install \
    firewall-config \
    virt-manager \
    adobe-source-han-sans-jp-fonts \
    adobe-source-han-serif-jp-fonts \
    mozilla-fira-mono-fonts \
    powerline-fonts \
    jetbrains-mono-fonts-all \
    google-droid-sans-mono-fonts \
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
    fish \
    neovim \
    eza \
    fd-find \
    ripgrep \
    zoxide \
    trash-cli \
    tmux \
    iotop \
    tokei \
    tealdeer \
    yq \
    stow \
    piper

install-hyprland
install-docker
# install-cosmic
install-kmonad
install-vscode

# Example for enabling a System Unit File
systemctl enable podman.socket
systemctl disable btrfs-dedup@var-home.timer

update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/kitty 50
update-alternatives --set x-terminal-emulator /usr/bin/kitty
