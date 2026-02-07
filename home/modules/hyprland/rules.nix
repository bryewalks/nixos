{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "suppress_event maximize,match:class:.*"
      "no_focus,match:class:^$,match:title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      "workspace special:email silent,match:class:^(chrome-gmail.com__-Default)$"
      "workspace special:gpt silent,match:class:^(chrome-chatgpt.com__-Default)$"
    ];
  };
}
