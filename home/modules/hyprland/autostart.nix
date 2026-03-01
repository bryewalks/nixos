{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      "waybar & swaync & hypridle & hyprpaper"
      "waypaper --restore"
      "nm-applet --indicator"
      "systemctl --user start hyprpolkitagent"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "[workspace special:email silent] zen-beta --no-remote --new-window -P WebApp-proton --class WebApp-proton https://mail.proton.me"
      "[workspace special:email silent] zen-beta --no-remote --new-window -P WebApp-gmail --class WebApp-gmail https://gmail.com"
      "[workspace special:aichat silent] zen-beta --no-remote --new-window -P WebApp-claude --class WebApp-claude https://claude.ai"
      "[workspace special:terminal silent] $terminal tmux"
      "[workspace special:browser silent] zen-beta"
    ];
  };
}
