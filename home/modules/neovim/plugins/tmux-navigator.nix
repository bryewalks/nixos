{ pkgs, ... }:

{
  programs.nixvim = {
    plugins.tmux-navigator = {
      enable = true;
      settings = { };
    };

    keymaps = [
      {
        mode = "n";
        key = "<c-h>";
        action = "<cmd><C-U>TmuxNavigateLeft<cr>";
        options.desc = "Navigate to the pane left (Tmux)";
      }
      {
        mode = "n";
        key = "<c-j>";
        action = "<cmd><C-U>TmuxNavigateDown<cr>";
        options.desc = "Navigate to the pane below (Tmux)";
      }
      {
        mode = "n";
        key = "<c-k>";
        action = "<cmd><C-U>TmuxNavigateUp<cr>";
        options.desc = "Navigate to the pane above (Tmux)";
      }
      {
        mode = "n";
        key = "<c-l>";
        action = "<cmd><C-U>TmuxNavigateRight<cr>";
        options.desc = "Navigate to the pane right (Tmux)";
      }
      {
        mode = "n";
        key = "<c-\\\\>";
        action = "<cmd><C-U>TmuxNavigatePrevious<cr>";
        options.desc = "Navigate to the previous pane (Tmux)";
      }
    ];
  };
}
