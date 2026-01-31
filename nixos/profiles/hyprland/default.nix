{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --cmd start-hyprland";
      user = "greeter";
    };
  };

  environment.systemPackages = with pkgs; [
    waybar
    rofi
    mako
    wl-clipboard
    grim
    slurp
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
