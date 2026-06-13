{ lib, ... }:
let
  themeBuilder = import ../themes/theme-builder.nix { inherit lib; };
  draculaTheme = themeBuilder.mkTheme { theme = "dracula"; };
  palette = draculaTheme.palette;
  withRgbaAlpha = draculaTheme.withRgbaAlpha;
in {
  wayland.windowManager.hyprland.settings = {
    config = {
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        col = {
          active_border = {
            colors = [
              (withRgbaAlpha palette.cyan "ee")
              (withRgbaAlpha palette.green "ee")
            ];
            angle = 45;
          };
          inactive_border = withRgbaAlpha palette.selection "aa";
        };
        resize_on_border = false;
        allow_tearing = true;
        layout = "dwindle";
      };

      cursor = {
        inactive_timeout = 2;
        no_hardware_cursors = true;
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = withRgbaAlpha palette.background "ee";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations.enabled = true;

      dwindle.preserve_split = true;

      master.new_status = "master";

      misc = {
        force_default_wallpaper = -1;
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
        initial_workspace_tracking = 2;
      };
    };

    curve = [
      { _args = ["easeOutQuint"   { type = "bezier"; points = [[0.23 1]    [0.32 1]   ]; }]; }
      { _args = ["easeInOutCubic" { type = "bezier"; points = [[0.65 0.05] [0.36 1]   ]; }]; }
      { _args = ["linear"         { type = "bezier"; points = [[0 0]        [1 1]      ]; }]; }
      { _args = ["almostLinear"   { type = "bezier"; points = [[0.5 0.5]   [0.75 1.0] ]; }]; }
      { _args = ["quick"          { type = "bezier"; points = [[0.15 0]    [0.1 1]    ]; }]; }
    ];

    animation = [
      { leaf = "global";        enabled = true; speed = 10;   bezier = "default";      }
      { leaf = "border";        enabled = true; speed = 5.39; bezier = "easeOutQuint"; }
      { leaf = "windows";       enabled = true; speed = 4.79; bezier = "easeOutQuint"; }
      { leaf = "windowsIn";     enabled = true; speed = 4.1;  bezier = "easeOutQuint"; style = "popin 87%"; }
      { leaf = "windowsOut";    enabled = true; speed = 1.49; bezier = "linear";       style = "popin 87%"; }
      { leaf = "fadeIn";        enabled = true; speed = 1.73; bezier = "almostLinear"; }
      { leaf = "fadeOut";       enabled = true; speed = 1.46; bezier = "almostLinear"; }
      { leaf = "fade";          enabled = true; speed = 3.03; bezier = "quick";        }
      { leaf = "layers";        enabled = true; speed = 3.81; bezier = "easeOutQuint"; }
      { leaf = "layersIn";      enabled = true; speed = 4;    bezier = "easeOutQuint"; style = "fade"; }
      { leaf = "layersOut";     enabled = true; speed = 1.5;  bezier = "linear";       style = "fade"; }
      { leaf = "fadeLayersIn";  enabled = true; speed = 1.79; bezier = "almostLinear"; }
      { leaf = "fadeLayersOut"; enabled = true; speed = 1.39; bezier = "almostLinear"; }
      { leaf = "workspaces";    enabled = true; speed = 1.94; bezier = "almostLinear"; style = "fade"; }
      { leaf = "workspacesIn";  enabled = true; speed = 1.21; bezier = "almostLinear"; style = "fade"; }
      { leaf = "workspacesOut"; enabled = true; speed = 1.94; bezier = "almostLinear"; style = "fade"; }
    ];
  };
}
