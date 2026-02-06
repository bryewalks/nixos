{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden-desktop
    chromium
    discord
    dropbox-cli
    firefox
    helvum
    loupe
    protonmail-desktop
    vlc
  ];
}
