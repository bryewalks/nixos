# Phone integration (KDE Connect protocol via valent).
{ den, ... }:

{
  den.aspects.apps.nixos =
    { pkgs, ... }:
    {
      programs.kdeconnect = {
        enable = true;
        package = pkgs.valent;
      };

      environment.systemPackages = [ pkgs.glib ];
    };
}
