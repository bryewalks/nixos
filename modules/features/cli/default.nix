{ den, ... }:

{
  den.aspects.features.includes = [ den.aspects.cli ];

  den.aspects.cli.provides.to-users.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        cmatrix
        cmus
        fastfetch
        fd
        lsd
        ripgrep
        stow
        unzip
        yazi
      ];

      services.udiskie = {
        enable = true;
        automount = true;
      };
    };
}
