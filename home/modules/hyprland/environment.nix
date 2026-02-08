{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    env = [
      "HYPRSHOT_DIR,$HOME/Pictures/Screenshots"
      "QT_QPA_PLATFORM,wayland"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
    ];
  };
}
