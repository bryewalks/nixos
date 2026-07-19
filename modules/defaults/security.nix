{ den, ... }:

{
  den.default.includes = [ den.aspects.security ];

  den.aspects.security.nixos =
    { config, lib, ... }:
    {
      options.mySystem.isPasswordConfigured = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };

      config = {
        security.sudo = {
          wheelNeedsPassword = true;
          extraConfig = ''
            Defaults lecture = never
          '';
        };
        security.polkit.enable = true;

        services.openssh.enable = config.mySystem.isPasswordConfigured;

        # Accounts themselves live with the user entities (modules/users/*).
        users.mutableUsers = false;
      };
    };
}
