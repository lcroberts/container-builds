#!/usr/bin/env bash

install-cosmic() {
    curl -Lo /etc/yum.repos.d/_copr_ryanabx-cosmic.repo https://copr.fedorainfracloud.org/coprs/ryanabx/cosmic-epoch/repo/fedora-"${RELEASE}"/ryanabx-cosmic-epoch-fedora-"${RELEASE}".repo
    rpm-ostree --idempotent install cosmic-desktop
}

install-hyprland() {
    curl -Lo /etc/yum.repos.d/_copr_solopasha-hypr.repo https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/repo/fedora-"${RELEASE}"/solopasha-hyprland-fedora-"${RELEASE}".repo
    rpm-ostree --idempotent install \
        hyprland \
        hyprland-contrib \
        hyprpicker \
        hyprlock \
        hypridle \
        hyprpaper \
        hyprpolkitagent \
        hyprsunset \
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
    rpm-ostree --idempotent install code
}

install-docker() {
    curl -Lo /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/fedora/docker-ce.repo
    rpm-ostree --idempotent install \
        docker-ce \
        docker-ce-cli \
        docker-buildx-plugin \
        docker-compose-plugin \
        containerd.io
}

install-fonts() {
    rpm-ostree --idempotent install \
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
