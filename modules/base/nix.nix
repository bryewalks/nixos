{ den, inputs, ... }:

{
  flake-file.inputs.nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

  den.aspects.base.nixos = {
    nixpkgs.overlays = [
      inputs.nix-cachyos-kernel.overlays.pinned
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.auto-optimise-store = true;

    # Required for nix flake operations
    programs.git.enable = true;

    # nh's flake path is set by the user entity that owns the checkout
    # (modules/users/brye).
    programs.nh = {
      enable = true;
      # Auto garbage collect
      clean = {
        enable = true;
        dates = "daily";
        extraArgs = "--keep-since 3d --keep 5";
      };
    };
  };
}
