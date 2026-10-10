{ den, inputs, ... }:

{
  flake-file.inputs.nixdatifier = {
    url = "github:Muddyblack/nixdatifier";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.workstation.includes = [ den.aspects.nixdatifier ];

  den.aspects.nixdatifier =
    { host, ... }:
    let
      flakePath = "/home/brye/nixos";
      secretsSourcePath = "${flakePath}/modules/hosts/${host.hostName}/_config/secrets.yaml";
    in
    {
      provides.to-users.homeManager =
        {
          config,
          hyprlandLib,
          pkgs,
          ...
        }:
        let
          inherit (hyprlandLib) startupHook;
          inherit (config.theme) palette hexNoHash;
          # Display only in waybar
          nixdatifier =
            (inputs.nixdatifier.packages.${pkgs.stdenv.hostPlatform.system}.nixdatifier).overrideAttrs
              (old: {
                postPatch = (old.postPatch or "") + ''
                  substituteInPlace Host.cpp --replace-fail 'tray.show();' ""
                '';
              });
        in
        {
          home.packages = [ nixdatifier ];

          wayland.windowManager.hyprland.settings = {
            on = [
              (startupHook ''hl.exec_cmd("${nixdatifier}/bin/nixdatifier --background")'')
            ];

            # Displays as a popup
            window_rule = [
              {
                name = "nixdatifier-popup";
                match.class = "^nixdatifier$";
                float = true;
                move = [
                  8
                  42
                ];
                size = [
                  600
                  740
                ];
              }
            ];
          };

          xdg.configFile."nixdatifier/standalone.json".text = builtins.toJSON {
            timelineColor = palette.currentLine;
            accentColor = palette.purple;
            useSystemTextColor = false;
            customTextColor = palette.foreground;
            bgColor = "#f2${hexNoHash.background}";
            fontScale = 1.45;
            inherit flakePath secretsSourcePath;
            secretsPath = "/run/secrets";
            maxGenerations = 25;
            customCommands = builtins.toJSON [
              {
                label = "update";
                cmd = "nh os switch --update";
              }
              {
                label = "switch";
                cmd = "nh os switch";
              }
              {
                label = "write";
                cmd = "nix run .#write-flake";
              }
              {
                label = "configure";
                cmd = "nvim .";
              }
            ];
          };
        };
    };
}
