{
  description = "Brye's NixOS";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { disko, home-manager, impermanence, nixpkgs, nixvim, self, sops-nix
    , stylix, ... }:

    let
      system = "x86_64-linux";

      mkHost = hostName:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            sops-nix.nixosModules.sops

            ./nixos/hosts/${hostName}
            ./nixos/hosts/${hostName}/hardware.nix

            ./nixos/profiles
            ./nixos/profiles/sops
            ./nixos/profiles/sddm
            ./nixos/profiles/hyprland
            ./nixos/profiles/whitelist

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
              home-manager.users.brye = import ./home/users/brye;
            }
          ];
        };

      mkHostWithImpermanence = hostName:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            disko.nixosModules.disko
            impermanence.nixosModules.impermanence
            sops-nix.nixosModules.sops

            ./nixos/hosts/${hostName}
            ./nixos/hosts/${hostName}/hardware.nix
            ./nixos/hosts/${hostName}/disko.nix

            ./nixos/profiles
            ./nixos/profiles/impermanence
            ./nixos/profiles/sops
            ./nixos/profiles/sddm
            ./nixos/profiles/hyprland
            ./nixos/profiles/whitelist

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules =
                [ nixvim.homeModules.nixvim stylix.homeModules.stylix ];
              home-manager.users.brye = import ./home/users/brye;
            }
          ];
        };
    in {
      diskoConfigurations.laptop = import ./nixos/hosts/laptop/disko.nix;
      nixosConfigurations.vm = mkHost "vm";
      nixosConfigurations.laptop = mkHostWithImpermanence "laptop";
    };
}
