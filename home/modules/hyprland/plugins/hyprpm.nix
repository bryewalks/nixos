{ lib, pkgs, hyprlandInput ? null, ... }:
let
  hyprPkgs =
    if hyprlandInput == null then { } else hyprlandInput.packages.${pkgs.system} or { };
  hp =
    if builtins.hasAttr "hyprlandPlugins" hyprPkgs then
      hyprPkgs.hyprlandPlugins
    else
      pkgs.hyprlandPlugins or { };
  easymotionCandidates = [ "easymotion" "hypr-easymotion" "hyprEasymotion" ];
  availableEasymotion =
    builtins.filter (name: builtins.hasAttr name hp) easymotionCandidates;
in {
  wayland.windowManager.hyprland.plugins =
    lib.optionals (builtins.hasAttr "hyprfocus" hp) [ hp.hyprfocus ]
    ++ lib.optionals (builtins.hasAttr "hyprwinwrap" hp) [ hp.hyprwinwrap ]
    ++ lib.optionals (builtins.hasAttr "dynamic-cursors" hp)
    [ hp."dynamic-cursors" ] ++ lib.optionals (availableEasymotion != [ ])
    [ hp.${builtins.head availableEasymotion} ];

  wayland.windowManager.hyprland.settings = {
    "plugin:hyprwinwrap" = { class = "kitty-bg"; };

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
      textcolor = "rgba(bd93f9ff)";
      bgcolor = "rgba(44475aff)";
      textpadding = "10 10 10 10";
      bordersize = 2;
      bordercolor = "rgba(f8f8f2ff)";
      rounding = 1;
    };
  };
}
