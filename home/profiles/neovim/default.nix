{ ... }:

{
  imports = [
    ./keymaps.nix
    ./options.nix
    ./plugins/alpha.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    colorschemes.dracula.enable = true;

    globals.mapleader = " ";

    plugins = {
      gitsigns.enable = true;
      lualine.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
    };
  };
}
