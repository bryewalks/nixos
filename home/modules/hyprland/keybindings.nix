{ lib, ... }:
let
  mkLua    = lib.generators.mkLuaInline;
  mod      = suffix: mkLua ''mainMod .. " + ${suffix}"'';
  modShift = suffix: mkLua ''mainMod .. " + SHIFT + ${suffix}"'';
  modCtrl  = suffix: mkLua ''mainMod .. " + CTRL + ${suffix}"'';
  bind       = key: dsp:       { _args = [key (mkLua dsp)]; };
  bindOpts   = key: dsp: opts: { _args = [key (mkLua dsp) opts]; };
  bindRepeat = key: dsp:       bindOpts key dsp { repeating = true; };
  exec    = luaExpr: ''hl.dsp.exec_cmd(${luaExpr})'';
  execCmd = cmd:     ''hl.dsp.exec_cmd("${cmd}")'';
  script  = name:    ''hl.dsp.exec_cmd("~/.config/hypr/scripts/${name}.sh")'';
  luaWs          = ws: if builtins.isInt ws then toString ws else ''"${ws}"'';
  focusDirection = dir:  ''hl.dsp.focus({ direction = "${dir}" })'';
  focusWorkspace = ws:   ''hl.dsp.focus({ workspace = ${luaWs ws} })'';
  moveDirection  = dir:  ''hl.dsp.window.move({ direction = "${dir}" })'';
  moveWorkspace  = ws:   ''hl.dsp.window.move({ workspace = ${luaWs ws} })'';
  resizeWindow   = x: y: ''hl.dsp.window.resize({ x = ${toString x}, y = ${toString y}, relative = true })'';
  toggleSpecial  = name: ''hl.dsp.workspace.toggle_special("${name}")'';
  dragWindow   = "hl.dsp.window.drag()";
  mouseResize  = "hl.dsp.window.resize()";
  closeWindow  = "hl.dsp.window.close()";
  floatWindow = action: ''hl.dsp.window.float({ action = "${action}" })'';
  fullscreen  = mode:   ''hl.dsp.window.fullscreen(${toString mode})'';
  layout      = name:   ''hl.dsp.layout("${name}")'';
  pushToTalk  = class: [
    (bind "mouse:276"
      ''hl.dsp.send_key_state({ mods = "", key = "f9", state = "down", window = "class:^(${class})$" })'')
    (bindOpts "mouse:276"
      ''hl.dsp.send_key_state({ mods = "", key = "f9", state = "up", window = "class:^(${class})$" })''
      { release = true; })
  ];
