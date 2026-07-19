{ den, ... }:

{
  den.aspects.workstation.includes = [ den.aspects.docker ];

  den.aspects.docker = {
    nixos =
      { pkgs, ... }:
      {
        virtualisation.docker.enable = true;

        environment.systemPackages = [ pkgs.docker-compose ];
      };

    provides.to-users.homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.lazydocker ];
      };
  };
}
