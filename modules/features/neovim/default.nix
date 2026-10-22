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
    };

    provides.to-users.homeManager = {
      imports = [
        inputs.nixvim.homeModules.nixvim
        ./_config
      ];
    };
  };
}
