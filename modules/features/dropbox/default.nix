{ den, ... }:

let
  # Top-level folders that backup jobs push into the Dropbox account directly
  # (rclone, not this client) — excluding the whole "Backups" tree here means
  # any new backup target added under it is covered without touching this
  # list. Excluded from local sync so this daemon doesn't pull them back down
  # onto every machine that runs it.
  excludedRemotePaths = [
    "Backups"
  ];
in
{
  den.aspects.workstation.includes = [ den.aspects.dropbox ];

  den.aspects.dropbox = {
    nixos = {
      unfree.packages = [ "dropbox" ];
    };

    provides.to-users.homeManager =
      { pkgs, lib, ... }:
      {
        home.packages = with pkgs; [
          dropbox-cli
        ];

        systemd.user.services.dropbox = {
          Unit = {
            Description = "Dropbox";
            After = [
              "graphical-session.target"
              "dbus.service"
            ];
            Wants = [ "graphical-session.target" ];
          };

          Service = {
            Type = "forking";
            ExecStart = "${pkgs.dropbox-cli}/bin/dropbox start";
            ExecStop = "${pkgs.dropbox-cli}/bin/dropbox stop";
            Restart = "on-failure";
            RestartSec = 3;
            ExecStartPre = "${pkgs.coreutils}/bin/sleep 15";
          };

          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };

        systemd.user.services.dropbox-exclude-backup-folders = {
          Unit = {
            Description = "Exclude backup folders from Dropbox local sync";
            After = [ "dropbox.service" ];
            PartOf = [ "dropbox.service" ];
          };

          Service = {
            Type = "oneshot";
            ExecStart = pkgs.writeShellScript "dropbox-exclude-backup-folders" ''
              set -e
              for i in $(seq 1 30); do
                if ${lib.getExe pkgs.dropbox-cli} exclude add ${
                  lib.concatMapStringsSep " " (path: ''"$HOME/Dropbox/${path}"'') excludedRemotePaths
                }; then
                  exit 0
                fi
                sleep 2
              done
              echo "dropbox exclude add failed after retries" >&2
              exit 1
            '';
          };

          Install = {
            WantedBy = [ "dropbox.service" ];
          };
        };
      };
  };
}
