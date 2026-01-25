{ ... }:

{
  home.username = "brye";
  home.homeDirectory = "/home/brye";
  home.stateVersion = "25.11";
  environment.etc."nixos".source = "/home/brye/nixos";

  imports = [
    ../../profiles/cli.nix
    ../../profiles/hyprland.nix
  ];
}
