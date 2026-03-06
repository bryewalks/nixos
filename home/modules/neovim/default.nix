{ inputs, ... }:

{
  imports = [
    ./keymaps.nix
    ./options.nix
    (inputs.import-tree ./plugins)
  ];

  programs.nixvim = {
    enable = true;
    nixpkgs.useGlobalPackages = true;
    colorschemes.dracula.enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    extraConfigLua = ''
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
      })
    '';
  };
}
