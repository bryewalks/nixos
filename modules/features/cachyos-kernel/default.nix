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
        "https://attic.xuyh0120.win/lantian"
        "https://cache.xinux.uz"
      ];
      nix.settings.trusted-public-keys = [
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0="
      ];
    };
}
