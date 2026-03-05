{ osConfig, lib, pkgs, ... }:
let
  hostDir = ./hosts + "/${osConfig.networking.hostName}";
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
      ./plugins/hyprcursor
      ./plugins/hypridle
      ./plugins/hyprlock
      ./plugins/rofi
      ./plugins/wlogout
      ./plugins/waybar
      ./plugins/waypaper
      ./autostart.nix
    ]
    ++ lib.optional (builtins.pathExists hostModule) hostModule;

  home.packages = with pkgs; [
    brightnessctl
    hyprpicker
    hyprpolkitagent
    hyprshot
    jq
    networkmanagerapplet
    playerctl
    slurp
    swaynotificationcenter
    wf-recorder
    wireplumber
    wl-clipboard
    (python3.withPackages (ps: [ ps.requests ]))
  ];

  wayland.windowManager.hyprland.enable = true;

  xdg.configFile = {
    "hypr/scripts" = {
      source = ./scripts;
      recursive = true;
      executable = true;
    };
  };
}
