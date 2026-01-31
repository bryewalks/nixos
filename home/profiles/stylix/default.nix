{ config, pkgs, ... }:

{
  stylix = {
    enable = true;
    autoEnable = true;
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
      base00 = "#21222c";
      base01 = "#ff5555";
      base02 = "#50fa7b";
      base03 = "#f1fa8c";
      base04 = "#bd93f9";
      base05 = "#ff79c6";
      base06 = "#8be9fd";
      base07 = "#f8f8f2";
      base08 = "#6272a4";
      base09 = "#ff6e6e";
      base0A = "#69ff94";
      base0B = "#ffffa5";
      base0C = "#d6acff";
      base0D = "#ff92df";
      base0E = "#a4ffff";
      base0F = "#ffffff";
    };

    targets.kitty.enable = true;
  };
}

