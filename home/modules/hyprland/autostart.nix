{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      "waybar & swaync & hypridle & hyprpaper"
      "waypaper --restore"
      "nm-applet --indicator"
      "valent --gapplication-service"
      "systemctl --user start hyprpolkitagent"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "[workspace special:email silent] $proton" 
      "[workspace special:email silent] $gmail"
      "[workspace special:aichat silent] $claude"
      "[workspace special:terminal silent] $terminal tmux"
      "[workspace special:browser silent] zen-beta"
      "[workspace special:texts silent] gapplication action ca.andyholmes.Valent messages-window"
    ];
  };
}
