{ den, inputs, ... }:

{
  flake-file.inputs.impermanence = {
    url = "github:nix-community/impermanence";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.workstation.includes = [ den.aspects.impermanence ];

  den.aspects.impermanence.nixos =
    { host, ... }:
    let
      # Bare read (no fallback): a host without the persistRoot capability
      # should fail eval, not silently persist somewhere else.
      persistRoot = host.persistRoot;
    in
    {
      imports = [ inputs.impermanence.nixosModules.impermanence ];

      environment.persistence."${persistRoot}/system" = {
        hideMounts = true;
        directories = [
          "/etc/NetworkManager/system-connections"
          "/etc/ssh"
          "/var/cache/steam"
          "/var/cache/fontconfig"
          "/var/lib/docker"
          "/var/lib/nixos"
          "/var/lib/nvidia-persistenced"
          "/var/lib/sddm"
          "/var/lib/steam"
          "/var/lib/sops"
          "/var/lib/systemd/coredump"
          "/var/log"
          "/var/tmp"
        ];
        files = [ "/etc/machine-id" ];
      };

      fileSystems.${persistRoot}.neededForBoot = true;
    };
}
