# Theme for Hyprtoolkit based hypr apps
# https://wiki.hypr.land/hypr-ecosystem/user/hyprtoolkit/
{ config, ... }:
let
  palette = config.theme.palette;
  color = hex: config.theme.withRgbaAlpha hex "ff";
in
{
  programs.hyprtoolkit = {
    enable = true;
    package = null;
    settings = {
      background = color palette.background;
      base = color palette.lightBackground;
      text = color palette.foreground;
      alternate_base = color palette.selection;
      bright_text = color palette.brightWhite;
      accent = color palette.purple;
      accent_secondary = color palette.magenta;
    };
  };
}
