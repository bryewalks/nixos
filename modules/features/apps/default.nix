{ den, ... }:

{
  den.aspects.features.includes = [ den.aspects.apps ];

  den.aspects.apps.nixos = {
    mySystem.allowedUnfree = [ "discord" ];

    # bitwarden-desktop pins an electron marked insecure upstream.
    nixpkgs.config.permittedInsecurePackages = [
      "electron-39.8.10"
    ];
  };

  den.aspects.apps.provides.to-users.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        bitwarden-desktop
        discord
      ];
    };
}
