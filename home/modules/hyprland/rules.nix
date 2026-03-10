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

      # Game Launchers Workspace
      windowrule {
          name = launchers-workspace
          match:class = ^(steam|com.valvesoftware.Steam|itch|io.itch.itch|heroic|com.heroicgameslauncher.hgl|r2modman)$
          workspace = special:steam silent
      }

      windowrule {
         name = valent-workspace
         match:class = ^valent$
         workspace = special:texts silent
      }

      # TODO: set windowrule to split valent phone/messages on its workspace
      # windowrule {
      #    name = valent-phone
      #    match:class = ^valent$
      #    match:title = ^Valent$
      #    float = true
      #    size = 10% 100%
      #    move = 0% 0%
      # }
      #
      # windowrule {
      #    name = valent-texts
      #    match:class = ^valent$
      #    match:title = ^Messages$
      #    float = true
      #    size = 90% 100%
      #    move = 10% 0%
      # }
    '';
  };
}
