{ pkgs, ... }:

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
}
