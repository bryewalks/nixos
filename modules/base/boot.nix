{ den, ... }:

{
  den.aspects.base.nixos = {
    boot = {
      loader.efi.canTouchEfiVariables = true;
      loader.systemd-boot.enable = true;
      loader.grub.enable = false;
      loader.timeout = 0; # Hold space to access NixOS Selection screen
    };
  };
}
