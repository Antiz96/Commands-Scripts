#!/bin/bash

bluetooth_error=$(sudo systemctl status bluetooth | grep -w "Condition check resulted in Bluetooth service being skipped." | wc -l)

if [ "$bluetooth_error" = 0 ]; then
        echo "Bluetooth service has no condition error"
        echo ""

        bluetooth_status=$(sudo systemctl status bluetooth | grep -w "active (running)" | wc -l)
        if [ "$bluetooth_status" = 1 ]; then
                echo "Bluetooth service is running"
                exit 0
        else
                echo "Bluetooth service has a problem"
                echo "Please check the following return"
                echo ""
                sudo systemctl status bluetooth
                exit 1
        fi
else
        sudo modprobe btusb && sudo systemctl restart bluetooth && echo "Bluetooth service repaired and restarted"
        echo ""

        bluetooth_status=$(sudo systemctl status bluetooth | grep -w "active (running)" | wc -l)
        if [ "$bluetooth_status" = 1 ]; then
                echo "Bluetooth service is running"
                echo "Launching the install_bluetooth_driver.sh script"
                echo ""
                ~/Documents/scripts/install_bluetooth_driver.sh && exit 0
        else
                echo "Bluetooth service has a problem"
                echo "Please check the following return"
                echo ""
                sudo systemctl status bluetooth
                exit 1
        fi
fi
