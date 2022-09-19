#!/usr/bin/env bash

bluetooth_status=$(sudo systemctl status bluetooth | grep -wc "active (running)")

if [ "$bluetooth_status" = 0 ]; then
        sudo modprobe btusb && sudo systemctl restart bluetooth && echo -e "Bluetooth service repaired and restarted\n" || exit 1

        bluetooth_status=$(sudo systemctl status bluetooth | grep -wc "active (running)")
        if [ "$bluetooth_status" = 1 ]; then
                echo "Bluetooth service is running"
                echo -e "Launching the install_bluetooth_driver.sh script\n"
                ~/Documents/scripts/install_bluetooth_driver.sh || exit 1
                exit 0
        else
                echo "Bluetooth service has a problem"
                echo -e "Please check the following return\n"
                sudo systemctl status bluetooth
                exit 1
        fi
else
        echo "Bluetooth service is already running correctly"
        exit 0
fi
