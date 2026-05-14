{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$terminal" = "kitty";
    "$fileManager" = "thunar";
    "$menu" = "rofi -show drun";
    "$audio" = "qpwgraph";
    "$browser" = "zen-beta --new-window";
    "$music" = "$terminal cmus";
    "$webapp" = "$browser -P WebApp --class WebApp";
    "$movies" = "stremio || flatpak run com.stremio.Stremio";
    "$gmail" = "zen-beta --no-remote --new-window -P WebApp-gmail --class WebApp-gmail https://gmail.com";
    "$proton" = "zen-beta --no-remote --new-window -P WebApp-proton --class WebApp-proton https://mail.proton.me";
    "$claude" = "zen-beta --no-remote --new-window -P WebApp-claude --class WebApp-claude https://claude.ai";
  };
}
