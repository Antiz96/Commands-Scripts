#!/usr/bin/env bash

PACKAGES=$(/usr/bin/checkupdates | awk '{print $1}')
AURPACKAGES=$(/usr/bin/yay -Qua | awk '{print $1}')

xfce4-panel --plugin-event=genmon-22:refresh:bool:true

if [ -n "$PACKAGES" ]; then
        echo -e "Packages :\n" && echo -e "$PACKAGES\n"
fi

if [ -n "$AURPACKAGES" ]; then
        echo -e "AUR Packages :\n" && echo -e "$AURPACKAGES\n"
fi

if [ -z "$PACKAGES" ] && [ -z "$AURPACKAGES" ]; then
        echo -e "No update available\n" && read -n 1 -r -s -p $'Press \"enter\" to quit\n'
        exit 0
else
        read -n 1 -r -s -p $'Press \"enter\" to apply updates or \"ctrl + c\" to quit\n'
        sed -i "s/mintupdate-checking/mintupdate-installing/" /home/rcandau/Documents/scripts/genmon_update.sh && xfce4-panel --plugin-event=genmon-22:refresh:bool:true
        sudo pacman -Syu && yay -Syu

        if [ "$?" -ne 0 ]; then
                sed -i "s/mintupdate-installing/mintupdate-checking/" /home/rcandau/Documents/scripts/genmon_update.sh && xfce4-panel --plugin-event=genmon-22:refresh:bool:true
                echo -e "\nUpdates have been aborted\n" && read -n 1 -r -s -p $'Press \"enter\" to quit\n'
                exit 1
        fi

        sed -i "s/mintupdate-installing/mintupdate-checking/" /home/rcandau/Documents/scripts/genmon_update.sh && xfce4-panel --plugin-event=genmon-22:refresh:bool:true
        echo -e "\nUpdates have been applied\n" && read -n 1 -r -s -p $'Press \"enter\" to quit\n'
        exit 0
fi
