{ hyprHostName, lib, pkgs, ... }:
let
  hostDir = ./hosts + "/${hyprHostName}";
  hostModule = hostDir + "/default.nix";
in
{
  imports =
    [
      ./vars.nix
      ./environment.nix
      ./input.nix
      ./keybindings.nix
      ./style.nix
      ./rules.nix
      ./plugins/hyprpm.nix
      ./plugins/hypridle
      ./plugins/hyprlock
      ./plugins/wlogout
      ./plugins/waybar
      ./plugins/waypaper
      ./autostart.nix
    ]
    ++ lib.optional (builtins.pathExists hostModule) hostModule;

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
