{ lib, osConfig, ... }:

let
  hostDirectoriesModule = ../../modules/directories + "/${osConfig.networking.hostName}.nix";
  themeBuilder = import ../../modules/themes/theme-builder.nix { inherit lib; };
  themeName    = "dracula";
  theme        = themeBuilder.mkTheme { theme = themeName; };
in
{
  _module.args = { inherit themeBuilder theme themeName; };
  home.username = "brye";
  home.homeDirectory = "/home/brye";
  home.stateVersion = "25.11";

  imports =
    [
      ../../modules/ai
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
      ../../modules/neovim
      ../../modules/stylix
    ]
    ++ lib.optional (builtins.pathExists hostDirectoriesModule) hostDirectoriesModule;
}
