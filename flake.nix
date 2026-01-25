{
  description = "Brye's NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }:

  let
    system = "x86_64-linux";

    mkHost = hostName: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./nixos/profiles/base.nix
        ./nixos/profiles/hyprland.nix

	./nixos/hosts/${hostName}/hardware.nix
	./nixos/hosts/${hostName}/default.nix

	home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.brye = 
	    import ./home/users/brye/default.nix;
	}
      ];
    };
  in
  {
    nixosConfigurations.vm = mkHost "vm";
  };
}
