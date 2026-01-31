{ config, pkgs, ... }:

{
  stylix.enable = true;
  stylix = {
    enable = true;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font Mono";
        size = 14;
      };
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
    };

    colors = {
      scheme = "withHashtag";
      base00 = "#21222c";
      base01 = "#ff5555";
      base02 = "#50fa87b";
      base03 = "#f1fa8c";
      base04 = "#bd93f9";
      base05 = "#ff79c6";
      base06 = "#8be9fd";
      base07 = "#f8f8f2";
      base08 = "#6272a4";
      base09 = "#ff6e6e";
      base10 = "#69ff94";
      base11 = "$ffffa5";
      base12 = "#d6acff";
      base13 = "#ff92df";
      base14 = "#a4ffff";
      base15 = "#ffffff";
    };

    targets = [ "kitty"  ];
  };
}

