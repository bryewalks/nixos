# Sops infrastructure only — per-user secrets live with their user
# (see modules/users/brye). defaultSopsFile is set per-host.
{ den, inputs, ... }:

{
  den.aspects.features.includes = [ den.aspects.sops ];

  den.aspects.sops.nixos =
    { config, ... }:
    let
      sopsDir = "${config.mySystem.persistRoot}/system/var/lib/sops";
    in
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];

      sops = { age.keyFile = "${sopsDir}/keys.txt"; };

      systemd.tmpfiles.rules = [
        "d ${sopsDir} 0755 root root -"
      ];
    };
}
