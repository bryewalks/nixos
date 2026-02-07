{ ... }:
{
  wayland.windowManager.hyprland = {
    # TODO: Use nix syntax once 0.53 is in nixpkgs
    # settings = {
    #   windowrule = [
    #     "suppress_event maximize,match:class:.*"
    #     "no_focus,match:class:^$,match:title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    #     "workspace special:email silent,match:class:^(chrome-gmail.com__-Default)$"
    #     "workspace special:gpt silent,match:class:^(chrome-chatgpt.com__-Default)$"
    #   ];
    # };

    extraConfig = ''
      windowrule {
          # Ignore maximize requests from all apps. You'll probably like this.
          name = suppress-maximize-events
          match:class = .*

          suppress_event = maximize
      }

      windowrule {
          # Fix some dragging issues with XWayland
          name = fix-xwayland-drags
          match:class = ^$
          match:title = ^$
          match:xwayland = true
          match:float = true
          match:fullscreen = false
          match:pin = false

          no_focus = true
      }

      # Work arounds for ensuring webapps open in the correct workspaces. Look into switching to firefox for webapps later.
      windowrule {
          name = gmail-workspace
          match:class = ^(chrome-gmail.com__-Default)$
          workspace = special:email silent
      }

      windowrule {
          name = gpt-workspace
          match:class = ^(chrome-chatgpt.com__-Default)$
          workspace = special:gpt silent
      }
    '';
  };
}
