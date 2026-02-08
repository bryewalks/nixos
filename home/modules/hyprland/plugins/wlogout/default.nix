{ ... }:
let
  cssUtils = import ../../../themes/css.nix { };
  draculaTheme = cssUtils.mkDraculaTheme { cssPath = ./style.css; };
  draculaCss = draculaTheme.css;
  draculaJson = draculaTheme.json;
  draculaPalette = draculaTheme.palette;
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

  xdg.configFile."wlogout/style.css".text = draculaCss;

  xdg.configFile."wlogout/icons" = {
    source = ../../../../assets/icons;
    recursive = true;
  };
}
