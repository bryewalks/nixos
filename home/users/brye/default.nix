{ lib, ... }:

{
  home.username = "brye";
  home.homeDirectory = "/home/brye";
  home.stateVersion = "25.11";

  # nixpkgs.config = {
  #   allowUnfree = true;
  #   # allowUnfreePredicate = pkg:
  #   #   builtins.elem (lib.getName pkg) [ "copilot-language-server" ];
  # };

  imports = [
    ../../profiles/stylix
    ../../profiles/cli
    ../../profiles/kitty
    ../../profiles/hyprland
    ../../profiles/neovim
  ];
}
