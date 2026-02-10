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
    ../../modules/cli
    ../../modules/dolphin
    ../../modules/hyprland
    ../../modules/kitty
    ../../modules/neovim
    ../../modules/stremio
    ../../modules/stylix
  ];
}
