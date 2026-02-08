{ lib, pkgs, inputs, ... }:
let
  hp = pkgs.hyprlandPlugins or { };
  dracula = import ../../themes/dracula.nix;
  themeUtils = import ../../themes/utils.nix { inherit lib; };
  easymotionFromInput =
    lib.attrByPath [ "hyprland-easymotion" "packages" pkgs.system "default" ]
    null inputs;
in {
  wayland.windowManager.hyprland.plugins =
    lib.optionals (builtins.hasAttr "hyprfocus" hp) [ hp.hyprfocus ]
    ++ lib.optionals (builtins.hasAttr "hypr-dynamic-cursors" hp)
    [ hp."hypr-dynamic-cursors" ]
    ++ lib.optionals (easymotionFromInput != null) [ easymotionFromInput ];

  wayland.windowManager.hyprland.settings = {
    "plugin:hyprfocus" = {
      mode = "slide";
      slide_height = 5;
    };

    "plugin:dynamic-cursors" = {
      enabled = true;
      mode = "none";
      threshold = 2;
      rotate = {
        length = 20;
        offset = 0.0;
      };
      tilt = {
        limit = 5000;
        function = "negative_quadratic";
      };
      stretch = {
        limit = 3000;
        function = "quadratic";
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

    "plugin:easymotion" = {
      textsize = 54;
      textcolor = themeUtils.toRgba { hex = dracula.purple; };
      bgcolor = themeUtils.toRgba { hex = dracula.selection; };
      textpadding = "10 10 10 10";
      bordersize = 2;
      bordercolor = themeUtils.toRgba { hex = dracula.foreground; };
      rounding = 1;
    };
  };
}
