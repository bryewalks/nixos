{ den, inputs, ... }:

{
  flake-file.inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.default.includes = [ den.aspects.disko ];

  den.aspects.disko.nixos = {
    imports = [ inputs.disko.nixosModules.disko ];
  };
}
