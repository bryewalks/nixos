# Offsite copy of storage: rclone pushes storageRoot straight to Dropbox's
# API (not through the local ~/Dropbox sync folder), so this box never holds
# a second local copy. Every machine running the dropbox-cli daemon excludes
# this remote path from its own local sync — see modules/features/dropbox.
{ den, lib, ... }:

{
  den.aspects.backups-dropbox =
    { host, ... }:
    lib.optionalAttrs (host ? storageRoot) {
      nixos =
        { pkgs, config, ... }:
        let
          dropboxRemotePath = "Backups/${host.hostName}/storage";
          dropboxDeletedPath = "Backups/${host.hostName}/storage-deleted";
        in
        {
          sops.secrets.rcloneDropbox = {
            owner = "root";
            mode = "0400";
          };

          systemd.services."rclone-dropbox-storage" = {
            unitConfig.RequiresMountsFor = [ host.storageRoot ];
            after = [ "network-online.target" ];
            wants = [ "network-online.target" ];
            serviceConfig = {
              Type = "oneshot";
              ExecStart = ''
                ${lib.getExe pkgs.rclone} sync ${host.storageRoot} "dropbox:${dropboxRemotePath}" \
                  --config ${config.sops.secrets.rcloneDropbox.path} \
                  --backup-dir "dropbox:${dropboxDeletedPath}" \
                  --exclude ".btrbk/**" \
                  --exclude ".Trash-1000/**" \
                  --exclude "**/Thumbs.db" \
                  --exclude "**/.DS_Store"
              '';
            };
          };

          systemd.timers."rclone-dropbox-storage" = {
            wantedBy = [ "timers.target" ];
            timerConfig = {
              OnCalendar = "Mon *-*-* 03:00:00";
              Persistent = true;
            };
          };
        };
    };
}
