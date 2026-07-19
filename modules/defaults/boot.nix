# Universal defaults (see den.default): each file in this directory defines
# one aspect and registers it into den.default, which den injects into every
# host automatically.
{ den, ... }:

{
  den.default.includes = [ den.aspects.boot ];

  den.aspects.boot.nixos = {
    boot = {
      loader.efi.canTouchEfiVariables = true;
      loader.systemd-boot.enable = true;
      loader.grub.enable = false;
      loader.timeout = 0; # Hold space to access NixOS Selection screen
    };
  };
}
