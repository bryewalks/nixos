{ pkgs, ... }:

{
  programs.nixvim = {
    plugins.vim-test =  {
      enable = true;
      settings = { };
    };
    plugins.vimux = {
      enable = true;
      settings = { };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>t";
        action = "";
        options.desc = "Test";
      }
      {
        mode = "n";
        key = "<leader>tn";
        action = "<cmd>TestNearest<cr>";
        options.desc = "Test Nearest";
      }
      {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>TestFile<cr>";
        options.desc = "Test File";
      }
      {
        mode = "n";
        key = "<leader>ts";
        action = "<cmd>TestSuite<cr>";
        options.desc = "Test Suite";
      }
      {
        mode = "n";
        key = "<leader>tl";
        action = "<cmd>TestLast<cr>";
        options.desc = "Test Last";
      }
      {
        mode = "n";
        key = "<leader>tv";
        action = "<cmd>TestVisit<cr>";
        options.desc = "Test Visit";
      }
    ];

    extraConfigLua = ''
      vim.cmd("let test#strategy = 'vimux'")
    '';
  };
}
