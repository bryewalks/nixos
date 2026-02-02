{ ... }:

{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      settings = { theme = "dracula"; };
    };
  };
}
