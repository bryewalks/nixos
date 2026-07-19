{ den, ... }:

{
  den.aspects.cli.provides.to-users.homeManager = {
    programs.git = {
      enable = true;
      settings.user.name = "bryewalks";
      settings.user.email = "bryewalks@gmail.com";
      settings.safe.directory = [ "/etc/nixos" ];
    };
  };
}
