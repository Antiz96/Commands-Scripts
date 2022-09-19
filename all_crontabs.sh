#!/usr/bin/env bash

result=$(for user in $(cut -f1 -d: /etc/passwd)
do
        echo -e "\n\n==> $user:" && crontab -u "$user" -l
done)

echo "$result"
