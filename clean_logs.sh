#!/bin/bash

find /log/path/ -maxdepth 1 -not -path /log/path/ -mtime +6 -exec rm -rf {} \;
