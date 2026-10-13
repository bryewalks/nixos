{ config, ... }:
{
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    ipc = true
    splash = false

    wallpaper {
        monitor = eDP-1
        path = ${config.xdg.dataHome}/wallpapers/shaded-landscape.png
    }
  '';
}
