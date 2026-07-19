# Custom packages: overlaid onto nixpkgs for every host (pkgs.dracula-*) and
# exported as flake packages (nix build .#dracula-cursors). The package
# expressions are underscored so import-tree leaves them alone.
{ den, ... }:

let
  packages = pkgs: {
    dracula-cursors = import ./_dracula-cursors.nix { inherit pkgs; };
    dracula-papirus = import ./_dracula-papirus.nix {
      inherit pkgs;
      lib = pkgs.lib;
    };
  };
in
{
  den.aspects.base.nixos = {
    nixpkgs.overlays = [ (final: _prev: packages final) ];
  };

  perSystem =
    { pkgs, ... }:
    {
      packages = packages pkgs;
    };
}
