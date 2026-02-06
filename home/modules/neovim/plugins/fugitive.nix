{ ... }:

{
  programs.nixvim = {
    plugins.fugitive = {
      enable = true;
      settings = { };
    };
  };
}
