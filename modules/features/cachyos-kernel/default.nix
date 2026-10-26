{ den, inputs, ... }:

{
  flake-file.inputs.nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

  den.aspects.cachyos-kernel.nixos =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore;

      # Binary caches for the prebuilt kernel; without these it compiles
      # from source. https://github.com/xddxdd/nix-cachyos-kernel
      nix.settings.substituters = [
        "https://cache.lantian.pub/lantian"
      ];
      nix.settings.trusted-public-keys = [
        "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="
      ];
    };
}
