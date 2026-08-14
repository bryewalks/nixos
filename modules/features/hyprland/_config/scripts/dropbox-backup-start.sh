#!/usr/bin/env bash

state=$(systemctl show -p ActiveState --value rclone-dropbox-storage.service)

if [[ "$state" == "active" || "$state" == "activating" ]]; then
    notify-send -t 3000 "Dropbox backup" "Already running"
else
    systemctl start --no-block rclone-dropbox-storage.service
    notify-send -t 3000 "Dropbox backup" "Started"
fi
