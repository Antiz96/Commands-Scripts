#!/usr/bin/env bash

for i in $(yum history | grep -i ansible | awk '{ print $1}'); do yum history info "$i"; done
