{ lib, pkgs, inputs, ... }:
let
  themeBuilder = import ../../themes/theme-builder.nix { inherit lib; };
  draculaTheme = themeBuilder.mkTheme { theme = "dracula"; };
  draculaRgba = draculaTheme.rgba;
  easymotionFromInput =
    lib.attrByPath
      [ "hyprland-easymotion" "packages" pkgs.stdenv.hostPlatform.system "default" ]
    null inputs;
  hyprfocusFromInput =
    lib.attrByPath
      [ "hyprland-plugins" "packages" pkgs.stdenv.hostPlatform.system "hyprfocus" ]
    null inputs;
  dynamicCursorsFromInput =
    lib.attrByPath
      [ "hypr-dynamic-cursors" "packages" pkgs.stdenv.hostPlatform.system "default" ]
    null inputs;
in {
  wayland.windowManager.hyprland.settings.config = lib.mkMerge [
    (lib.mkIf (hyprfocusFromInput != null) {
      plugin.hyprfocus = {
        mode = "slide";
        slide_height = 5;
      };
    })
    (lib.mkIf (dynamicCursorsFromInput != null) {
      plugin."dynamic-cursors" = {
        enabled = true;
        mode = "none";
        threshold = 2;
        rotate = {
          length = 20;
          offset = 0.0;
        };
        tilt = {
          limit = 5000;
          "function" = "negative_quadratic";
        };
        stretch = {
          limit = 3000;
          "function" = "quadratic";
        };
        shake = {
          enabled = true;
          nearest = true;
          threshold = 6.0;
          base = 4.0;
          speed = 4.0;
          influence = 0.0;
          limit = 0.0;
          timeout = 2000;
          effects = false;
          ipc = false;
        };
        hyprcursor = {
          nearest = true;
          enabled = true;
          resolution = -1;
          fallback = "clientside";
        };
      };
    })
    (lib.mkIf (easymotionFromInput != null) {
      plugin.easymotion = {
        textsize = 54;
        textcolor = draculaRgba.purple;
        bgcolor = draculaRgba.selection;
        textpadding = 10;
        bordersize = 2;
        bordercolor = draculaRgba.foreground;
        rounding = 1;
      };
    })
  ];

  wayland.windowManager.hyprland.extraConfig =
    lib.optionalString (easymotionFromInput != null) ''
      hl.plugin.load("${easymotionFromInput}/lib/libhyprland-easymotion.so")
      hl.bind(mainMod .. " + F", function()
        hl.plugin.easymotion.dispatch([[action:dispatch:focuswindow address:{}]])
      end)
    ''
    + lib.optionalString (hyprfocusFromInput != null) ''
      hl.plugin.load("${hyprfocusFromInput}/lib/libhyprfocus.so")
    ''
    + lib.optionalString (dynamicCursorsFromInput != null) ''
      hl.plugin.load("${dynamicCursorsFromInput}/lib/libhypr-dynamic-cursors.so")
    '';
}
