{ ... }:

let dracula = import ../../themes/dracula.nix;
in {
  programs.nixvim = {
    plugins.git-conflict = {
      enable = true;
      settings = {
        default_mappings = {
          ours = "co";
          theirs = "ct";
          none = "cx";
          both = "cb";
          next = "cn";
          prev = "cp";
        };
      };
    };

    extraConfigLua = ''
      vim.api.nvim_set_hl(0, "GitConflictIncomingLabel", { bg = "${dracula.purple}", fg = "${dracula.selection}" })
      vim.api.nvim_set_hl(0, "GitConflictIncoming", { bg = "${dracula.lightPurple}", fg = "${dracula.selection}" })
      vim.api.nvim_set_hl(0, "GitConflictCurrentLabel", { bg = "${dracula.green}", fg = "${dracula.selection}" })
      vim.api.nvim_set_hl(0, "GitConflictCurrent", { bg = "${dracula.lightGreen}", fg = "${dracula.selection}" })
    '';
  };
}
