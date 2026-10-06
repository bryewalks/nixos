# Steam, its compat tools, gamemode wrapping, and per-game launch configs.
{ den, inputs, ... }:

{
  flake-file.inputs.steam-config-nix = {
    url = "github:different-name/steam-config-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.gaming.includes = [ den.aspects.steam ];

  den.aspects.steam.nixos =
    { lib, pkgs, ... }:
    let
      withGamemode =
        attrs:
        lib.recursiveUpdate attrs {
          wrappers = [ (lib.getExe pkgs.gamemode) ] ++ (attrs.wrappers or [ ]);
        };

      apps = {
        "730" = {
          name = "counter-strike_2";
          # 1600 mouse dpi x 0.49 sens = (784 edpi)
          files.game.place."game/csgo/cfg/autoexec.cfg".text = ''
            sensitivity "0.49"
            cl_crosshair_code "CSGO-oMKyb-aop54-Ufc8T-ByO5z-DKOMB"
            cl_righthand "0"

            mm_dedicated_search_maxping "25"

            unbind "mwheelup"
            unbind "mwheeldown"

            bind "z" "slot7; buy flashbang"
            bind "x" "slot8; buy smokegrenade"
            bind "c" "slot6; buy hegrenade"
            bind "v" "slot10; buy incgrenade; buy molotov"
          '';
        };
        "4069520" = {
          name = "super_battle_golf";
          compatTool = "GE-Proton";
        };
      };
    in
    {
      imports = [ inputs.steam-config-nix.nixosModules.default ];

      unfree.packages = [
        "steam"
        "steam-unwrapped"
      ];

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
        onSteamRunning = "close";
        defaultCompatTool = "GE-Proton";

        apps = builtins.mapAttrs (_: withGamemode) apps;
      };
    };
}
