#!/bin/bash

read -n 1 -r -s -p $'Please, unplug the USB bluetooth dongle, then press enter to continue\n'
echo ""

install=$(cd /run/media/rcandau/data/bluetooth/bt_usb/ && sudo make install > /dev/null 2>&1 && echo "true" || echo "false")

if [ "$install" = "true" ]; then
        read -n 1 -r -s -p $'Please, plug the USB bluetooth dongle, then press enter to continue\n'
        echo ""
        sleep 3

        hci=$(hciconfig -a | grep -c "24:4B:FE:3A:1A:FD")
        if [ "$hci" = 1 ]; then
                echo "USB bluetooth dongle recognized, everything seems ok :)"
                exit 0
        elif [ "$hci" = 0 ]; then
                echo "USB bluetooth dongle not recognized, something went wrong"
                echo "Please, try to relaunch the script and make sure you followed each steps"
                exit 1
        else
                echo "Something went wrong, please check the following return"
                echo ""
                hciconfig -a
                exit 1
        fi
else
        echo "Installation failed, something went wrong"
        echo "Please, try to relaunch the script and make sure you followed each steps correctly"
        exit 1
fi
