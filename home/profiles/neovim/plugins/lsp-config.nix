{ ... }:

{
  programs.nixvim = {
    plugins = {
      lsp.enable = true;
      lsp.servers = {
        lua_ls.enable = true;
        ts_ls.enable = true;
        eslint.enable = true;
        cssls.enable = true;
        html.enable = true;
      };

      mason.enable = true;
      mason-lspconfig = {
        enable = true;
        ensureInstalled = [
          "lua_ls"
          "ts_ls"
          "eslint"
          "cssls"
          "html"
        ];
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>g";
        action = "";
        options.desc = "LSP";
      }
      {
        mode = "n";
        key = "K";
        action.__raw = "vim.lsp.buf.hover";
        options.desc = "Hover";
      }
      {
        mode = "n";
        key = "<leader>gK";
        action.__raw = "vim.lsp.buf.hover";
        options.desc = "Hover";
      }
      {
        mode = "n";
        key = "gd";
        action.__raw = "vim.lsp.buf.definition";
        options.desc = "Go to definition";
      }
      {
        mode = "n";
        key = "<leader>gd";
        action.__raw = "vim.lsp.buf.definition";
        options.desc = "Go to definition";
      }
      {
        mode = "n";
        key = "<leader>gr";
        action.__raw = "vim.lsp.buf.references";
        options.desc = "Go to references";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>c";
        action = "";
        options.desc = "Code";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>ca";
        action.__raw = "vim.lsp.buf.code_action";
        options.desc = "Code Action";
      }
    ];
  };
}
