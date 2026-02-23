{ config, lib, pkgs, ... }:

let
  cfg = config.swapfile;
  swapDir = builtins.dirOf cfg.path;
in
{
  options.swapfile = {
    enable = lib.mkEnableOption "swapfile setup";

    sizeGiB = lib.mkOption {
      type = lib.types.int;
      default = 0;
      description = "Swap file size in GiB.";
    };

    path = lib.mkOption {
      type = lib.types.str;
      default = "/persist/swap/swapfile";
      description = "Swap file path.";
    };

    priority = lib.mkOption {
      type = lib.types.int;
      default = 100;
      description = "Swap priority.";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.sizeGiB > 0;
        message = "swapfile.sizeGiB must be greater than 0 when swapfile is enabled.";
      }
    ];

    boot.initrd.systemd.enable = true;

    systemd.tmpfiles.rules = [
      "d ${swapDir} 0755 root root -"
    ];

    swapDevices = [{
      device = cfg.path;
      size = cfg.sizeGiB * 1024;
      priority = cfg.priority;
    }];

    system.activationScripts.ensureBtrfsSwapfile.text = ''
      set -euo pipefail

      mkdir -p ${swapDir}

      # Only apply btrfs hints if the swap directory lives on btrfs
      if ${pkgs.util-linux}/bin/findmnt -n -o FSTYPE --target ${swapDir} \
        | ${pkgs.gnugrep}/bin/grep -qx btrfs; then
        ${pkgs.e2fsprogs}/bin/chattr +C ${swapDir} || true
      fi

      if [ ! -e ${cfg.path} ]; then
        ${pkgs.btrfs-progs}/bin/btrfs filesystem mkswapfile --size ${toString cfg.sizeGiB}g ${cfg.path}
      fi

      # mkswap is harmless if already a swap signature; swapon is harmless if already active
      ${pkgs.util-linux}/bin/mkswap ${cfg.path} >/dev/null 2>&1 || true
      ${pkgs.util-linux}/bin/swapon ${cfg.path} 2>/dev/null || true
    '';
  };
}
