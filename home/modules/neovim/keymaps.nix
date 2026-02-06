{ ... }:

{
  programs.nixvim.keymaps = [
    # Easier visual movements
    {
      mode = "v";
      key = "J";
      action = ":m '>+1<CR>gv=gv";
      options.desc = "Move the highlighted line(s) down";
    }
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
      options.desc = "Move the highlighted line(s) up";
    }
    {
      mode = "v";
      key = ">";
      action = ">gv";
      options.desc = "Indent the highlighted line(s)";
    }
    {
      mode = "v";
      key = "<";
      action = "<gv";
      options.desc = "Unindent the highlighted line(s)";
    }
    # Navigate vim panes better
    {
      mode = "n";
      key = "<c-k>";
      action = ":wincmd k<CR>";
      options.desc = "Move to the pane above";
    }
    {
      mode = "n";
      key = "<c-j>";
      action = ":wincmd j<CR>";
      options.desc = "Move to the pane below";
    }
    {
      mode = "n";
      key = "<c-h>";
      action = ":wincmd h<CR>";
      options.desc = "Move to the pane left";
    }
    {
      mode = "n";
      key = "<c-l>";
      action = ":wincmd l<CR>";
      options.desc = "Move to the pane right";
    }
    # Rebind c-i to itself to distinguish between c-i and tab
    {
      mode = "n";
      key = "<c-i>";
      action = "<c-i>";
    }
    # Recenter the screen after <c-u> and <c-d>
    {
      mode = "n";
      key = "<c-u>";
      action = "<c-u>zz";
      options.desc = "Scroll up half a page and recenter";
    }
    {
      mode = "n";
      key = "<c-d>";
      action = "<c-d>zz";
      options.desc = "Scroll down half a page and recenter";
    }
    # Recenter the screen after searching
    {
      mode = "n";
      key = "n";
      action = "nzzzv";
      options.desc = "Search next and recenter";
    }
    {
      mode = "n";
      key = "N";
      action = "Nzzzv";
      options.desc = "Search previous and recenter";
    }
    # System clipboard helpers
    # Yank into system clipboard
    {
      mode = [ "n" "v" ];
      key = "<leader>y";
      action = ''"+y'';
      options.desc = "yank to clipboard motion";
    }
    {
      mode = [ "n" "v" ];
      key = "<leader>Y";
      action = ''"+Y'';
      options.desc = "yank to clipboard line";
    }
    # Delete into system clipboard
    {
      mode = [ "n" "v" ];
      key = "<leader>d";
      action = ''"+d'';
      options.desc = "delete to clipboard motion";
    }
    {
      mode = [ "n" "v" ];
      key = "<leader>D";
      action = ''"+D'';
      options.desc = "delete to clipboard line";
    }
    # Paste from system clipboard
    {
      mode = "n";
      key = "<leader>p";
      action = ''"+p'';
      options.desc = "paste from clipboard after cursor";
    }
    {
      mode = "n";
      key = "<leader>P";
      action = ''"+P'';
      options.desc = "paste from clipboard before cursor";
    }
    # Close current buffer
    {
      mode = "n";
      key = "<leader>bd";
      action = ":bd<CR>";
      options.desc = "Close current buffer";
    }
    # Sort
    {
      mode = "v";
      key = "<leader>s";
      action = ":sort<CR>";
      options.desc = "Sort visual selection";
    }
    {
      mode = "v";
      key = "<leader>S";
      action = ":sort!<CR>";
      options.desc = "Sort visual selection in reverse";
    }
  ];
}
