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
      base00 = "#282a36";
      base01 = "#343746";
      base02 = "#44475a";
      base03 = "#6272a4";
      base04 = "#9ea8c7";
      base05 = "#f8f8f2";
      base06 = "#f1f2f8";
      base07 = "#ffffff";
      base08 = "#ff5555";
      base09 = "#ffb86c";
      base0A = "#f1fa8c";
      base0B = "#50fa7b";
      base0C = "#8be9fd";
      base0D = "#bd93f9";
      base0E = "#ff79c6";
      base0F = "#ff6e6e";
    };

    targets.kitty.enable = true;
  };
}

