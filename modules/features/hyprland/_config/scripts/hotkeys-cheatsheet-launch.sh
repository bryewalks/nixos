#!/usr/bin/env bash
existing_pid=$(hyprctl clients -j | jq -r '.[] | select(.class == "imv") | .pid' | head -n1)

if [[ -n "$existing_pid" ]]; then
    imv-msg "$existing_pid" reset
else
    imv -f -b 282a36 "$HOME/.config/hypr/hotkeys-cheatsheet.png"
fi
