# vim: set ft=make :

kmonad-setup:
	#!/usr/bin/env bash
	sudo groupadd uniput
	sudo usermod -aG input,uinput $USER
	echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/90-kmonad.rules
	sudo modprobe uinput
	sudo curl -Lo /etc/systemd/system/kmonad@.service https://raw.githubusercontent.com/kmonad/kmonad/master/startup/kmonad%40.service
	sudo ln -sT $HOME/.config/kmonad /etc/kmonad

	echo "Reboot for uinput rules and groups to apply"
	echo -e "To enable enable the kmonad systemd service run 'sudo systemctl enable kmonad@\033[31mconfig-name\033[m'"

alias jetbrains-toolbox := install-jetbrains-toolbox

install-jetbrains-toolbox:
	#!/usr/bin/env bash

	pushd "$(mktemp -d)"
	echo "Get latest JetBrains Toolbox version"
	# Get the json with latest releases
	curl -sSfL -o releases.json "https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release"
	# Extract information
	BUILD_VERSION=$(jq -r '.TBA[0].build' ./releases.json)
	DOWNLOAD_LINK=$(jq -r '.TBA[0].downloads.linux.link' ./releases.json)
	CHECKSUM_LINK=$(jq -r '.TBA[0].downloads.linux.checksumLink' ./releases.json)
	echo "Installing JetBrains Toolbox ${BUILD_VERSION}"
	curl -sSfL -O "${DOWNLOAD_LINK}"
	curl -sSfL "${CHECKSUM_LINK}" | sha256sum -c
	tar zxf jetbrains-toolbox-"${BUILD_VERSION}".tar.gz
	echo "Launching JetBrains Toolbox"
	./jetbrains-toolbox-"${BUILD_VERSION}"/jetbrains-toolbox
