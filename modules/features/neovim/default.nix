# _config/ holds the nixvim configuration as plain home-manager modules
# (underscored so import-tree leaves them alone).
{ den, inputs, ... }:

{
  den.aspects.features.includes = [ den.aspects.neovim ];

  den.aspects.neovim.provides.to-users.homeManager = {
    imports = [
      inputs.nixvim.homeModules.nixvim
      ./_config
    ];
  };
}
