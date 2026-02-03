{ ... }:

{
  imports = [
    ./keymaps.nix
    ./options.nix
    ./plugins/alpha.nix
    ./plugins/bufferline.nix
    ./plugins/colorizer.nix
    ./plugins/comment.nix
    ./plugins/completions.nix
    ./plugins/fugitive.nix
    ./plugins/git-conflict.nix
    ./plugins/gitsigns.nix
    ./plugins/hardtime.nix
    ./plugins/hop.nix
    ./plugins/indent-blankline.nix
    ./plugins/leap.nix
    ./plugins/lsp-config.nix
    ./plugins/lualine.nix
    ./plugins/markdown-preview.nix
    ./plugins/marks.nix
    ./plugins/neo-tree.nix
    ./plugins/neoscroll.nix
    ./plugins/noice.nix
    ./plugins/none-ls.nix
    ./plugins/notify.nix
    ./plugins/sidekick.nix
    ./plugins/telescope.nix
    ./plugins/tmux-navigator.nix
    ./plugins/todo-comments.nix
    ./plugins/treesitter-context.nix
    ./plugins/treesitter.nix
    ./plugins/trouble.nix
    ./plugins/vim-surround.nix
    ./plugins/vim-test.nix
    ./plugins/vimwiki.nix
    ./plugins/which-key.nix
  ];

  programs.nixvim = {
    enable = true;
    nixpkgs.useGlobalPackages = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    colorschemes.dracula.enable = true;

    globals.mapleader = " ";

    plugins = {
      telescope.enable = true;
      treesitter.enable = true;
    };
  };
}
