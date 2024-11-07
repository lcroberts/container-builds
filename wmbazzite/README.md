# wmbazzite

[![build-wmbazzite](https://github.com/lcroberts/wm-ublue-derivatives/actions/workflows/build.yml/badge.svg)](https://github.com/lcroberts/wm-ublue-derivatives/actions/workflows/build.yml)

# Purpose

This branch of the repository is intended to be a personal derivative of [Bazzite](https://bazzite.gg/#) and is built from the template found [here](https://github.com/ublue-os/image-template). It has added some window manager stuff on top of the existing Bazzite image to make it fit my workflow out of the box. It also includes some other features that I need such as Japanese input and some theming utilities. There is another repo doing a similar thing based off of [Aurora Developer Edition.](https://getaurora.dev/)

# How to Use

## Installing

This repository does not generate installer ISOs so the first step is to download an ISO from the [Bazzite](https://bazzite.gg/#) home page.

After you go through the installation process you can the run the following commands:

```bash
rpm-ostree reset
rpm-ostree rebase ostree-unverified-registry:ghcr.io/lcroberts/wmbazzite:latest
```

It is recommended to avoid going through the post install getting started app before rebasing, so you can close that out and rerun it after the rebase.

If you are rebasing from an unrelated image such as kinoite you can also run the following command after the rebase to get the flatpaks included in the bazzite installer.

```bash
ujust _install-system-flatpaks
```

## Verify

The image can be verified using cosign and the public key in the repository root.

```bash
cosign verify --key cosign.pub ghcr.io/lcroberts/wmbazzite
```

## Virtualization and Just

The bazzite base image comes with a just for setting up virtualization. `ujust setup-virtualization` can be used to pull up a prompt to manage it. There are also many other just scripts provided that are worth looking through. They can be viewed by simply running `ujust` without any arguments
