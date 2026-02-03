{ pkgs, ... }:

{
  programs.nixvim = {
    plugins.vimwiki = {
      enable = true;
      settings = { };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>w";
        action = "";
        options = {
          noremap = true;
          desc = "Wiki";
        };
      }
    ];

    extraConfigLua = ''
      vim.g.vimwiki_list = {
        {
          path = '~/Documents/Markdown/vimwiki',
          syntax = 'markdown',
          ext = '.md',
        },
      }
    '';
  };
}
