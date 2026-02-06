{ hyprHostName, lib, pkgs, ... }:
let
  profileModule = ./profiles + "/${hyprHostName}.nix";
in
{
  imports =
    [
      ./vars.nix
      ./autostart.nix
      ./environment.nix
      ./input.nix
      ./keybindings.nix
      ./style.nix
      ./plugins.nix
      ./rules.nix
    ]
    ++ lib.optional (builtins.pathExists profileModule) profileModule;

  home.packages = with pkgs; [
    brightnessctl
    hyprcursor
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    hyprpolkitagent
    hyprshot
    networkmanagerapplet
    playerctl
    rofi
    swaynotificationcenter
    waybar
    waypaper
    wireplumber
    wl-clipboard
    wlogout
    (python3.withPackages (ps: [ ps.requests ]))
  ];

  wayland.windowManager.hyprland.enable = true;

  xdg.configFile = {
    "hypr/scripts" = {
      source = ./scripts;
      recursive = true;
    };
  };
}
