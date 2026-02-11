{ lib, ... }:

{
  home.username = "brye";
  home.homeDirectory = "/home/brye";
  home.stateVersion = "25.11";

  home.activation.createUserDirectories =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p \
        "$HOME/Code" \
        "$HOME/Documents" \
        "$HOME/Downloads" \
        "$HOME/Games" \
        "$HOME/Pictures" \
        "$HOME/Dropbox" \
        "$HOME/Music" \
        "$HOME/Videos"
    '';

  imports = [
    ../../modules/apps
    ../../modules/browsers
    ../../modules/cli
    ../../modules/explorers/dolphin.nix
    ../../modules/hyprland
    ../../modules/terminals/kitty.nix
    ../../modules/media
    ../../modules/media/stremio.nix
    ../../modules/neovim
    ../../modules/stylix
  ];
}
