# home-manager integration (the HM NixOS module itself is wired by den).
{ den, inputs, ... }:

{
  den.default.includes = [ den.aspects.home-manager ];

  den.aspects.home-manager.nixos = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        inherit inputs;
      };
    };
  };
}
