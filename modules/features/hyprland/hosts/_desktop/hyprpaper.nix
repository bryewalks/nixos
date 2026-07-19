{ config, ... }:
{
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    ipc = true
    splash = false

    # INFO: Bug in waypaper with hyprland 0.53 hard coding wallpaper for now remove below once fixed
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
