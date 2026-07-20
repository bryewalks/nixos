{ den, inputs, ... }:

{
  flake-file.inputs.steam-config-nix = {
    url = "github:different-name/steam-config-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.workstation.includes = [ den.aspects.gaming ];

  den.aspects.gaming = {
    nixos =
      { lib, pkgs, ... }:
      let
        withGamemode =
          attrs:
          lib.recursiveUpdate attrs {
            launchOptions.wrappers = [ (lib.getExe pkgs.gamemode) ] ++ (attrs.launchOptions.wrappers or [ ]);
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

    provides.to-users.homeManager =
      { config, pkgs, ... }:
      let
        palette = config.theme.hexNoHash;
      in
      {
        home.packages = with pkgs; [
          mangohud
        ];

        programs.mangohud = {
          enable = true;
          enableSessionWide = true;
        };

        xdg.configFile."MangoHud/MangoHud.conf".text = ''
          legacy_layout=false
          position=top-right
          round_corners=10
          background_alpha=0.8
          background_color=${palette.background}
          table_columns=3

          ## Text ##
          font_size=18
          text_color=${palette.foreground}
          text_outline_color=${palette.selection}

          ## GPU ##
          gpu_text=GPU
          gpu_stats
          gpu_temp
          gpu_color=${palette.green}
          gpu_load_change
          gpu_load_color=${palette.green},${palette.yellow},${palette.red}

          ## CPU ##
          cpu_text=CPU
          cpu_stats
          cpu_temp
          cpu_color=${palette.cyan}
          cpu_load_change
          cpu_load_color=${palette.green},${palette.yellow},${palette.red}

          ## RAM ##
          ram
          ram_color=${palette.magenta}

          ## FPS ##
          fps
          fps_color_change
          fps_color=${palette.red},${palette.yellow},${palette.green}

          ## ENGINE ##
          engine_color=${palette.purple}

          ## Frame timing ##
          frame_timing
          frametime_color=${palette.green}

          arch
          fps_limit_method=early
          toggle_fps_limit=Shift_L+F1

          ## Wine ##
          wine
          wine_color=${palette.purple}
        '';
      };
  };
}
