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

    hyprland = {
      url = "github:hyprwm/Hyprland/v0.54.0";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland-easymotion = {
      url = "github:bryewalks/hyprland-easymotion";
      inputs.hyprland.follows = "hyprland";
    };

    hypr-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland";
    };

    import-tree = {
      url = "github:vic/import-tree";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };

    # Avoid using flatpaks unless necessary.
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    steam-config-nix = {
      url = "github:different-name/steam-config-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs =
    inputs@{
      disko,
      home-manager,
      hyprland,
      hyprland-easymotion,
      hyprland-plugins,
      impermanence,
      import-tree,
      nix-flatpak,
      nixpkgs,
      nixvim,
      self,
      sops-nix,
      stylix,
      steam-config-nix,
      zen-browser,
      ...
    }:

    let
      system = "x86_64-linux";

      mkHostWithImpermanence =
        hostName:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ({ ... }: {
              nixpkgs.overlays = [
                inputs.nix-cachyos-kernel.overlays.pinned
              ];
            })
            disko.nixosModules.disko
            hyprland.nixosModules.default
            impermanence.nixosModules.impermanence
            sops-nix.nixosModules.sops
            steam-config-nix.nixosModules.default
            (import-tree ./nixos/hosts/${hostName})
            (import-tree ./nixos/modules)
            home-manager.nixosModules.home-manager
            ({ config, ... }: {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
              home-manager.sharedModules = [
                hyprland.homeManagerModules.default
                nix-flatpak.homeManagerModules.nix-flatpak
                nixvim.homeModules.nixvim
                stylix.homeModules.stylix
                zen-browser.homeModules.beta
              ];
              home-manager.users.brye = import ./home/users/brye;
            })
          ];
        };
    in
    {
      diskoConfigurations.laptop = import ./nixos/hosts/laptop/disko.nix;
      nixosConfigurations.laptop = mkHostWithImpermanence "laptop";
      diskoConfigurations.desktop = import ./nixos/hosts/desktop/disko.nix;
      nixosConfigurations.desktop = mkHostWithImpermanence "desktop";
    };
}
