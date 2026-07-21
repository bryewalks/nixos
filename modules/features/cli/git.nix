{ den, ... }:

{
  den.aspects.cli.provides.to-users.homeManager = {
    programs.git = {
      enable = true;
      settings.safe.directory = [ "/etc/nixos" ];
    };
  };
}
