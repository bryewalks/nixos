{ lib, pkgs, ... }:

let
  withGamemode = attrs: lib.recursiveUpdate attrs {
    launchOptions.wrappers = [ (lib.getExe pkgs.gamemode) ] ++ (attrs.launchOptions.wrappers or []);
  };

  apps = {
    counter-strike_2 = {
      id = 730;
    };
    super_battle_golf = {
      id = 4069520;
      compatTool = "GE-Proton";
    };
  };
in
{
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        PROTON_ENABLE_WAYLAND = "1";
      };
    };
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
  };

  programs.steam.config = {
    enable = true;
    closeSteam = true;
    defaultCompatTool = "GE-Proton";

    apps = builtins.mapAttrs (_: withGamemode) apps;
  };
}
