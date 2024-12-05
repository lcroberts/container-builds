#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### Install packages
# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# Add copr repos
curl -Lo /etc/yum.repos.d/_copr_solopasha-hypr.repo https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/repo/fedora-"${RELEASE}"/solopasha-hyprland-fedora-"${RELEASE}".repo
curl -Lo /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/fedora/docker-ce.repo
# VSCode repo
rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" >/etc/yum.repos.d/vscode.repo

# this installs a package from fedora repos
rpm-ostree --idempotent install \
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
    piper \
    code \
    docker-ce \
    docker-ce-cli \
    docker-buildx-plugin \
    docker-compose-plugin \
    containerd.io \
    python3-tkinter

# Hyprland Stuff
rpm-ostree --idempotent install \
    hyprland \
    hyprland-contrib \
    hyprpicker \
    hyprlock \
    hypridle \
    rofi-wayland \
    swww \
    aylurs-gtk-shell \
    network-manager-applet \
    wl-clipboard \
    brightnessctl \
    playerctl \
    kanshi \
    pavucontrol \
    blueman

# Cosmic
# curl -Lo /etc/yum.repos.d/_copr_ryanabx-cosmic.repo https://copr.fedorainfracloud.org/coprs/ryanabx/cosmic-epoch/repo/fedora-"${RELEASE}"/ryanabx-cosmic-epoch-fedora-"${RELEASE}".repo
# rpm-ostree --idempotent install cosmic-desktop

# Example for enabling a System Unit File
systemctl enable podman.socket
systemctl disable btrfs-dedup@var-home.timer

curl -Lo /usr/bin/kmonad https://github.com/kmonad/kmonad/releases/latest/download/kmonad
chmod +x /usr/bin/kmonad
curl -Lo /usr/share/ublue-os/just/60-custom.just https://raw.githubusercontent.com/lcroberts/container-builds/main/wmbazzite/custom.just

update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/kitty 50
update-alternatives --set x-terminal-emulator /usr/bin/kitty
