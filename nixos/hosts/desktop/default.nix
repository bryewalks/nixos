{ pkgs, ... }:

{
  networking.hostName = "desktop";

  disabledModules = [ ../../modules/plymouth/default.nix ];

  # Needed for stremio
  services.flatpak.enable = true;

  sops.defaultSopsFile = ./secrets.yaml;

  # CachyOS Kernel
  nix.settings.substituters = [ 
    "https://attic.xuyh0120.win/lantian"
    "https://cache.garnix.io"
  ];
  nix.settings.trusted-public-keys = [
    "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
  ];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
}
