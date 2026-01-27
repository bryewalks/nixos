{ config, pkgs, ... }:

let
  persistRoot = "/persist";
in
{
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

  # Roll back the Btrfs root subvolume (@) to a clean snapshot (@blank)
  # on every boot. This runs in the initrd after devices are ready/unlocked.
  boot.initrd.extraUtilsCommands = ''
    copy_bin_and_libs ${pkgs.btrfs-progs}/bin/btrfs
  '';

  boot.initrd.postDeviceCommands = ''
    set -eu

    device="${config.fileSystems."/".device}"

    mkdir -p /mnt
    mount -o subvolid=5 "$device" /mnt

    # Delete nested subvolumes first, then the root subvolume itself.
    if [ -d /mnt/@ ]; then
      btrfs subvolume list -o /mnt/@ | awk '{print $9}' | sort -r | while read -r sv; do
        btrfs subvolume delete "/mnt/$sv"
      done
      btrfs subvolume delete /mnt/@
    fi

    btrfs subvolume snapshot /mnt/@blank /mnt/@

    umount /mnt
  '';
}
