{ ... }:
{
  wayland.windowManager.hyprland = {
    # TODO: Use nix syntax once home-manager supports 0.53 syntax
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
          name = proton-workspace
          match:class = ^(chrome-mail.proton.me__-Default)$
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
