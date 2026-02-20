{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    # INFO: Use patched version to support cachyos 6.19 until open fix.
    # https://github.com/NVIDIA/open-gpu-kernel-modules/issues/1021
    # https://github.com/NixOS/nixpkgs/issues/489947
    # package = config.boot.kernelPackages.nvidiaPackages.stable;
    package =
      let
        base = config.boot.kernelPackages.nvidiaPackages.latest;
        cachyos-nvidia-patch = pkgs.fetchpatch {
          url = "https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/nvidia/nvidia-utils/kernel-6.19.patch";
          sha256 = "sha256-YuJjSUXE6jYSuZySYGnWSNG5sfVei7vvxDcHx3K+IN4=";
        };

        # Patch the appropriate driver based on config.hardware.nvidia.open
        driverAttr = if config.hardware.nvidia.open then "open" else "bin";
      in
      base
      // {
        ${driverAttr} = base.${driverAttr}.overrideAttrs (oldAttrs: {
          patches = (oldAttrs.patches or [ ]) ++ [ cachyos-nvidia-patch ];
        });
      };
  };
}
