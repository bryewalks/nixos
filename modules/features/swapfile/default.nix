{ den, ... }:

{
  den.aspects.workstation.includes = [ den.aspects.swapfile ];

  # Hosts opt in via the swapSizeGiB capability; absence = no swapfile.
  den.aspects.swapfile.nixos =
    {
      host,
      lib,
      pkgs,
      ...
    }:
    let
      path = "${host.persistRoot}/swap/swapfile";
      swapDir = builtins.dirOf path;
    in
    lib.optionalAttrs (host ? swapSizeGiB) {
      boot.initrd.systemd.enable = true;

      systemd.tmpfiles.rules = [
        "d ${swapDir} 0755 root root -"
      ];

      swapDevices = [
        {
          device = path;
          size = host.swapSizeGiB * 1024;
          priority = 100;
        }
      ];

      system.activationScripts.ensureBtrfsSwapfile.text = ''
        set -euo pipefail

        mkdir -p ${swapDir}

        # Only apply btrfs hints if the swap directory lives on btrfs
        if ${pkgs.util-linux}/bin/findmnt -n -o FSTYPE --target ${swapDir} \
          | ${pkgs.gnugrep}/bin/grep -qx btrfs; then
          ${pkgs.e2fsprogs}/bin/chattr +C ${swapDir} || true
        fi

        if [ ! -e ${path} ]; then
          ${pkgs.btrfs-progs}/bin/btrfs filesystem mkswapfile --size ${toString host.swapSizeGiB}g ${path}
        fi

        # mkswap is harmless if already a swap signature; swapon is harmless if already active
        ${pkgs.util-linux}/bin/mkswap ${path} >/dev/null 2>&1 || true
        ${pkgs.util-linux}/bin/swapon ${path} 2>/dev/null || true
      '';
    };
}
