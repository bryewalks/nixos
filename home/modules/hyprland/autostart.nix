{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      "waybar & swaync & hypridle & hyprpaper"
      "waypaper --restore"
      "nm-applet --indicator"
      "systemctl --user start hyprpolkitagent"
      "dropbox-cli start"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "kbuildsycoca6"
      "[workspace special:email silent] $browser --app=https://mail.proton.me"
      "[workspace special:email silent] $browser --app=https://gmail.com"
      "[workspace special:gpt silent] $browser --app=https://chatgpt.com"
      "[workspace special:terminal silent] $terminal tmux"
      "[workspace special:browser silent] firefox"
    ];
  };
}
