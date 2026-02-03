{ lib, ... }:

{
  home.username = "brye";
  home.homeDirectory = "/home/brye";
  home.stateVersion = "25.11";

  imports = [
    ../../profiles/stylix
    ../../profiles/cli
    ../../profiles/kitty
    ../../profiles/hyprland
    ../../profiles/neovim
  ];
}
