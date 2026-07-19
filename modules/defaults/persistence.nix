# persistRoot is conceptually impermanence's, but declaring it here keeps
# sops/swapfile evaluable on a host without the impermanence feature.
{ den, ... }:

{
  den.default.includes = [ den.aspects.persistence ];

  den.aspects.persistence.nixos =
    { lib, ... }:
    {
      options.mySystem.persistRoot = lib.mkOption {
        type = lib.types.str;
        default = "/persist";
        description = "Root of the impermanence persistence tree; consumed by impermanence, sops, and swapfile. Must match the host's disko mountpoint.";
      };
    };
}
