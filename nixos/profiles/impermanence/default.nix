{ config, pkgs, ... }:

let
  persistRoot = "/persist";
in
{
  environment.persistence."${persistRoot}/system" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib/nixos"
      "/var/lib/sddm"
      "/var/lib/sops"
      "/var/lib/systemd/coredump"
      "/var/log"
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  fileSystems."${persistRoot}".neededForBoot = true;
}
