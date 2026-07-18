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

    # INFO: Hyprland is pinned to avoid plugins breaking on upstream updates. Forks are kept at the last known working state for the pinned version. When upgrading Hyprland, verify all plugins build/work before syncing forks.
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.55.4";
    };

    hyprland-plugins = {
      # url = "github:hyprwm/hyprland-plugins";
      url = "github:bryewalks/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland-easymotion = {
      # url = "github:zakk4223/hyprland-easymotion";
      url = "github:bryewalks/hyprland-easymotion";
      inputs.hyprland.follows = "hyprland";
    };

    import-tree = {
      url = "github:vic/import-tree";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    den = {
      url = "github:denful/den";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };

    # INFO: Avoid using flatpaks unless necessary.
    # nix-flatpak = {
    #   url = "github:gmodena/nix-flatpak";
    # };

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

    mcp-servers-nix = {
      url = "github:natsukium/mcp-servers-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
