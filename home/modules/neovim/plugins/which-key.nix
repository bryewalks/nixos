{ lib, ... }:

{
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
      settings = { };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>b";
        action = "<CR>";
        options = { desc = "Buffer"; };
      }
      {
        mode = "n";
        key = "<leader>o";
        action = "<CR>";
        options = { desc = "Other"; };
      }
      {
        mode = "n";
        key = "<leader>bw";
        action = "<Cmd>WhichKey<CR>";
        options = { desc = "Which Key"; };
      }
      {
        mode = "n";
        key = "<leader>b?";
        action.__raw = ''
          	  function()
                      require("which-key").show({ global = false })
          	  end
          	'';
        options = { desc = "Buffer Local Keymaps (which-key)"; };
      }
    ];
  };
}
