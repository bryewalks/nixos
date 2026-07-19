# Repo-wide formatting via treefmt: `nix fmt` formats, and the treefmt check
# (part of `nix flake check`) fails on unformatted files.
{ inputs, ... }:

{
  imports = [ inputs.treefmt-nix.flakeModule ];

  flake-file.inputs.treefmt-nix = {
    url = "github:numtide/treefmt-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    programs.nixfmt.enable = true;
  };
}
