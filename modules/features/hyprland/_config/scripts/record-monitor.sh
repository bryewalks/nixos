#!/usr/bin/env bash
if pgrep -x wf-recorder > /dev/null; then
  pkill -INT wf-recorder
  pkill -SIGRTMIN+8 waybar
else
  mkdir -p ~/Videos/Screenrecords
  GEOMETRY=$(hyprctl monitors -j | jq -r '.[] | "\(.x),\(.y) \(.width)x\(.height)"' | slurp) || exit 1
  wf-recorder -a -g "$GEOMETRY" -f ~/Videos/Screenrecords/$(date +%Y-%m-%d-%H%M%S)_monitor.mp4 &
  pkill -SIGRTMIN+8 waybar
fi
