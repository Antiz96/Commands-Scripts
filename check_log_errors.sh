#!/usr/bin/env bash

grep -ci "error" "$(ls -tr $1 | tail -1)"
