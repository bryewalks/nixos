{ config, pkgs, ... }:

let persistRoot = "/persist";
in {
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
    ];
    files = [ "/etc/machine-id" ];
  };

  fileSystems."${persistRoot}".neededForBoot = true;
}
