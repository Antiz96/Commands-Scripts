#!/bin/bash

# This checks for NFS clients (port 2049), change it to whatever you're looking for

for i in $(netstat -pan | grep -i 2049 | grep -v 0.0.0.0 | grep -v :: | awk '{print $5}' | sed "s/:.*//"); do nslookup $i | awk '{print $4}'; done
