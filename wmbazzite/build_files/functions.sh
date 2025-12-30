#!/usr/bin/env bash

uninstall-plasma() {
    dnf5 remove -y plasma-desktop \
        kde-settings-plasma \
        kdeplasma-addons \
        libplasma \
        plasma-activities \
        plasma-activities-stats \
        plasma-breeze \
        plasma-breeze-common \
        plasma-breeze-qt5 \
        plasma-breeze-qt6 \
        plasma-browser-integration \
        plasma-desktop \
        plasma-desktop-doc \
        plasma-discover-libs \
        plasma-disks \
        plasma-integration \
        plasma-integration-qt5 \
        plasma-lookandfeel-fedora \
        plasma-milou \
        plasma-nm \
        plasma-nm-openconnect \
        plasma-nm-openvpn \
        plasma-nm-vpnc \
        plasma-pa \
        plasma-print-manager \
        plasma-print-manager-libs \
        plasma-systemmonitor \
        plasma-systemsettings \
        plasma-thunderbolt \
        plasma-vault \
        plasma-workspace \
        plasma-workspace-common \
        plasma-workspace-libs \
        plasma-workspace-wallpapers \
        plasma5support \
        sddm-wayland-plasma \
        colord-kde \
        f43-backgrounds-kde \
        fedora-chromium-config-kde \
        kde-cli-tools \
        kde-connect \
        kde-connect-libs \
        kde-filesystem \
        kde-gtk-config \
        kde-inotify-survey \
        kde-settings \
        kde-settings-plasma \
        kde-settings-pulseaudio \
        kde-settings-sddm \
        kdebugsettings \
        kdeconnectd \
        kdecoration \
        kdegraphics-mobipocket \
        kdegraphics-thumbnailers \
        kdenetwork-filesharing \
        kdeplasma-addons \
        kdesu \
        polkit-kde \
        steamdeck-kde-presets \
        xdg-desktop-portal-kde
}

install-cosmic() {
    dnf5 copr enable -y ryanabx/cosmic-epoch
    dnf5 install -y cosmic-desktop
}

install-hyprland() {
    dnf5 copr enable -y solopasha/hyprland
    dnf5 copr enable -y avengemedia/dms
    dnf5 copr enable -y avengemedia/danklinux
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

    # Dank Material Shell Stuff
    dnf5 install -y \
        quickshell \
        dms \
        dgop \
        cliphist \
        dms-greeter \
        danksearch \
        ghostty \
        matugen

    dnf5 copr disable -y solopasha/hyprland
    dnf5 copr disable -y avengemedia/dms
    dnf5 copr disable -y avengemedia/danklinux
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

install-yazi() {
    dnf5 install -y \
        yazi \
        poppler \
        ImageMagick
}
