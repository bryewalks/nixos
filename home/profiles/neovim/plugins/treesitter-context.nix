{ ... }:

{
  programs.nixvim = {
    plugins.treesitter-context = {
      enable = true;
      settings = { };
    };
  };
}
