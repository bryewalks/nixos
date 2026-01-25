{
  xdg.configFile."hypr/hyprland.conf".text = ''
    monitors =,preferred,auto,1
    exec-once = waybar
    exec-once = mako
    exec-once = kitty

    bind = SUPER, RETURN, exec, kitty
    bind = SUPER, SPACE, exec, rofi -show drun
    bind = SUPER, C, killactive
  '';
}
