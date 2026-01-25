{
  description = "Brye's NixOS";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    sops-nix,
    home-manager,
    disko,
    ...
  }:

  let
    system = "x86_64-linux";

    mkHost = hostName: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        sops-nix.nixosModules.sops
        ./nixos/profiles/sops/default.nix
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

    mkHostWithDisko = hostName: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        disko.nixosModules.disko
        ./nixos/hosts/${hostName}/disko.nix

        sops-nix.nixosModules.sops
        ./nixos/profiles/sops/default.nix
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
    diskoConfigurations.laptop = import ./nixos/hosts/laptop/disko.nix;
    nixosConfigurations.vm = mkHost "vm";
    nixosConfigurations.laptop = mkHostWithDisko "laptop";
  };
}
