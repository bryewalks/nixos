# _config/ holds the nixvim configuration as plain home-manager modules
# (underscored so import-tree leaves them alone).
{ den, inputs, ... }:

{
  flake-file.inputs.nixvim = {
    url = "github:nix-community/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.workstation.includes = [ den.aspects.neovim ];

  den.aspects.neovim = {
    nixos = {
      # Sidekick stack (see _config/plugins/sidekick.nix).
      unfree.packages = [
        "claude-code"
        "copilot-language-server"
        "github-copilot-cli"
        "git-conflict.nvim"
      ];

      # BUG: nixos-unstable was stuck (as of 2026-10-14) on a nixpkgs commit
      # predating the fix for a bad pnpmDeps hash on typescript-language-server
      # 6.0.2 (nixpkgs PR #572951, commit eabfbbcf1f).
      nixpkgs.overlays = [
        (final: prev: {
          typescript-language-server =
            if prev.typescript-language-server.version == "6.0.2" then
              prev.typescript-language-server.overrideAttrs (old: {
                pnpmDeps = old.pnpmDeps.overrideAttrs (_: {
                  outputHash = "sha256-xR/EF60lVBsITKgH7wCM2wHM46PFQevD51KfCENSUH4=";
                });
              })
            else
              prev.typescript-language-server;
        })
      ];
      # End BUG
    };

    provides.to-users.homeManager = {
      imports = [
        inputs.nixvim.homeModules.nixvim
        ./_config
      ];
    };
  };
}
