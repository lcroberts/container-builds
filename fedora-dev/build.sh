#!/usr/bin/env bash

dnf -y upgrade

# Install packages required by Distrobox, this speeds up the first-run time
dnf install -y \
    dnf5 \
    bash-completion \
    bc \
    bzip2 \
    curl \
    diffutils \
    dnf-plugins-core \
    findutils \
    fish \
    glibc-all-langpacks \
    glibc-locale-source \
    gnupg2 \
    gnupg2-smime \
    hostname \
    iproute \
    iputils \
    keyutils \
    krb5-libs \
    less \
    lsof \
    man-db \
    man-pages \
    mtr \
    ncurses \
    nss-mdns \
    openssh-clients \
    pam \
    passwd \
    pigz \
    pinentry \
    procps-ng \
    rsync \
    shadow-utils \
    sudo \
    tcpdump \
    time \
    traceroute \
    tree \
    tzdata \
    unzip \
    util-linux \
    vte-profile \
    wget \
    which \
    whois \
    words \
    xorg-x11-xauth \
    xz \
    zip \
    mesa-dri-drivers \
    mesa-vulkan-drivers \
    vulkan \
    zsh

# Get distrobox-host-exec
git clone https://github.com/89luca89/distrobox.git --single-branch /tmp/distrobox
cp /tmp/distrobox/distrobox-host-exec /usr/bin/distrobox-host-exec
wget https://github.com/1player/host-spawn/releases/download/$(cat /tmp/distrobox/distrobox-host-exec | grep host_spawn_version= | cut -d "\"" -f 2)/host-spawn-$(uname -m) -O /usr/bin/host-spawn
chmod +x /usr/bin/host-spawn
rm -drf /tmp/distrobox

dnf install -y 'dnf-command(copr)'
dnf copr enable -y kylegospo/distrobox-utils
dnf copr enable -y lcroberts/WMBazzite
dnf install -y xdg-utils-distrobox

# RPM fusion
dnf install -y \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf install -y \
    intel-media-driver \
    nvidia-vaapi-driver
dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld

dnf install -y \
    @development-tools \
    @development-libs \
    gcc-g++ \
    tmux \
    vim \
    neovim \
    tealdeer \
    eza \
    fd-find \
    ripgrep \
    starship \
    zoxide \
    fzf \
    jq \
    yq \
    direnv \
    lldb \
    just

# Sets up host-exec for various applications
mkdir -p /usr/local/bin/
echo 'ln -sf /usr/bin/distrobox-host-exec "/usr/local/bin/$1"' >/usr/local/bin/ln_host_exec
chmod +x /usr/local/bin/ln_host_exec

ln_host_exec docker
ln_host_exec podman
ln_host_exec flatpak
ln_host_exec code
ln_host_exec rpm-ostree
ln_host_exec tailscale

dnf clean all
