{ lib, hyprlandLib, ... }:
with hyprlandLib;
let
  pushToTalk = class: [
    (bind "mouse:276" ''hl.dsp.send_key_state({ mods = "", key = "f9", state = "down", window = "class:^(${class})$" })'')
    (bindOpts "mouse:276"
      ''hl.dsp.send_key_state({ mods = "", key = "f9", state = "up", window = "class:^(${class})$" })''
      { release = true; }
    )
  ];
in
{
  wayland.windowManager.hyprland.settings.bind = [
    # ── Windows ───────────────────────────────────────────────────────────
    (bind (mod "C") closeWindow)
    (bind (mod "S") (layoutBind {
      scrolling = layout "consume_or_expel next";
      dwindle = layout "togglesplit";
    }))
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

    (bindRepeat (modShift "left") (resizeWindow (-30) 0))
    (bindRepeat (modShift "right") (resizeWindow 30 0))
    (bindRepeat (modShift "up") (resizeWindow 0 (-30)))
    (bindRepeat (modShift "down") (resizeWindow 0 30))

    (bindOpts (mod "mouse:272") dragWindow { mouse = true; })
    (bindOpts (mod "mouse:273") mouseResize { mouse = true; })

    # ── Workspaces ────────────────────────────────────────────────────────
    (bind (mod "mouse_down") (focusWorkspace "e+1"))
    (bind (mod "mouse_up") (focusWorkspace "e-1"))

    (bind (mod "B") (toggleSpecial "browser"))
    (bind (mod "O") (toggleSpecial "magic"))
    (bind (modShift "O") (moveWorkspace "special:magic"))
    (bind (mod "T") (toggleSpecial "texts"))
    (bind (modShift "T") (toggleSpecial "terminal"))

    # ── Applications ──────────────────────────────────────────────────────
    (bind (mod "A") (launch "audio"))
    (bind (modShift "B") (launch "browser"))
    (bind (mod "D") (launch "voip"))
    (bind (modShift "F") (launch "fileManager"))
    (bind (mod "I") (launchTerminal "btop"))
    (bind (modShift "M") (launch "music"))
    (bind (mod "N") (launchTerminal "nvim"))
    (bind (mod "Q") (execCmd "pkill waybar || true; waybar"))
    (bind (mod "W") (launch "passwordManager"))
    (bind (mod "SPACE") (launch "menu"))
    (bind (modShift "SPACE") (script "webapp-rofi"))
    (bind (mod "RETURN") (launch "terminal"))

    (bind (mod "P") (script "screenshot-monitor"))
    (bind (modShift "P") (script "screenshot-region"))
    (bind (modCtrl "P") (script "screenshot-window"))
    (bind (mod "R") (script "record-monitor"))
    (bind (modShift "R") (script "record-region"))
    (bind (modCtrl "R") (script "record-window"))
    (bind (mod "X") (script "wlogout-toggle"))

    (bind (mod "E") (toggleSpecial "email"))
    (bind (modShift "E") (launch "gmail"))
    (bind (modCtrl "E") (launch "proton"))

    (bind (mod "G") (toggleSpecial "steam"))
    (bind (mod "G") (execCmd "hyprctl clients | grep -q 'class: steam' || steam"))
    (bind (modShift "G") (launch "steam"))

    (bind (mod "M") (toggleSpecial "movies"))
    (bind (mod "M") (launch "movies"))

    (bind (mod "Y") (toggleSpecial "aichat"))
    (bind (modShift "Y") (launch "claude"))
    (bind (modCtrl "Y") (launchTerminal "claude"))

    # ── System ────────────────────────────────────────────────────────────
    (bindOpts "XF86AudioRaiseVolume" (execCmd "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+") {
      locked = true;
      repeating = true;
    })
    (bindOpts "XF86AudioLowerVolume" (execCmd "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") {
      locked = true;
      repeating = true;
    })
    (bindOpts "XF86AudioMute" (execCmd "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") {
      locked = true;
      repeating = true;
    })
    (bindOpts "XF86AudioMicMute" (execCmd "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") {
      locked = true;
      repeating = true;
    })
    (bindOpts "XF86MonBrightnessUp" (execCmd "brightnessctl s 10%+") {
      locked = true;
      repeating = true;
    })
    (bindOpts "XF86MonBrightnessDown" (execCmd "brightnessctl s 10%-") {
      locked = true;
      repeating = true;
    })

    (bindOpts "XF86AudioNext" (execCmd "playerctl next") { locked = true; })
    (bindOpts "XF86AudioPause" (execCmd "playerctl play-pause") { locked = true; })
    (bindOpts "XF86AudioPlay" (execCmd "playerctl play-pause") { locked = true; })
    (bindOpts "XF86AudioPrev" (execCmd "playerctl previous") { locked = true; })
  ]

  # Discord/Vesktop push to talk
  # pass() instantly releases using work around in the meantime.
  # https://github.com/hyprwm/Hyprland/discussions/14417
  # (bind "mouse:276" ''hl.dsp.pass({ window = "class:^(discord)$" })'')
  # (bind "mouse:276" ''hl.dsp.pass({ window = "class:^(vesktop)$" })'')
  ++ pushToTalk "discord"
  ++ pushToTalk "vesktop"

  ++ lib.concatMap (
    i:
    let
      key = if i == 10 then "0" else toString i;
    in
    [
      (bind (mod key) (focusWorkspace i))
      (bind (modShift key) (moveWorkspace i))
    ]
  ) (lib.range 1 10);
}
