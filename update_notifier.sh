#!/bin/bash
UPDATE_NUMBER=$( (/usr/bin/checkupdates ; /usr/bin/yay -Qua) | wc -l)

if [ "$UPDATE_NUMBER" -ne 0 ]; then
        echo "$UPDATE_NUMBER"
else
        echo ""
fi
