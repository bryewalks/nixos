{ config, pkgs, theme, ... }:

let
  palette = theme.palette;
  dracula-papirus = import ../../../nixos/pkgs/dracula-papirus.nix { inherit pkgs; lib = pkgs.lib; color = "dracula-purple"; };
in {
  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font Mono";
      };
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
    };

    base16Scheme = {
      schema = "withHashTag";
      base00 = palette.background;
      base01 = palette.lightBackground;
      base02 = palette.selection;
      base03 = palette.currentLine;
      base04 = palette.darkForeground;
      base05 = palette.foreground;
      base06 = palette.lightForeGround;
      base07 = palette.brightWhite;
      base08 = palette.red;
      base09 = palette.orange;
      base0A = palette.yellow;
      base0B = palette.green;
      base0C = palette.cyan;
      base0D = palette.purple;
      base0E = palette.magenta;
      base0F = palette.brightRed;
    };

    icons = {
      enable = true;
      package = dracula-papirus;
      dark = "Papirus-Dark";
      light = "Papirus";
    };

    targets.kitty.enable = true;
    targets.qt.enable = true;
    targets.gtk.enable = true;
    targets.kde.enable = true;
    targets.tmux.enable = true;
    targets.yazi.enable = true;
    targets.nixvim.enable = false;
    targets.zen-browser.enable = true;
  };

  # gtk.gtk4.theme = null;
}
