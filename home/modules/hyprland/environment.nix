{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    env = [
      { _args = ["HYPRSHOT_DIR" "$HOME/Pictures/Screenshots"]; }
      { _args = ["QT_QPA_PLATFORM" "wayland"]; }
      { _args = ["QT_WAYLAND_DISABLE_WINDOWDECORATION" "1"]; }
      { _args = ["QT_AUTO_SCREEN_SCALE_FACTOR" "1"]; }
      # Force Electron apps to use wayland instead of xwayland.
      # Currently push to talk is broken on wayland for discord.
      # { _args = ["NIXOS_OZONE_WL" "1"]; }
    ];
  };
}
