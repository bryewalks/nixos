{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    env = [
      "HYPRSHOT_DIR,$HOME/Pictures/Screenshots"
      "XCURSOR_THEME,Dracula-cursors"
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
      "HYPRCURSOR_THEME,hyprcursor_Dracula"
      "WLR_NO_HARDWARE_CURSORS,1"
      "QT_QPA_PLATFORM,wayland"
      "QT_QPA_PLATFORMTHEME,kde"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "QT_STYLE_OVERRIDE,kvantum"
      "XDG_MENU_PREFIX,arch-"
    ];
  };
}
