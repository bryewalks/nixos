{ den, ... }:

{
  den.aspects.features.includes = [ den.aspects.apps ];

  den.aspects.apps.provides.to-users.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        bitwarden-desktop
        discord
        dropbox-cli
      ];
    };
}
