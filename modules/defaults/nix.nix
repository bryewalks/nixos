{ den, inputs, ... }:

{
  flake-file.inputs.nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

  den.default.includes = [ den.aspects.nix ];

  den.aspects.nix.nixos =
    { config, lib, ... }:
    {
      options.mySystem.allowedUnfree = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Unfree package names allowed; each aspect appends its own.";
      };

      config = {
        nixpkgs.config.allowUnfreePredicate =
          pkg: builtins.elem (lib.getName pkg) config.mySystem.allowedUnfree;

        nixpkgs.overlays = [
          inputs.nix-cachyos-kernel.overlays.pinned
        ];

        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
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

        # NixOS release compatibility
        system.stateVersion = "25.11";
      };
    };
}
