{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$terminal" = "kitty";
    "$fileManager" = "dolphin";
    "$menu" = "rofi -show drun";
    "$audio" = "helvum";
    "$browser" = "chromium --new-window --ozone-platform=wayland";
    "$music" = "$terminal cmus";
    "$webapp" = "$browser --app";
    "$movies" = "stremio || flatpak run com.stremio.Stremio";
  };
}
