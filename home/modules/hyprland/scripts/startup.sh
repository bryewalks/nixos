#!/bin/sh
sleep 1
hyprctl dispatch workspace 2
kitty +kitten panel -c "$HOME/.config/kitty/kittybg.conf" --edge=background cava &
sleep 0.5
hyprctl dispatch workspace 1
kitty
