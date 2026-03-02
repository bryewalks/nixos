{ lib, osConfig, ... }:

let
  hostDirectoriesModule = ../../modules/directories + "/${osConfig.networking.hostName}.nix";
in
{
  home.username = "brye";
  home.homeDirectory = "/home/brye";
  home.stateVersion = "25.11";

  imports =
    [
      ../../modules/apps
      ../../modules/browsers
      ../../modules/cli
      ../../modules/dropbox
      ../../modules/gaming
      ../../modules/directories
      ../../modules/explorers/thunar.nix
      ../../modules/hyprland
      ../../modules/terminals/kitty.nix
      ../../modules/media
      ../../modules/media/stremio.nix
      ../../modules/neovim
      ../../modules/stylix
    ]
    ++ lib.optional (builtins.pathExists hostDirectoriesModule) hostDirectoriesModule;
}
