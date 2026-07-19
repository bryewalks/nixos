{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  _module.args.hyprlandLib = import ./lib.nix lib;
  imports = [
    ./vars.nix
    ./environment.nix
    ./input.nix
    ./keybindings.nix
    ./style.nix
    ./rules.nix
    (inputs.import-tree ./plugins)
    ./autostart.nix
  ];

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
  wayland.windowManager.hyprland.configType = "lua";

  xdg.configFile = {
    "hypr/scripts" = {
      source = ./scripts;
      recursive = true;
      executable = true;
    };
  };
}
