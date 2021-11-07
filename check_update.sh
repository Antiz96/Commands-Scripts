#!/bin/bash
PACKAGES=$(/usr/bin/checkupdates | awk '{print $1}')
AURPACKAGES=$(/usr/bin/yay -Qua | awk '{print $1}')


if [ -n "$PACKAGES" ]; then
	echo -e "Packages :\n" && echo -e "$PACKAGES\n"
fi


if [ -n "$AURPACKAGES" ]; then
	echo -e "AUR Packages :\n" && echo -e "$AURPACKAGES\n"
fi


if [ -z "$PACKAGES" ] && [ -z "$AURPACKAGES" ];then
	echo -e "No update available\n" && read -n 1 -r -s -p $'Press \"enter\" to quit\n'
else
	read -n 1 -r -s -p $'Press \"enter\" to apply updates or \"ctrl + c\" to quit\n'
	sudo pacman -Syu && yay -Syu
fi
