{
  xdg.configFile."hypr/hyprland.conf".text = ''

  $mainMod = SUPER
  monitor = ,preferred,1920x1080@144,1

    exec-once = waybar
    exec-once = mako
    exec-once = kitty

    bind = SUPER, RETURN, exec, kitty
    bind = SUPER, SPACE, exec, rofi -show drun
    bind = SUPER, C, killactive
bind = $mainMod, S, togglesplit, # dwindle
    
bind = $mainMod, H, movefocus, l
bind = $mainMod, J, movefocus, d
bind = $mainMod, K, movefocus, u
bind = $mainMod, L, movefocus, r

    bind = $SUPER_SHIFT, LEFT, movecurrentworkspacetomonitor, +1
    bind = $SUPER_SHIFT, RIGHT, movecurrentworkspacetomonitor, -1 
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10
    
bind = $SUPER_SHIFT, H, movewindow, l
bind = $SUPER_SHIFT, L, movewindow, r
bind = $SUPER_SHIFT, K, movewindow, u
bind = $SUPER_SHIFT, J, movewindow, d 
    
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

  '';
}
