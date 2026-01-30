{ ... }:

{
  programs.nixvim.options = {
    number = true;
    relativenumber = true;
    mouse = "a";
    undofile = true;
    termguicolors = true;
    signcolumn = "yes";
  };
}
