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
      # base00 = "#21222c"; # color 0
      # base01 = "#ff5555"; # color 18
      # base02 = "#50fa7b"; # color 19
      # base03 = "#f1fa8c"; # color 8
      # base04 = "#bd93f9"; # color 20
      # base05 = "#ff79c6"; # color 7
      # base06 = "#8be9fd"; # color 21
      # base07 = "#f8f8f2"; # color 15
      # base08 = "#6272a4"; # color 1 / 21
      # base09 = "#ff6e6e"; # color 16
      # base0A = "#69ff94"; # color 3 / 11
      # base0B = "#ffffa5"; # color 2 / 10
      # base0C = "#d6acff"; # color 6 / 14
      # base0D = "#ff92df"; # color 4 / 12
      # base0E = "#a4ffff"; # color 5 / 13
      # base0F = "#ffffff"; # color 17

      base00 = "#21222c"; # color 0
      base08 = "#ff5555"; # color 1 / 21
      base21 = "#ff5555"; # color 21
      base0B = "#50fa7b"; # color 2 / 10
      base10 = "#69ff94"; # color 10
      base0A = "#f1fa8c"; # color 3 / 11
      base11 = "#ffffa5"; # color 11
      base0D = "#bd93f9"; # color 4 / 12
      base12 = "#d6acff"; # color 12
      base0E = "#ff79c6"; # color 5 / 13
      base13 = "#ff92df"; # color 13
      base0C = "#8be9fd"; # color 6 / 14
      base14 = "#a4ffff"; # color 14
      base05 = "#f8f8f2"; # color 7
      base03 = "#6272a4"; # color 8
      base07 = "#ffffff"; # color 15
      base09 = "#000000"; # color 16
      base0F = "#000000"; # color 17
      base01 = "#000000"; # color 18
      base02 = "#000000"; # color 19
      base04 = "#000000"; # color 20
      base06 = "#000000"; # color 21
    };

    targets.kitty.enable = true;
  };
}

