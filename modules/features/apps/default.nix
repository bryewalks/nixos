{ den, ... }:

{
  den.aspects.workstation.includes = [ den.aspects.apps ];

  den.aspects.apps = {
    nixos = {
      unfree.packages = [
        "discord"
        "discord-unwrapped"
      ];

      # bitwarden-desktop pins an electron marked insecure upstream.
      permittedInsecurePackages.packages = [ "electron-39.8.10" ];
    };

    provides.to-users.homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          bitwarden-desktop
          # xwayland: native wayland ozone breaks discord's global keybinds (push to talk)
          (discord.override { commandLineArgs = "--ozone-platform=x11"; })
        ];
      };
  };
}
