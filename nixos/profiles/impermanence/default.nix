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
  # on every boot. This runs in the initrd before the real root is mounted.
  boot.initrd.systemd.enable = true;

  boot.initrd.systemd.services.rollback-root = {
    description = "Rollback Btrfs root subvolume (@ -> @blank)";
    wantedBy = [ "initrd.target" ];
    before = [ "sysroot.mount" ];
    after = [ "initrd-root-device.target" ];
    unitConfig.DefaultDependencies = "no";

    serviceConfig.Type = "oneshot";

    script = ''
      set -eu

      device="${config.fileSystems."/".device}"
      mount_bin="${pkgs.util-linux}/bin/mount"
      umount_bin="${pkgs.util-linux}/bin/umount"
      btrfs_bin="${pkgs.btrfs-progs}/bin/btrfs"
      awk_bin="${pkgs.gawk}/bin/awk"
      sort_bin="${pkgs.coreutils}/bin/sort"

      mkdir -p /mnt
      "$mount_bin" -o subvolid=5 "$device" /mnt

      # Delete nested subvolumes first, then the root subvolume itself.
      if [ -d /mnt/@ ]; then
        "$btrfs_bin" subvolume list -o /mnt/@ | "$awk_bin" '{print $9}' | "$sort_bin" -r | while read -r sv; do
          "$btrfs_bin" subvolume delete "/mnt/$sv"
        done
        "$btrfs_bin" subvolume delete /mnt/@
      fi

      "$btrfs_bin" subvolume snapshot /mnt/@blank /mnt/@

      "$umount_bin" /mnt
    '';
  };
}