in {
  wayland.windowManager.hyprland.settings.bind =
    [
      # ── Windows ───────────────────────────────────────────────────────────
      (bind (mod "C") closeWindow)
      (bind (mod "S") (layout "togglesplit"))
      (bind (mod "V") (floatWindow "toggle"))
      (bind (mod "Z") (fullscreen 0))

      (bind (mod "H") (focusDirection "left"))
      (bind (mod "J") (focusDirection "down"))
      (bind (mod "K") (focusDirection "up"))
      (bind (mod "L") (focusDirection "right"))

      (bind (modShift "H") (moveDirection "left"))
      (bind (modShift "J") (moveDirection "down"))
      (bind (modShift "K") (moveDirection "up"))
      (bind (modShift "L") (moveDirection "right"))

      (bindRepeat (modShift "left")  (resizeWindow (-30)   0 ))
      (bindRepeat (modShift "right") (resizeWindow   30    0 ))
      (bindRepeat (modShift "up")    (resizeWindow    0  (-30)))
      (bindRepeat (modShift "down")  (resizeWindow    0    30 ))

      (bindOpts (mod "mouse:272") dragWindow   { mouse = true; })
      (bindOpts (mod "mouse:273") mouseResize  { mouse = true; })

      # ── Workspaces ────────────────────────────────────────────────────────
      (bind (mod "mouse_down") (focusWorkspace "e+1"))
      (bind (mod "mouse_up")   (focusWorkspace "e-1"))

      (bind (mod "B")      (toggleSpecial "browser"))
      (bind (mod "O")      (toggleSpecial "magic"))
      (bind (modShift "O") (moveWorkspace "special:magic"))
      (bind (mod "T")      (toggleSpecial "texts"))
      (bind (modShift "T") (toggleSpecial "terminal"))

      # ── Applications ──────────────────────────────────────────────────────
      (bind (mod "A")          (exec "audio"))
      (bind (modShift "B")     (exec "browser"))
      (bind (mod "D")          (execCmd "discord"))
      (bind (modShift "F")     (exec "fileManager"))
      (bind (mod "I")          (exec ''terminal .. " btop"''))
      (bind (modShift "M")     (exec "music"))
      (bind (mod "N")          (exec ''terminal .. " nvim"''))
      (bind (mod "Q")          (execCmd "pkill waybar || true; waybar"))
      (bind (mod "W")          (execCmd "bitwarden"))
      (bind (mod "SPACE")      (exec "menu"))
      (bind (modShift "SPACE") (script "webapp-rofi"))
      (bind (mod "RETURN")     (exec "terminal"))

      (bind (mod "P")      (script "screenshot-monitor"))
      (bind (modShift "P") (script "screenshot-region"))
      (bind (modCtrl "P")  (script "screenshot-window"))
      (bind (mod "R")      (script "record-monitor"))
      (bind (modShift "R") (script "record-region"))
      (bind (modCtrl "R")  (script "record-window"))
      (bind (mod "X")      (script "wlogout-toggle"))

      (bind (mod "E")      (toggleSpecial "email"))
      (bind (modShift "E") (exec "gmail"))
      (bind (modShift "E") (exec "proton"))

      (bind (mod "G")      (toggleSpecial "steam"))
      (bind (mod "G")      (execCmd "hyprctl clients | grep -q 'class: steam' || steam"))
      (bind (modShift "G") (execCmd "steam"))

      (bind (mod "M")      (exec "movies"))
      (bind (mod "M")      (toggleSpecial "movies"))

      (bind (mod "Y")      (toggleSpecial "aichat"))
      (bind (modShift "Y") (exec ''terminal .. " claude"''))
      (bind (modShift "Y") (exec "claude"))

      # ── System ────────────────────────────────────────────────────────────
      (bindOpts "XF86AudioRaiseVolume"  (execCmd "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")    { locked = true; repeating = true; })
      (bindOpts "XF86AudioLowerVolume"  (execCmd "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")    { locked = true; repeating = true; })
      (bindOpts "XF86AudioMute"         (execCmd "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")   { locked = true; repeating = true; })
      (bindOpts "XF86AudioMicMute"      (execCmd "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") { locked = true; repeating = true; })
      (bindOpts "XF86MonBrightnessUp"   (execCmd "brightnessctl s 10%+")                         { locked = true; repeating = true; })
      (bindOpts "XF86MonBrightnessDown" (execCmd "brightnessctl s 10%-")                         { locked = true; repeating = true; })

      (bindOpts "XF86AudioNext"  (execCmd "playerctl next")       { locked = true; })
      (bindOpts "XF86AudioPause" (execCmd "playerctl play-pause") { locked = true; })
      (bindOpts "XF86AudioPlay"  (execCmd "playerctl play-pause") { locked = true; })
      (bindOpts "XF86AudioPrev"  (execCmd "playerctl previous")   { locked = true; })
    ]

    # Discord/Vesktop push to talk
    # pass() instantly releases using work around in the meantime.
    # https://github.com/hyprwm/Hyprland/discussions/14417
    # (bind "mouse:276" ''hl.dsp.pass({ window = "class:^(discord)$" })'')
    # (bind "mouse:276" ''hl.dsp.pass({ window = "class:^(vesktop)$" })'')
    ++ pushToTalk "discord"
    ++ pushToTalk "vesktop"

    ++ lib.concatMap (i: let key = if i == 10 then "0" else toString i; in [
      (bind (mod      key) (focusWorkspace i))
      (bind (modShift key) (moveWorkspace i))
    ]) (lib.range 1 10);
}
