{ config, pkgs, ... }:

{
  let
    dracula = {
      background = "#282a36";
      lightBackground = "#343746";
      lightForeGround = "#f1f2f8"
      foreground = "#f8f8f2";
      darkForeground = "#9ea8c7";
      currentLine = "#6272a4"
      selection = "#44475a";
      red = "#ff5555";
      orange = "#ffb86c";
      green = "#50fa7b";
      yellow = "#f1fa8c";
      blue = "#bd93f9";
      magenta = "#ff79c6";
      cyan = "#8be9fd";
      white = "#f8f8f2";
      brightRed = "#ff6e6e";
      brightOrange = "#ffd185"
      brightGreen = "#69ff94";
      brightYellow = "#ffffa5";
      brightBlue = "#d6acff";
      brightMagenta = "#ff92df";
      brightCyan = "#a4ffff";
      brightWhite = "#ffffff";
    };
  in 

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
      base0D = dracula.blue;
      base0E = dracula.magenta;
      base0F = dracula.brightRed;
    };

    targets.kitty.enable = true;
  };
}

