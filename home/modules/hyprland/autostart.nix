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
      "[workspace special:email silent] chromium --new-window --ozone-platform=wayland --class=mail-proton --app=https://mail.proton.me"
      "[workspace special:email silent] chromium --new-window --ozone-platform=wayland --class=mail-gmail --app=https://gmail.com"
      "[workspace special:gpt silent] chromium --new-window --ozone-platform=wayland --class=chatgpt-app --app=https://chatgpt.com"
      "[workspace special:terminal silent] kitty --class=special-terminal tmux"
      "[workspace special:browser silent] firefox --new-instance"
    ];

    # Keep fallback rules so manually opened matching app classes also route correctly.
    windowrulev2 = [
      "workspace special:email silent,class:^(mail-proton|mail-gmail)$"
      "workspace special:gpt silent,class:^(chatgpt-app)$"
      "workspace special:terminal silent,class:^(special-terminal)$"
      "workspace special:browser silent,class:^(firefox|special-browser)$"
    ];
  };
}
