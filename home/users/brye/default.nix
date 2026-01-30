{ ... }:

{
  home.username = "brye";
  home.homeDirectory = "/home/brye";
  home.stateVersion = "25.11";

  imports = [
    ../../profiles/cli
    ../../profiles/hyprland
    ../../profiles/neovim
  ];
}
