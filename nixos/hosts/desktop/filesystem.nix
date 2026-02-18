{ pkgs, ... }:

{
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=4G" "mode=755" ];
  };

  fileSystems."/mnt/backups" =
    { device = "/dev/disk/by-uuid/6a00b2b5-0b14-4493-9220-a2c104c040ea";
      fsType = "btrfs";
      options = [ "subvol=@" "nofail" "x-systemd.automount" ];
    };

  fileSystems."/mnt/storage" =
    { device = "/dev/disk/by-uuid/e5de8def-8061-489b-b2c0-97ab0b69dc42";
      fsType = "btrfs";
      options = [ "subvol=@" "nofail" "x-systemd.automount" ];
    };

  fileSystems."/mnt/storagehdd" =
    { device = "/dev/disk/by-uuid/3bde75e9-a1a5-4d00-8574-785d4ddf5a1a";
      fsType = "btrfs";
      options = [ "subvol=@" "nofail" "x-systemd.automount" ];
    };

  swapDevices = [
    {
      device = "/persist/swap/swapfile";
      size = 16 * 1024;
    }
  ];

  systemd.tmpfiles.rules = [
    "d /persist/swap 0755 root root -"
  ];

  system.activationScripts.persistSwapBtrfs = ''
    if [ -d /persist/swap ]; then
      ${pkgs.e2fsprogs}/bin/chattr +C /persist/swap || true
      ${pkgs.btrfs-progs}/bin/btrfs property set /persist/swap compression none || true
    fi
  '';
}
