{ ... }:

{
  programs.nixvim = {
    plugins.markdown-preview.enable = true;

    keymaps = [{
      mode = "n";
      key = "<leader>om";
      action = "<Cmd>MarkdownPreviewToggle<CR>";
      options = {
        noremap = true;
        desc = "Markdown Toggle";
      };
    }];
  };
}
