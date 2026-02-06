{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "suppressevent maximize,class:.*"
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      "workspace special:email silent,class:^(chrome-gmail.com__-Default)$"
      "workspace special:gpt silent,class:^(chrome-chatgpt.com__-Default)$"
    ];
  };
}
