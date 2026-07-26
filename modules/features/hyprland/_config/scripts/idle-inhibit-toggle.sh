#!/usr/bin/env bash

lockfile="${XDG_RUNTIME_DIR:-/tmp}/idle-inhibit.pid"

if [[ -f "$lockfile" ]] && kill -0 "$(cat "$lockfile")" 2>/dev/null; then
    kill "$(cat "$lockfile")"
    rm -f "$lockfile"
    notify-send -t 3000 "Idle inhibit" "Off — screen will lock/sleep normally"
else
    systemd-inhibit --what=idle --who="hyprland" --why="Manually inhibited via keybind" --mode=block sleep infinity &
    echo $! > "$lockfile"
    disown
    notify-send -t 3000 "Idle inhibit" "On — screen will not lock or sleep"
fi

pkill -SIGRTMIN+9 waybar
