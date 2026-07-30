{ den, ... }:

{
  den.aspects.backups.nixos =
    { host, lib, ... }:
    {
      # Only storage gets an offsite copy: it's the sole copy of real (irreplaceable) files.
      services.btrbk.instances = lib.optionalAttrs (host ? backupRoot && host ? storageRoot) {
        storage = {
          onCalendar = "*-*-* 01:00:00";
          settings = {
            snapshot_preserve_min = "latest"; # only need a parent for the next incremental
            target_preserve_min = "no";
            target_preserve = "14d 8w 12m 2y";
            subvolume."${host.storageRoot}" = {
              target = "${host.backupRoot}/storage";
              # No `volume` section (subvolume path is absolute), so there's
              # no default snapshot_dir to fall back on; must be explicit.
              snapshot_dir = "${host.storageRoot}/.btrbk";
            };
          };
        };
      };

      # btrbk requires its snapshot_dir, and its exact target directory, to
      # already exist on first run — it doesn't create either itself.
      # snapshot_dir is an internal staging area (root-only); the target is
      # the actual backup copy, world-readable so it can be browsed/verified
      # without sudo — it's the same data already accessible at storageRoot.
      systemd.tmpfiles.rules = lib.optionals (host ? backupRoot && host ? storageRoot) [
        "d ${host.storageRoot}/.btrbk 0700 root root -"
        "d ${host.backupRoot}/storage 0755 root root -"
      ];

      # backupRoot and storageRoot are x-systemd.automount + nofail (may not
      # be physically present); fail the backup run clearly rather than
      # have btrbk hit a raw missing-path error mid-script.
      systemd.services."btrbk-storage".unitConfig =
        lib.optionalAttrs (host ? backupRoot && host ? storageRoot)
          {
            RequiresMountsFor = [
              host.backupRoot
              host.storageRoot
            ];
          };
    };
}
