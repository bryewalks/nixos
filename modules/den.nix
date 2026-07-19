{ inputs, lib, ... }:

{
  imports = [
    inputs.den.flakeModule
    # flake.nix is generated: modules declare their own inputs via
    # flake-file.inputs; regenerate with `nix run .#write-flake`.
    inputs.flake-file.flakeModules.dendritic
  ];

  systems = [ "x86_64-linux" ];

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  flake-file = {
    description = "Brye's NixOS";

    # Generated flake.nix style: blank line between inputs, nixpkgs listed first.
    style = {
      sep.inputs = "\n\n";
      sortPriority.inputs = [ "nixpkgs" ];
    };

    # Core inputs no single feature owns. flake-parts, import-tree, and
    # flake-file itself come from the dendritic flakeModule's defaults.
    inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

      den.url = "github:denful/den";

      # Consumed by den's home-manager battery.
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };
  };
}
