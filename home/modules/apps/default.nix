{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden-desktop
    discord
    dropbox-cli
  ];
}
