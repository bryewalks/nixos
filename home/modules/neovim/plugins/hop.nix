{ ... }:

let dracula = import ../../themes/dracula.nix;
in {
  programs.nixvim = {
    plugins.hop = {
      enable = true;
      settings = { keys = "etovxqpdygfblzhckisuran"; };
    };

    keymaps = [
      {
        mode = [ "n" "v" ];
        key = "<leader><leader>";
        action = "";
        options = {
          noremap = true;
          desc = "Easy Motions";
        };
      }
      {
        mode = [ "n" "v" ];
        key = "<leader><leader>b";
        action = "<Cmd>HopWordBC<CR>";
        options = {
          noremap = true;
          desc = "Hop Word Backwords";
        };
      }
      {
        mode = [ "n" "v" ];
        key = "<leader><leader>w";
        action = "<Cmd>HopWordAC<CR>";
        options = {
          noremap = true;
          desc = "Hop Word Forwards";
        };
      }
      {
        mode = [ "n" "v" ];
        key = "<leader><leader>j";
        action = "<Cmd>HopLineStartAC<CR>";
        options = {
          noremap = true;
          desc = "Hop Line Start Forwards";
        };
      }
      {
        mode = [ "n" "v" ];
        key = "<leader><leader>k";
        action = "<Cmd>HopLineStartBC<CR>";
        options = {
          noremap = true;
          desc = "Hop Line Start Backwards";
        };
      }
      {
        mode = [ "n" "v" ];
        key = "<leader><leader>l";
        action = "<Cmd>HopWordCurrentLine<CR>";
        options = {
          noremap = true;
          desc = "Hop Word Current Line";
        };
      }
      {
        mode = [ "n" "v" ];
        key = "<leader><leader>f";
        action = "<Cmd>HopChar2<CR>";
        options = {
          noremap = true;
          desc = "Hop Find Chars 2";
        };
      }
    ];

    extraConfigLua = ''
      vim.cmd.hi("HopNextKey guifg=${dracula.cyan}")
      vim.cmd.hi("HopNextKey1 guifg=${dracula.magenta}")
      vim.cmd.hi("HopNextKey2 guifg=${dracula.purple}")
    '';
  };
}
