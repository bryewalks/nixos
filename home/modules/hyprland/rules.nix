{ ... }:
{
  wayland.windowManager.hyprland = {
    # TODO: Use nix syntax once home-manager supports 0.53 syntax
    extraConfig = ''
      workspace = special:browser, layout:scrolling

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

      # Remove to keep zen-beta confined to special:browser workspace
      windowrule {
          name = zen-beta-current-workspace
          match:class = ^zen-beta$

          workspace = current
      }

      windowrule {
          name = thunar-current-workspace
          match:class = ^thunar$

          workspace = current
      }
    '';
  };
}
