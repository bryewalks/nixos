{ config, ... }:

let palette = config.theme.palette;
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
      vim.api.nvim_set_hl(0, "GitConflictIncomingLabel", { bg = "${palette.purple}", fg = "${palette.selection}" })
      vim.api.nvim_set_hl(0, "GitConflictIncoming", { bg = "${palette.lightPurple}", fg = "${palette.selection}" })
      vim.api.nvim_set_hl(0, "GitConflictCurrentLabel", { bg = "${palette.green}", fg = "${palette.selection}" })
      vim.api.nvim_set_hl(0, "GitConflictCurrent", { bg = "${palette.lightGreen}", fg = "${palette.selection}" })
    '';
  };
}
