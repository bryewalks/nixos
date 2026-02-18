{ pkgs, ... }:

let
  swapfile = "/persist/swap/swapfile";
  swapSize = "16G";
in
{
  systemd.services.persist-swapfile = {
    description = "Create /persist swapfile if missing";
    wantedBy = [ "swap.target" ];
    before = [ "persist-swap-swapfile.swap" "swap.target" ];
    unitConfig.RequiresMountsFor = [ "/persist" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "persist-swapfile-create" ''
        set -euo pipefail

        if [ -f "${swapfile}" ]; then
          exit 0
        fi

        install -d -m 0755 /persist/swap
        # Ensure NOCOW is set for btrfs.
        chattr +C /persist/swap || true

        if command -v btrfs >/dev/null 2>&1; then
          btrfs filesystem mkswapfile --size ${swapSize} "${swapfile}"
        else
          dd if=/dev/zero of="${swapfile}" bs=1M count=16384
          chmod 600 "${swapfile}"
          mkswap "${swapfile}"
        fi
      '';
    };

    path = [
      pkgs.btrfs-progs
      pkgs.coreutils
      pkgs.e2fsprogs
      pkgs.util-linux
    ];
  };
}
