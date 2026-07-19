# _config/ holds the nixvim configuration as plain home-manager modules
# (underscored so import-tree leaves them alone).
{ den, inputs, ... }:

{
  den.aspects.features.includes = [ den.aspects.neovim ];

  # Sidekick stack (see _config/plugins/sidekick.nix).
  den.aspects.neovim.nixos = {
    mySystem.allowedUnfree = [
      "claude-code"
      "copilot-language-server"
      "github-copilot-cli"
      "git-conflict.nvim"
    ];
  };

  den.aspects.neovim.provides.to-users.homeManager = {
    imports = [
      inputs.nixvim.homeModules.nixvim
      ./_config
    ];
  };
}
