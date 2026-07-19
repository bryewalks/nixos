# Foundation shared by every host. Universal by definition — hosts include it
# directly, not via the features umbrella. Each file in this directory
# contributes one concern to den.aspects.base; this file holds the anchor
# pieces: disko, the mySystem options, home-manager integration, and
# account/release policy.
{ den, inputs, ... }:

{
  den.aspects.base.nixos =
    { config, lib, pkgs, ... }:
    {
      imports = [ inputs.disko.nixosModules.disko ];

      options.mySystem.isPasswordConfigured = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };

      options.mySystem.allowedUnfree = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Unfree package names allowed; each aspect appends its own.";
      };

      config = {
        nixpkgs.config.allowUnfreePredicate =
          pkg: builtins.elem (lib.getName pkg) config.mySystem.allowedUnfree;

        # Users (accounts themselves live with the user entities, modules/users/*)
        users.mutableUsers = false;

        # home-manager integration (the HM NixOS module itself is wired by den).
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            inherit inputs;
          };
        };

        # Tools available outside home-manager — root shells, TTYs, rescue work.
        environment.systemPackages = with pkgs; [
          neovim
          kitty
          lshw
        ];

        # NixOS release compatibility
        system.stateVersion = "25.11";
      };
    };
}
