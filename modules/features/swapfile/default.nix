{ den, ... }:

{
  den.aspects.workstation.includes = [ den.aspects.swapfile ];

  # Hosts opt in via the swapSizeGiB capability; absence = no swapfile.
  den.aspects.swapfile.nixos =
    {
      host,
      lib,
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
    };
}
