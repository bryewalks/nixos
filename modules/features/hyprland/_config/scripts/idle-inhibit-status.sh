#!/usr/bin/env bash

lockfile="${XDG_RUNTIME_DIR:-/tmp}/idle-inhibit.pid"
icon=$''

if [[ -f "$lockfile" ]] && kill -0 "$(cat "$lockfile")" 2>/dev/null; then
    echo "$icon"
fi
