{ den, ... }:

{
  den.aspects.base.nixos =
    { config, ... }:
    {
      security.sudo = {
        wheelNeedsPassword = true;
        extraConfig = ''
          Defaults lecture = never
        '';
      };
      security.polkit.enable = true;

      services.openssh.enable = config.mySystem.isPasswordConfigured;
    };
}
