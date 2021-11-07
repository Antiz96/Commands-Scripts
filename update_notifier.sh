#!/bin/bash
UPDATE_NUMBER=$( (/usr/bin/checkupdates && /usr/bin/yay -Qua) | wc -l)

if [ "$UPDATE_NUMBER" -eq 1 ]; then
	notify-send "Update" "$UPDATE_NUMBER update available" -i update
elif [ "$UPDATE_NUMBER" -gt 1 ]; then
	notify-send "Update" "$UPDATE_NUMBER updates available" -i update
fi
