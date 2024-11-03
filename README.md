# Dev Containers

This repo houses custom containers for use in things such as distrobox.

## Fedora Dev

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
