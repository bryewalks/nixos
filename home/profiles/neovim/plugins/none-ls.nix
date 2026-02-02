{ ... }:

{
  programs.nixvim = {
    plugins = {
      none-ls = {
        enable = true;
        settings = { };
        sources = {
          formatting = {
            stylua.enable = true;
            rubocop.enable = true;
            prettier.enable = true;
            black.enable = true;
            isort.enable = true;
            nixfmt.enable = true;
          };

          diagnostics = {
            rubocop.enable = true;
            # eslint_d comes from none-ls-extras
            eslint_d.enable = true;
          };
        };
      };
    };

    keymaps = [{
      mode = "n";
      key = "<leader>cf";
      action = "<Cmd>lua vim.lsp.buf.format()<CR>";
      description = "Code Format";
    }]

    # Dependencies
    extraPlugins = with pkgs.nixvimPlugins; [
      none-ls-extras-nvim
    ];
  };
}
