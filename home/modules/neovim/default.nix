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
    # INFO: Temp fix — nixvim's man page build (manDocsPackage) pulls in
    # nixos-render-docs, whose patches are currently out of sync with the
    # pinned nixpkgs and fail to apply. Disable until nixvim upstream fixes
    # the patch, then remove this.
    enableMan = false;

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
