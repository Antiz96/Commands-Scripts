#!/bin/bash

DIR=${HOME}/.gnupg/

function run() {
	RESULT=$(gpg "${1}" | grep -v pub | awk '{print $5}' | cut -f1 -d "]" | sed s/-//g)
}

for i in "${DIR}"/*.asc
do
        run "${i}"
done

EXPIRATION=$(( '(' "$(date -d "${RESULT}"  +%s)" - "$(date +%s)" + 86399 ')' / 86400))

if [ "${EXPIRATION}" -le 31 ]; then
        echo "${EXPIRATION}"
else
        echo "OK"
fi
