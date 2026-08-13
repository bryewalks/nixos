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
    (hyprshot.override {
      hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    })
    jq
    libnotify
    networkmanagerapplet
    pavucontrol
    playerctl
    slurp
    swaynotificationcenter
    # INFO: wf-recorder 0.6.0 fails to build against ffmpeg 8 (AVCodec.sample_fmts
    # was removed from the public API). Pinned to ffmpeg_7 until wf-recorder
    # or nixpkgs patches it upstream - remove this override once that lands.
    (wf-recorder.override { ffmpeg = pkgs.ffmpeg_7; })
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
