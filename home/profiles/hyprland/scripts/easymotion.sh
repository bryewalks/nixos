#!/bin/sh

if hyprctl plugins list | grep -qi easymotion; then
  hyprctl dispatch easymotion action:hyprctl dispatch focuswindow address:{}
fi
