{ config, pkgs, ... }:
let
  css = config.theme.resolveCss ./style.css;
  json = config.theme.json;
in
{
  home.packages = [
    pkgs.wlogout
    pkgs.hyprshutdown
  ];

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
        "action": "hyprshutdown",
        "text": "E",
        "keybind": "e",
        "width": 1,
        "height": 1
    }

    {
        "label": "suspend",
        "action": "systemctl suspend",
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
        "action": "systemctl hibernate",
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

  xdg.configFile."wlogout/style.css".text = css;

  xdg.configFile."wlogout/icons" = {
    source = ./icons;
    recursive = true;
  };
}
