# Container Builds

This repository houses various container builds, the details of each can be found below.

Image List:
- [Fedora Dev](#fedora-dev)
- [WMBazzite](#wmbazzite)

## Fedora Dev

[![build-fedora-dev](https://github.com/lcroberts/container-builds/actions/workflows/build-fedora-dev.yml/badge.svg)](https://github.com/lcroberts/container-builds/actions/workflows/build-fedora-dev.yml)

Includes a bunch of cli tools that I use out of the box, as well as improved
integration with the host system.You can use podman or docker to build this
image using one of the following commands:

```bash
podman build -t fedora-dev -f fedora-dev/Containerfile .
```
```bash
docker build -t fedora-dev -f fedora-dev/Containerfile .
```

The image can then be accessed with the url `localhost/fedora-dev`. You can
also access the image from the github container registry at
`ghcr.io/lcroberts/fedora-dev`.

## WMBazzite

[![build-wmbazzite](https://github.com/lcroberts/container-builds/actions/workflows/build-wmbazzite.yml/badge.svg)](https://github.com/lcroberts/container-builds/actions/workflows/build-wmbazzite.yml)

This image is intended to be a personal derivative of [Bazzite](https://bazzite.gg/#). It has added some window manager stuff on top of the existing Bazzite image to make it fit my workflow out of the box. It also includes some other features that I need such as Japanese input and some theming utilities. Both the image and installer iso can be build with the justfile included in the wmbazzite directory.


### How to Use

#### Installing

You can install a [Bazzite](https://bazzite.gg/#) image and rebase or use the iso file from the releases.

If you install the bazzite base image you can use the following commands to rebase.

```bash
rpm-ostree reset # (Optional) Resets all layered packages
rpm-ostree rebase ostree-unverified-registry:ghcr.io/lcroberts/wmbazzite:latest
systemctl reboot
# After reboot rebase to signed image
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/lcroberts/wmbazzite:latest
```

It is recommended to avoid going through the post install getting started app before rebasing, so you can close that out and rerun it after the rebase.

If you are rebasing from an unrelated image such as kinoite you can also run the following command after the rebase to get the flatpaks included in the bazzite installer.

```bash
ujust _install-system-flatpaks
```

#### Verify

The image can be verified using cosign and the public key in the repository root.

```bash
cosign verify --key cosign.pub ghcr.io/lcroberts/wmbazzite
```

#### Virtualization and Just

The bazzite base image comes with a just for setting up virtualization. `ujust setup-virtualization` can be used to pull up a prompt to manage it. There are also many other just scripts provided that are worth looking through. They can be viewed by simply running `ujust` without any arguments
