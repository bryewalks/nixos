{ lib, ... }:
let
  mkLua    = lib.generators.mkLuaInline;
  mod      = suffix: mkLua ''mainMod .. " + ${suffix}"'';
  modShift = suffix: mkLua ''mainMod .. " + SHIFT + ${suffix}"'';
  modCtrl  = suffix: mkLua ''mainMod .. " + CTRL + ${suffix}"'';
  bind = key: dsp: { _args = [key (mkLua dsp)]; };
  bindOpts = key: dsp: opts: { _args = [key (mkLua dsp) opts]; };
in {
  wayland.windowManager.hyprland.settings.bind =
    [
      # Focus with vim keys
      (bind (mod "H") ''hl.dsp.focus({ direction = "left" })'')
      (bind (mod "J") ''hl.dsp.focus({ direction = "down" })'')
      (bind (mod "K") ''hl.dsp.focus({ direction = "up" })'')
      (bind (mod "L") ''hl.dsp.focus({ direction = "right" })'')

      # Window management
      (bind (mod "C") "hl.dsp.window.close()")
      (bind (mod "S") ''hl.dsp.layout("togglesplit")'')
      (bind (mod "V") ''hl.dsp.window.float({ action = "toggle" })'')

      # Application shortcuts
      (bind (mod "A")             "hl.dsp.exec_cmd(audio)")
      (bind (modShift "B")        "hl.dsp.exec_cmd(browser)")
      (bind (mod "D")             ''hl.dsp.exec_cmd("discord")'')
      (bind (mod "F")             ''hl.dsp.exec_cmd("~/.config/hypr/scripts/easymotion.sh")'')
      (bind (modShift "F")        "hl.dsp.exec_cmd(fileManager)")
      (bind (mod "I")             ''hl.dsp.exec_cmd(terminal .. " btop")'')
      (bind (modShift "M")        "hl.dsp.exec_cmd(music)")
      (bind (mod "N")             ''hl.dsp.exec_cmd(terminal .. " nvim")'')
      (bind (mod "P")             ''hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot-monitor.sh")'')
      (bind (modShift "P")        ''hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot-region.sh")'')
      (bind (modCtrl "P")         ''hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot-window.sh")'')
      (bind (mod "Q")             ''hl.dsp.exec_cmd("pkill waybar || true; waybar")'')
      (bind (mod "R")             ''hl.dsp.exec_cmd("~/.config/hypr/scripts/record-monitor.sh")'')
      (bind (modShift "R")        ''hl.dsp.exec_cmd("~/.config/hypr/scripts/record-region.sh")'')
      (bind (modCtrl "R")         ''hl.dsp.exec_cmd("~/.config/hypr/scripts/record-window.sh")'')
      (bind (mod "W")             ''hl.dsp.exec_cmd("bitwarden")'')
      (bind (mod "X")             ''hl.dsp.exec_cmd("~/.config/hypr/scripts/wlogout-toggle.sh")'')
      (bind (modShift "Y")        ''hl.dsp.exec_cmd(terminal .. " claude")'')
      (bind (mod "Z")             "hl.dsp.window.fullscreen(0)")
      (bind (mod "SPACE")         "hl.dsp.exec_cmd(menu)")
      (bind (modShift "SPACE")    ''hl.dsp.exec_cmd("~/.config/hypr/scripts/webapp-rofi.sh")'')
      (bind (mod "RETURN")        "hl.dsp.exec_cmd(terminal)")

      # Special workspaces
      (bind (mod "B")           ''hl.dsp.workspace.toggle_special("browser")'')
      (bind (mod "E")           ''hl.dsp.workspace.toggle_special("email")'')
      (bind (modShift "E")      "hl.dsp.exec_cmd(gmail)")
      (bind (modShift "E")      "hl.dsp.exec_cmd(proton)")
      (bind (mod "G")           ''hl.dsp.workspace.toggle_special("steam")'')
      (bind (mod "G")           ''hl.dsp.exec_cmd("hyprctl clients | grep -q 'class: steam' || steam")'')
      (bind (modShift "G")      ''hl.dsp.exec_cmd("steam")'')
      (bind (mod "M")           "hl.dsp.exec_cmd(movies)")
      (bind (mod "M")           ''hl.dsp.workspace.toggle_special("movies")'')
      (bind (mod "O")           ''hl.dsp.workspace.toggle_special("magic")'')
      (bind (modShift "O")      ''hl.dsp.window.move({ workspace = "special:magic" })'')
      (bind (mod "T")           ''hl.dsp.workspace.toggle_special("texts")'')
      (bind (modShift "T")      ''hl.dsp.workspace.toggle_special("terminal")'')
      (bind (mod "Y")           ''hl.dsp.workspace.toggle_special("aichat")'')
      (bind (modShift "Y")      "hl.dsp.exec_cmd(claude)")

      # Workspace 0 → 10
      (bind (mod "0")           "hl.dsp.focus({ workspace = 10 })")
      (bind (modShift "0")      "hl.dsp.window.move({ workspace = 10 })")

      # Scroll through workspaces
      (bind (mod "mouse_down")  ''hl.dsp.focus({ workspace = "e+1" })'')
      (bind (mod "mouse_up")    ''hl.dsp.focus({ workspace = "e-1" })'')

      # Move windows with keyboard
      (bind (modShift "H") ''hl.dsp.window.move({ direction = "left" })'')
      (bind (modShift "L") ''hl.dsp.window.move({ direction = "right" })'')
      (bind (modShift "K") ''hl.dsp.window.move({ direction = "up" })'')
      (bind (modShift "J") ''hl.dsp.window.move({ direction = "down" })'')

      # Resize windows with keyboard
      (bindOpts (modShift "left")  ''hl.dsp.window.resize({ x = -30, y = 0,   relative = true })'' { repeating = true; })
      (bindOpts (modShift "right") ''hl.dsp.window.resize({ x = 30,  y = 0,   relative = true })'' { repeating = true; })
      (bindOpts (modShift "up")    ''hl.dsp.window.resize({ x = 0,   y = -30, relative = true })'' { repeating = true; })
      (bindOpts (modShift "down")  ''hl.dsp.window.resize({ x = 0,   y = 30,  relative = true })'' { repeating = true; })

      # Mouse move/resize
      (bindOpts (mod "mouse:272") "hl.dsp.window.drag()"   { mouse = true; })
      (bindOpts (mod "mouse:273") "hl.dsp.window.resize()" { mouse = true; })

      # Multimedia keys
      (bindOpts "XF86AudioRaiseVolume"  ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")''   { locked = true; repeating = true; })
      (bindOpts "XF86AudioLowerVolume"  ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")''   { locked = true; repeating = true; })
      (bindOpts "XF86AudioMute"         ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")''  { locked = true; repeating = true; })
      (bindOpts "XF86AudioMicMute"      ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")'' { locked = true; repeating = true; })
      (bindOpts "XF86MonBrightnessUp"   ''hl.dsp.exec_cmd("brightnessctl s 10%+")''                        { locked = true; repeating = true; })
      (bindOpts "XF86MonBrightnessDown" ''hl.dsp.exec_cmd("brightnessctl s 10%-")''                        { locked = true; repeating = true; })

      # Media transport
      (bindOpts "XF86AudioNext"  ''hl.dsp.exec_cmd("playerctl next")''        { locked = true; })
      (bindOpts "XF86AudioPause" ''hl.dsp.exec_cmd("playerctl play-pause")''  { locked = true; })
      (bindOpts "XF86AudioPlay"  ''hl.dsp.exec_cmd("playerctl play-pause")''  { locked = true; })
      (bindOpts "XF86AudioPrev"  ''hl.dsp.exec_cmd("playerctl previous")''    { locked = true; })

      # Discord/Vesktop push to talk
      # pass() instantly releases using work around in the meantime.
      # https://github.com/hyprwm/Hyprland/discussions/14417
      # (bind "mouse:276" ''hl.dsp.pass({ window = "class:^(discord)$" })'')
      # (bind "mouse:276" ''hl.dsp.pass({ window = "class:^(vesktop)$" })'')
      (bind "mouse:276"
        ''hl.dsp.send_key_state({ mods = "", key = "f9", state = "down", window = "class:^(discord)$" })'')
      (bindOpts "mouse:276"
        ''hl.dsp.send_key_state({ mods = "", key = "f9", state = "up", window = "class:^(discord)$" })''
        { release = true; })
      (bind "mouse:276"
        ''hl.dsp.send_key_state({ mods = "", key = "f9", state = "down", window = "class:^(vesktop)$" })'')
      (bindOpts "mouse:276"
        ''hl.dsp.send_key_state({ mods = "", key = "f9", state = "up", window = "class:^(vesktop)$" })''
        { release = true; })
    ]
    # Workspaces 1–9
    ++ lib.concatMap (i: [
      (bind (mod      (toString i)) ''hl.dsp.focus({ workspace = ${toString i} })'')
      (bind (modShift (toString i)) ''hl.dsp.window.move({ workspace = ${toString i} })'')
    ]) (lib.range 1 9);
}
