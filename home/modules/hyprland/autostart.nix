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
      "chromium --new-window --ozone-platform=wayland --class=mail-proton --app=https://mail.proton.me"
      "chromium --new-window --ozone-platform=wayland --class=mail-gmail --app=https://gmail.com"
      "chromium --new-window --ozone-platform=wayland --class=chatgpt-app --app=https://chatgpt.com"
      "kitty --class=special-terminal tmux"
      "firefox --class=special-browser"
    ];

    windowrulev2 = [
      "workspace special:email silent,class:^(mail-proton|mail-gmail)$"
      "workspace special:gpt silent,class:^(chatgpt-app)$"
      "workspace special:terminal silent,class:^(special-terminal)$"
      "workspace special:browser silent,class:^(special-browser)$"
    ];
  };
}
