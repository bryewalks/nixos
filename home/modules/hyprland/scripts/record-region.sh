#!/usr/bin/env bash
if pgrep -x wf-recorder > /dev/null; then
  pkill -INT wf-recorder
  pkill -SIGRTMIN+8 waybar
else
  mkdir -p ~/Videos/Screenrecords
  GEOMETRY=$(slurp) || exit 1
  wf-recorder -g "$GEOMETRY" -f ~/Videos/Screenrecords/$(date +%Y-%m-%d-%H%M%S)_region.mp4 &
  pkill -SIGRTMIN+8 waybar
fi
