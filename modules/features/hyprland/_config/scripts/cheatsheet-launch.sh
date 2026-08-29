#!/usr/bin/env bash
name="$1"
class="imv-${name}"

existing_pid=$(hyprctl clients -j | jq -r ".[] | select(.class == \"${class}\") | .pid" | head -n1)

if [[ -n "$existing_pid" ]]; then
    kill "$existing_pid"
else
    imv -i "$class" -f -b 282a36 "$HOME/.config/hypr/${name}-cheatsheet.png"
fi
