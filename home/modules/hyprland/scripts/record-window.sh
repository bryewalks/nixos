#!/usr/bin/env bash
if pgrep -x wf-recorder > /dev/null; then
  pkill -INT wf-recorder
  pkill -SIGRTMIN+8 waybar
else
  mkdir -p ~/Videos/Screenrecords
  GEOMETRY=$(hyprctl clients -j | jq -r '.[] | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | slurp) || exit 1
  wf-recorder -a -g "$GEOMETRY" -f ~/Videos/Screenrecords/$(date +%Y-%m-%d-%H%M%S)_window.mp4 &
  pkill -SIGRTMIN+8 waybar
fi
