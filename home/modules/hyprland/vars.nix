{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$terminal" = "kitty";
    "$fileManager" = "thunar";
    "$menu" = "rofi -show drun";
    "$audio" = "helvum";
    "$browser" = "zen-beta --new-window";
    "$music" = "$terminal cmus";
    "$webapp" = "$browser -P WebApp --class WebApp";
    "$movies" = "stremio || flatpak run com.stremio.Stremio";
  };
}
