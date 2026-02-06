{ ... }:

{
  programs.nixvim = {
    plugins.hardtime = {
      enable = false;
      settings = { };
    };
  };
}
