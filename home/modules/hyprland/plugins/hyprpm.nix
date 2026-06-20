{ lib, pkgs, inputs, theme, ... }:
let
  rgba = theme.rgba;
  easymotionFromInput =
    lib.attrByPath
      [ "hyprland-easymotion" "packages" pkgs.stdenv.hostPlatform.system "default" ]
    null inputs;
  hyprfocusFromInput =
    lib.attrByPath
      [ "hyprland-plugins" "packages" pkgs.stdenv.hostPlatform.system "hyprfocus" ]
    null inputs;
in {
  wayland.windowManager.hyprland.settings.config = lib.mkMerge [
    (lib.mkIf (hyprfocusFromInput != null) {
      plugin.hyprfocus = {
        keyboard_focus_animation = "slide";
        mouse_focus_animation = "none";
        slide_height = 5;
      };
    })
    (lib.mkIf (easymotionFromInput != null) {
      plugin.easymotion = {
        textsize = 54;
        textcolor = rgba.purple;
        bgcolor = rgba.selection;
        textpadding = 10;
        bordersize = 2;
        bordercolor = rgba.foreground;
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
    ;
}
