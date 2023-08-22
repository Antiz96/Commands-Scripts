#!/bin/bash

# This is a script I made which run on a raspberry PI to monitor my physical servers' responsiveness and send them a wakeonlan packet after a certain period of inactivity (useful to power them back on automatically after a power outage for instance)

declare -A servers
servers["pmx01.rc"]="7c:10:c9:8c:88:9d"
servers["pmx02.rc"]="68:1d:ef:30:cc:88"

declare -A fail_counter

while true; do
        date
        for server in "${!servers[@]}"; do
                if ping -c5 "${server}" &>/dev/null; then
                        fail_counter["${server}"]=0
                        echo "${server} fail counter: ${fail_counter["${server}"]}"
                else
                        fail_counter["${server}"]=$((fail_counter["${server}"] + 1))
                        echo "${server} fail counter: ${fail_counter["${server}"]}"
                        if [ "${fail_counter["${server}"]}" -eq 6 ]; then
                                wakeonlan "${servers["${server}"]}"
                                fail_counter["${server}"]=$((fail_counter["${server}"] - 1))
                        fi
                fi
        done
        echo
        sleep 300
done