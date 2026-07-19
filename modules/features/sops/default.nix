# Sops infrastructure only — per-user secrets live with their user
# (see modules/users/brye). defaultSopsFile is set per-host.
{ den, inputs, ... }:

{
  den.aspects.features.includes = [ den.aspects.sops ];

  den.aspects.sops.nixos = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    sops = { age.keyFile = "/persist/system/var/lib/sops/keys.txt"; };

    systemd.tmpfiles.rules = [
      "d /persist/system/var/lib/sops 0755 root root -"
    ];
  };
}
