#!/bin/sh
sleep 1
hyprctl dispatch workspace 2
kitty +kitten panel -o background_opacity=0 -o dynamic_background_opacity=yes --edge=background cava &
sleep 0.5
hyprctl dispatch workspace 1
kitty
