{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      none-ls = {
        enable = true;
        sources = {
          formatting = {
            stylua.enable = true;
            rubocop.enable = true;
            prettier = {
              enable = true;
              disableTsServerFormatter = true;
              package = pkgs.prettier;
            };
            black.enable = true;
            isort.enable = true;
            nixfmt.enable = true;
          };

          diagnostics = {
            rubocop.enable = true;
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>cf";
        action = "<Cmd>lua vim.lsp.buf.format()<CR>";
        options.desc = "Code Format";
      }
    ];
  };
}
