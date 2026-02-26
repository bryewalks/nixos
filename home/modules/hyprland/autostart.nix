{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      "waybar & swaync & hypridle & hyprpaper"
      "waypaper --restore"
      "nm-applet --indicator"
      "systemctl --user start hyprpolkitagent"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "[workspace special:email silent] $webapp=\"https://mail.proton.me\" --user-data-dir=$HOME/.local/share/chromium-webapp/proton"
      "[workspace special:email silent] $webapp=\"https://gmail.com\" --user-data-dir=$HOME/.local/share/chromium-webapp/gmail"
      "[workspace special:gpt silent] $webapp=\"https://chatgpt.com\" --user-data-dir=$HOME/.local/share/chromium-webapp/chatgpt"
      "[workspace special:terminal silent] $terminal tmux"
      "[workspace special:browser silent] firefox"
    ];
  };
}
