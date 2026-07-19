{ den, ... }:

{
  den.aspects.features.includes = [ den.aspects.printing ];

  den.aspects.printing.nixos =
    { pkgs, ... }:
    {
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };

      services.printing = {
        enable = true;
        drivers = with pkgs; [
          cups-filters
          cups-browsed
        ];
      };

      environment.systemPackages = [ pkgs.system-config-printer ];
    };
}
