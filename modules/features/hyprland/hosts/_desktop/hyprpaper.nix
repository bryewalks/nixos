{ config, ... }:
{
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    ipc = true
    splash = false

    wallpaper {
        monitor = DP-1
        path = ${config.xdg.dataHome}/wallpapers/shaded-landscape.png
    }

    wallpaper {
        monitor = DP-2
        path = ${config.xdg.dataHome}/wallpapers/shaded-landscape.png
    }
  '';
}
