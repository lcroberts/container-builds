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
    # Provide missing xorg-x11-server-Xwayland(x86-64) capability for terra-xorg-x11-server-Xwayland
    if rpm -q terra-xorg-x11-server-Xwayland >/dev/null 2>&1; then
        XWAYLAND_VER=$(rpm -q --queryformat '%{VERSION}-%{RELEASE}' terra-xorg-x11-server-Xwayland)
        dnf5 install -y rpm-build
        mkdir -p /tmp/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
        cat <<EOF > /tmp/rpmbuild/SPECS/xwayland-compat.spec
Name: xwayland-compat
Version: 1.0
Release: 1
Summary: Compatibility provide for xorg-x11-server-Xwayland(x86-64)
License: MIT
BuildArch: x86_64
Provides: xorg-x11-server-Xwayland(x86-64) = ${XWAYLAND_VER}
Provides: xorg-x11-server-Xwayland(x86-64)

%description
Virtual compatibility package satisfying xorg-x11-server-Xwayland(x86-64) using installed terra-xorg-x11-server-Xwayland.

%prep
%build
%install
%files
EOF
        rpmbuild --define "_topdir /tmp/rpmbuild" -bb /tmp/rpmbuild/SPECS/xwayland-compat.spec
        dnf5 install -y /tmp/rpmbuild/RPMS/x86_64/xwayland-compat-1.0-1.x86_64.rpm
        dnf5 remove -y rpm-build
        rm -rf /tmp/rpmbuild
    fi

    # Hyprland stuff
    dnf5 copr enable -y lionheartp/Hyprland
    dnf5 install -y \
        hyprland \
        xdg-desktop-portal-hyprland \
        hyprland-contrib \
        hyprland-guiutils \
        network-manager-applet \
        wl-clipboard \
        brightnessctl \
        playerctl \
        pavucontrol \
        blueman
    dnf5 copr disable -y lionheartp/Hyprland

    # Dank Material Shell Stuff
    dnf5 copr enable -y avengemedia/dms
    dnf5 copr enable -y avengemedia/danklinux
    dnf5 install -y \
        quickshell \
        dms \
        dgop \
        dms-greeter \
        danksearch \
        ghostty \
        matugen
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
        google-droid-sans-mono-fonts \
        rsms-inter-fonts \
        rsms-inter-vf-fonts

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
