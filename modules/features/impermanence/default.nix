{ den, inputs, ... }:

{
  den.aspects.features.includes = [ den.aspects.impermanence ];

  den.aspects.impermanence.nixos =
    { config, ... }:
    let
      persistRoot = config.mySystem.persistRoot;
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
