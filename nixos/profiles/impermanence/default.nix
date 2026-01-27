{ config, pkgs, ... }:

let
  persistRoot = "/persist";
in
{
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    echo "Rollback running" > /mnt/rollback.log
     mkdir -p /mnt
     mount -t btrfs /dev/mapper/cryptroot /mnt

     # Recursively delete all nested subvolumes inside /mnt/root
     btrfs subvolume list -o /mnt/@ | cut -f9 -d' ' | while read subvolume; do
       echo "Deleting /$subvolume subvolume..." >> /mnt/rollback.log
       btrfs subvolume delete "/mnt/$subvolume"
     done

     echo "Deleting @ subvolume..." >> /mnt/rollback.log
     btrfs subvolume delete /mnt/@

     echo "Restoring @blank subvolume..." >> /mnt/rollback.log
     btrfs subvolume snapshot /mnt/@blank /mnt/@

     umount /mnt
  '';

  environment.persistence."${persistRoot}/system" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/sops"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  fileSystems."${persistRoot}".neededForBoot = true;
}
