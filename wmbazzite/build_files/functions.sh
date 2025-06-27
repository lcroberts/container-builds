#!/usr/bin/env bash

install-cosmic() {
    dnf5 copr enable -y ryanabx/cosmic-epoch
    dnf5 install -y cosmic-desktop
}

install-hyprland() {
    dnf5 copr enable -y solopasha/hyprland
    dnf5 install -y \
        hyprland \
        xdg-desktop-portal-hyprland \
        hyprland-contrib \
        hyprland-qtutils \
        hyprpicker \
        hyprlock \
        hypridle \
        hyprpaper \
        hyprpolkitagent \
        hyprsunset \
        hyprshot \
        rofi-wayland \
        waybar \
        SwayNotificationCenter \
        network-manager-applet \
        wl-clipboard \
        brightnessctl \
        playerctl \
        kanshi \
        pavucontrol \
        blueman
}

install-kmonad() {
    curl -Lo /usr/bin/kmonad https://github.com/kmonad/kmonad/releases/latest/download/kmonad
    chmod +x /usr/bin/kmonad
}

install-vscode() {
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" >/etc/yum.repos.d/vscode.repo
    dnf5 --idempotent install -y code
}

install-docker() {
    curl -Lo /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/fedora/docker-ce.repo
    dnf5 install -y \
        docker-ce \
        docker-ce-cli \
        docker-buildx-plugin \
        docker-compose-plugin \
        containerd.io
}

install-fonts() {
    dnf5 install -y \
        liberation-fonts \
        adobe-source-han-sans-jp-fonts \
        adobe-source-han-serif-jp-fonts \
        mozilla-fira-mono-fonts \
        powerline-fonts \
        jetbrains-mono-fonts-all \
        google-droid-sans-mono-fonts

    for font in "Ubuntu" "JetBrainsMono" "FiraCode" "Iosevka" "NerdFontsSymbolsOnly"; do
        mkdir -p /tmp/fonts/
        curl -Lo /tmp/fonts/"${font}.zip" http://github.com/ryanoasis/nerd-fonts/releases/latest/download/"${font}".zip
        mkdir -p /usr/share/fonts/"${font}"
        unzip /tmp/fonts/"${font}.zip" -d /usr/share/fonts/"${font}"
    done
    rm -r /tmp/fonts
}
