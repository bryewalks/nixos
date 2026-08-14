#!/usr/bin/env bash

state=$(systemctl show -p ActiveState --value rclone-dropbox-storage.service)
icon=$'\xef\x83\xae'

if [[ "$state" == "active" || "$state" == "activating" ]]; then
    echo "$icon"
fi
