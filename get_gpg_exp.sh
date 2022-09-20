#!/usr/bin/env bash

#Check GPG Key End Date

DIR=${HOME}/.gnupg/

function run() {

                RESULT=$(gpg $1 | grep -v pub | awk '{print $5}' | cut -f1 -d "]" | sed s/\-//g)
}

for i in $(ls $DIR/*.asc | grep -v private)
do
        run $i
done


EXPIRATION=$(echo $(expr '(' $(date -d $RESULT  +%s) - $(date +%s) + 86399 ')' / 86400))


if [ $EXPIRATION -le 31 ]; then
        echo $EXPIRATION
else
        echo "1"
fi
