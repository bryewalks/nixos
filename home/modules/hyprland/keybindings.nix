{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Move focus with mainMod + HJKL
      "$mainMod, H, movefocus, l"
      "$mainMod, J, movefocus, d"
      "$mainMod, K, movefocus, u"
      "$mainMod, L, movefocus, r"

      # Hyprland shortcuts
      "$mainMod, C, killactive,"
      "$mainMod, S, togglesplit,"
      "$mainMod, V, togglefloating,"

      # Application shortcuts
      "$mainMod, A, exec, $audio"
      "$mainMod, D, exec, discord"
      "$SUPER_SHIFT, D, exec, vesktop"
      "$mainMod, F, exec, ~/.config/hypr/scripts/easymotion.sh"
      "$SUPER_SHIFT, F, exec, $fileManager"
      "$SUPER_SHIFT, G, exec, $terminal codex"
      "$mainMod, I, exec, $terminal btop"
      "$mainMod, N, exec, $terminal nvim"
      "$mainMod, P, exec, hyprshot -m window"
      "$SUPER_SHIFT, P, exec, hyprshot -m region"
      "$mainMod, M, exec, $music"
      "$SUPER_SHIFT, M, exec, $movies"
      "$mainMod, Q, exec, pkill waybar && waybar"
      "$mainMod, W, exec, bitwarden-desktop"
      "$mainMod, SPACE, exec, $menu"
      "$SUPER_SHIFT, SPACE, exec, ~/.config/system-scripts/webapp-rofi.sh"
      "$mainMod, RETURN, exec, $terminal"
      "$mainMod, X, exec, ~/.config/system-scripts/wlogout-toggle.sh"
      "$mainMod, Z, fullscreen, 0"

      # Webapp shortcuts
      "$mainMod, Y, exec, $webapp=\"https://youtube.com\""
      "$mainMod, R, exec, $webapp=\"https://reddit.com\""
      "$SUPER_SHIFT, R, exec, $webapp=\"https://lemmy.ml\""

      # Special workspaces
      "$mainMod, E, togglespecialworkspace, email"
      "$mainMod, T, togglespecialworkspace, terminal"
      "$mainMod, B, togglespecialworkspace, browser"
      "$mainMod, G, togglespecialworkspace, gpt"
      "$mainMod, O, togglespecialworkspace, magic"
      "$SUPER_SHIFT, O, movetoworkspace, special:magic"

      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Move active window to workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"

      # Move/resize windows with keyboard
      "$SUPER_SHIFT, H, movewindow, l"
      "$SUPER_SHIFT, L, movewindow, r"
      "$SUPER_SHIFT, K, movewindow, u"
      "$SUPER_SHIFT, J, movewindow, d"
      "$SUPER_SHIFT, left, resizeactive, -30 0"
      "$SUPER_SHIFT, right, resizeactive, 30 0"
      "$SUPER_SHIFT, up, resizeactive, 0 -30"
      "$SUPER_SHIFT, down, resizeactive, 0 30"

      # Discord/Vesktop push to talk
      ", mouse:276, pass, class:^(discord)$"
      ", mouse:276, sendshortcut, , f9, class:^(vesktop)$"
    ];

    # Move/resize windows with mainMod + mouse drag
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # Multimedia keys for volume and brightness
    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
      ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
    ];

    # Media transport keys (playerctl)
    bindl = [
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
  };
}
