{ config, pkgs, ... }:
let
  xcursorDracula = import ../../pkgs/dracula-cursors.nix { inherit pkgs; };
in
{
  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-frappe-mauve";
    settings = {
      General = {
        CursorTheme = "Dracula-cursors";
        CursorSize = "24";
        GreeterEnvironment = "XCURSOR_THEME=Dracula-cursors,XCURSOR_SIZE=24";
      };
    };
    wayland = {
      enable = true;
      compositor = "kwin";
    };
  };

  environment.systemPackages = with pkgs;
    [
      (catppuccin-sddm.override {
        flavor = "frappe";
        accent = "mauve";
        font = "CaskaydiaCove Nerd Font Mono";
        fontSize = "12";
        loginBackground = false;
        background = "backgrounds/wall.jpg";
        userIcon = false;
      })
      xcursorDracula
    ];
}
