#!/bin/bash

for i in $(cut -f1 -d: /etc/passwd); do echo -e "\n\n==> $i:" && sudo crontab -u "$i" -l; done