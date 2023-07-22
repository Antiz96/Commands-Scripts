#!/bin/bash

while IFS= read -r user; do echo -e "\n\n==> ${user}:" && sudo crontab -u "${user}" -l; done < <(cut -f1 -d: < /etc/passwd)
