#!/bin/sh
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
kitty -c "$HOME/.config/kitty/kittybg.conf" --class="kitty-bg" "${script_dir}/cava.sh"
