{ ... }:

{
  programs.nixvim = {
    options = {
      number = true;
      relativenumber = true;
      mouse = "a";
      undofile = true;
      termguicolors = true;
      signcolumn = "yes";
      expandtab = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      splitright = true;
      guicursor = [
        "n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100"
        "i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100"
        "r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100"
      ];
    };

    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    extraConfigLua = ''
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
      })
    '';
  };
}
