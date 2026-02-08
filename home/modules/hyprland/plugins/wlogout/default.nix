{ lib, ... }:
let
  dracula = import ../../../themes/dracula.nix;
  themeUtils = import ../../../themes/utils.nix { inherit lib; };
  baseCss = builtins.readFile ./style.css;
  colorNames = builtins.attrNames dracula;
  cssVars = map (name: "var(--dracula-${name})") colorNames;
  colorValues = map (name: dracula.${name}) colorNames;
  bgAlpha = themeUtils.toCssRgba { hex = dracula.background; opacity = "cc"; };
  wlogoutVars = cssVars ++ [ "var(--wlogout-bg-alpha)" ];
  wlogoutValues = colorValues ++ [ bgAlpha ];
  style = builtins.replaceStrings wlogoutVars wlogoutValues baseCss;
in
{
  xdg.configFile."wlogout/layout".text = ''
    {
        "label": "lock",
        "action": "hyprlock",
        "text": "L",
        "keybind": "l",
        "width": 1,
        "height": 1
    }

    {
        "label": "logout",
        "action": "hyprctl dispatch exit 0",
        "text": "E",
        "keybind": "e",
        "width": 1,
        "height": 1
    }

    {
        "label": "suspend",
        "action": "systemctl suspend && hyprlock",
        "text": "S",
        "keybind": "s",
        "width": 1,
        "height": 1
    }

    {
        "label": "shutdown",
        "action": "systemctl poweroff",
        "text": "P",
        "keybind": "p",
        "width": 1,
        "height": 1
    }

    {
        "label": "hibernate",
        "action": "systemctl hibernate && hyprlock",
        "text": "H",
        "keybind": "h",
        "width": 1,
        "height": 1
    }

    {
        "label": "reboot",
        "action": "systemctl reboot",
        "text": "R",
        "keybind": "r",
        "width": 1,
        "height": 1
    }
  '';

  xdg.configFile."wlogout/style.css".text = style;

  xdg.configFile."wlogout/icons" = {
    source = ../../../../assets/icons;
    recursive = true;
  };
}
