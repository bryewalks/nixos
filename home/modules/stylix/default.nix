{ config, pkgs, ... }:

let
  dracula = import ../themes/dracula.nix;
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
      base00 = dracula.background;
      base01 = dracula.lightBackground;
      base02 = dracula.selection;
      base03 = dracula.currentLine;
      base04 = dracula.darkForeground;
      base05 = dracula.foreground;
      base06 = dracula.lightForeGround;
      base07 = dracula.brightWhite;
      base08 = dracula.red;
      base09 = dracula.orange;
      base0A = dracula.yellow;
      base0B = dracula.green;
      base0C = dracula.cyan;
      base0D = dracula.purple;
      base0E = dracula.magenta;
      base0F = dracula.brightRed;
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
}
