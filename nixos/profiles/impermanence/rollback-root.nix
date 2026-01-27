{ config, lib, pkgs, ... }:

let
  # Derive the underlying Btrfs device from a persistent mount when possible.
  # This avoids hard-coding the LUKS mapper name.
  btrfsDevice =
    config.fileSystems."/persist".device
      or config.fileSystems."/nix".device
      or "/dev/mapper/cryptroot";
  rootSubvol = "@";
  blankSubvol = "@root-blank";
  marker = "/persist/system/.root-blank-created";
in
{
  # Ensure persistent mounts are available during early boot.
  fileSystems."/nix".neededForBoot = true;
  fileSystems."/persist".neededForBoot = true;

  # Roll back / from @root-blank before the real root is mounted.
  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.services.rollback-root = {
    description = "Rollback Btrfs root subvolume";
    wantedBy = [ "initrd.target" ];
    # Ensure the root device exists first (works across different mapper names).
    wants = [ "initrd-root-device.target" ];
    after = [ "initrd-root-device.target" ];
    before = [ "sysroot.mount" ];
    unitConfig.DefaultDependencies = "no";

    serviceConfig = {
      Type = "oneshot";
    };

    path = [
      pkgs.btrfs-progs
      pkgs.util-linux
      pkgs.coreutils
      pkgs.gawk
    ];

    script = ''
      set -eux

      echo "rollback-root: starting" > /dev/kmsg || true

      mkdir -p /mnt
      mount -t btrfs -o subvolid=5 ${btrfsDevice} /mnt

      if [ ! -d /mnt/${blankSubvol} ]; then
        echo "Missing /mnt/${blankSubvol}; refusing to wipe root."
        echo "rollback-root: missing ${blankSubvol}" > /dev/kmsg || true
        umount /mnt
        exit 1
      fi

      if [ -d /mnt/${rootSubvol} ]; then
        # Delete nested subvolumes first, then the root subvolume itself.
        btrfs subvolume list -o /mnt/${rootSubvol} \
          | awk '{print $9}' \
          | sort -r \
          | while read -r subvol; do
              btrfs subvolume delete "/mnt/$subvol"
            done
        btrfs subvolume delete /mnt/${rootSubvol}
      fi

      btrfs subvolume snapshot /mnt/${blankSubvol} /mnt/${rootSubvol}
      echo "rollback-root: snapshot restored" > /dev/kmsg || true
      umount /mnt
    '';
  };

  # Create the initial blank snapshot once, after /persist is mounted.
  systemd.services.create-root-blank = {
    description = "Create initial Btrfs @root-blank snapshot (run once)";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];

    # Skip if we've already created it via the marker.
    unitConfig.ConditionPathExists = "!${marker}";

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    path = [
      pkgs.btrfs-progs
      pkgs.util-linux
      pkgs.coreutils
    ];

    script = ''
      set -eux

      mkdir -p /btrfs
      mount -t btrfs -o subvolid=5 ${btrfsDevice} /btrfs

      if [ -d /btrfs/${blankSubvol} ]; then
        echo "${blankSubvol} already exists; refusing to run."
        umount /btrfs
        exit 0
      fi

      btrfs subvolume snapshot -r /btrfs/${rootSubvol} /btrfs/${blankSubvol}
      umount /btrfs

      mkdir -p "$(dirname ${marker})"
      touch ${marker}
    '';
  };
}
