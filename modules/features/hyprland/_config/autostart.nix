{ hyprlandLib, ... }:
let inherit (hyprlandLib) startupHook; in {
  wayland.windowManager.hyprland.settings.on = [
    (startupHook ''
      hl.exec_cmd("waybar & swaync & hypridle & hyprpaper")
      hl.exec_cmd("waypaper --restore")
      hl.exec_cmd("nm-applet --indicator")
      hl.exec_cmd("valent --gapplication-service")
      hl.exec_cmd("systemctl --user start hyprpolkitagent")
      hl.exec_cmd("[workspace special:email silent] "    .. proton)
      hl.exec_cmd("[workspace special:email silent] "    .. gmail)
      hl.exec_cmd("[workspace special:aichat silent] "   .. claude)
      hl.exec_cmd("[workspace special:terminal silent] " .. terminal .. " tmux")
      hl.exec_cmd("[workspace special:browser silent] zen-beta")
      hl.exec_cmd("[workspace special:texts silent] gapplication action ca.andyholmes.Valent messages-window")
    '')
  ];
}
