{ pkgs, hyprlandInput, ... }:
let
  hyprPkgs = hyprlandInput.packages.${pkgs.system};
in

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = hyprPkgs.hyprland;
    portalPackage = hyprPkgs.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      hyprPkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
