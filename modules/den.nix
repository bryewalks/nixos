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

      # BUG: commit dd59a4c ("migrate to gen-schema's options-first API")
      # introduced infinite recursion evaluating den.default.includes.
      # Unpin once den ships a fix past that commit.
      den.url = "github:denful/den/65c9fd40e958109f5a352c1a93ae8254bf1ed29f";

      # Consumed by den's home-manager battery.
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };
  };
}
