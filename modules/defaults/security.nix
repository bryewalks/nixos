{ den, ... }:

{
  den.default.includes = [ den.aspects.security ];

  den.aspects.security.nixos =
    { host, ... }:
    {
      security.sudo = {
        wheelNeedsPassword = true;
        extraConfig = ''
          Defaults lecture = never
        '';
      };
      security.polkit.enable = true;

      # Hosts declare the passwordConfigured capability once their real
      # password + sops secrets exist; until then they stay bootstrap-safe.
      services.openssh.enable = host.passwordConfigured or false;

      # Accounts themselves live with the user entities (modules/users/*).
      users.mutableUsers = false;
    };
}
