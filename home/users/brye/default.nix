{ lib, ... }:

{
  home.username = "brye";
  home.homeDirectory = "/home/brye";
  home.stateVersion = "25.11";

  imports = [
    ../../modules/apps
    ../../modules/cli
    ../../modules/hyprland
    ../../modules/kitty
    ../../modules/neovim
    ../../modules/stremio
    ../../modules/stylix
  ];
}
