{ ... }:

{
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = ":Ex<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>ff";
      action = ":Telescope find_files<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = ":Telescope live_grep<CR>";
      options.silent = true;
    }
  ];
}
