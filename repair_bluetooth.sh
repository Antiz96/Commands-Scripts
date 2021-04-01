#!/bin/bash

read -n 1 -r -s -p $'Please, unplug the USB bluetooth dongle, then press enter to continue\n'
echo ""

install=$(cd /run/media/rcandau/DATA/bluetooth/bt_usb/ && sudo make install > /dev/null 2>&1 && echo "1" || echo "0")

if [ "$install" = 1 ]; then
	read -n 1 -r -s -p $'Please, plug the USB bluetooth dongle, then press enter to continue\n'
	echo ""
	sleep 3

	hci=$(hciconfig -a | grep "24:4B:FE:3A:1A:FD" | wc -l)
	if [ "$hci" = 1 ]; then
		echo "USB bluetooth dongle recognized, everything seems ok :)"
	elif [ "$hci" = 0 ]; then
		echo "USB bluetooth dongle not recognized, something went wrong"
		echo "Please, try to relaunch the script and make sure you followed each steps"
	else
		echo "Something went wrong, please check the following return"
		hciconfig -a
	fi
else
	echo "Installation failed, something went wrong"
	echo "Please, try to relaunch the script and make sure you followed each steps"
fi
