{ pkgs, ... }:

let
  dracula = import ../themes/dracula.nix;
  pick = key: fallback: if builtins.hasAttr key dracula then dracula.${key} else fallback;
  cavaGradient = [
    dracula.cyan
    (pick "brightCyan" dracula.cyan)
    (pick "brightPurple" dracula.purple)
    dracula.purple
    (pick "brightMagenta" dracula.magenta)
    dracula.magenta
    (pick "brightRed" dracula.red)
    dracula.red
  ];
in
{
  home.packages = [
    pkgs.cava
  ];

  xdg.configFile."cava/config".text = ''
    data_format = ascii
    ascii_max_range = 9

    [color]

    gradient = 1

    gradient_color_1 = '${builtins.elemAt cavaGradient 0}'
    gradient_color_2 = '${builtins.elemAt cavaGradient 1}'
    gradient_color_3 = '${builtins.elemAt cavaGradient 2}'
    gradient_color_4 = '${builtins.elemAt cavaGradient 3}'
    gradient_color_5 = '${builtins.elemAt cavaGradient 4}'
    gradient_color_6 = '${builtins.elemAt cavaGradient 5}'
    gradient_color_7 = '${builtins.elemAt cavaGradient 6}'
    gradient_color_8 = '${builtins.elemAt cavaGradient 7}'
  '';
}
