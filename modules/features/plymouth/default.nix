# Not registered into den.aspects.workstation: the desktop deliberately runs
# without plymouth, so only the laptop host includes this aspect.
{ den, ... }:

{
  den.aspects.plymouth.nixos =
    { pkgs, ... }:
    {
      boot = {
        initrd.verbose = false;
        initrd.systemd.enable = true;
        consoleLogLevel = 3;
        kernelParams = [
          "quiet"
          "splash"
          "intremap=on"
          "boot.shell_on_fail"
          "udev.log_priority=3"
          "rd.systemd.show_status=auto"
        ];

        plymouth = {
          enable = true;
          logo = "${pkgs.nixos-icons}/share/icons/hicolor/128x128/apps/nix-snowflake.png";
        };
      };
    };
}
