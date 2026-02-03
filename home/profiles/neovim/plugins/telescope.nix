{ pkgs, ... }:

{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      settings = {
        defaults.mappings = {
          i = {
            "<C-q>" = "actions.smart_send_to_qflist + actions.open_qflist";
            "<C-h>" = "actions.which_key";
          };
          n = {
            "<C-q>" = "actions.smart_send_to_qflist + actions.open_qflist";
            "<C-h>" = "actions.which_key";
          };
        };
        pickers = {
          find_files = {
            hidden = true;
            no_ignore = true;
          };
          live_grep = {
            additional_args.__raw = ''function() return { "--hidden", "--no-ignore" } end'';
          };
        };
        extensions = {
          undo = { };
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      telescope-ui-select-nvim
      # TODO build from gh?
      # telescope-vimwiki-nvim
      telescope-undo-nvim
    ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>f";
        action = "";
        options.desc = "Find";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action.__raw = ''require("telescope.builtin").find_files'';
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>fm";
        action.__raw = ''require("telescope.builtin").marks'';
        options.desc = "Find marks";
      }
      {
        mode = "n";
        key = "<leader>ft";
        action.__raw = ''require("telescope.builtin").git_branches'';
        options.desc = "Find git branches";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action.__raw = ''require("telescope.builtin").buffers'';
        options.desc = "Find buffers";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action.__raw = ''require("telescope.builtin").live_grep'';
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>fs";
        action.__raw = ''require("telescope.builtin").spell_suggest'';
        options.desc = "Find spelling";
      }
      {
        mode = "n";
        key = "<leader>fv";
        action = "<Cmd>Telescope vimwiki live_grep<CR>";
        options.desc = "Find vimwiki";
      }
      {
        mode = "n";
        key = "<leader>fd";
        action = "<Cmd>TodoTelescope<CR><C-[>";
        options.desc = "Find TODOs";
      }
      {
        mode = "n";
        key = "<leader>fa";
        action = "<Cmd>Noice telescope<CR><C-[>";
        options.desc = "Find Alerts";
      }
      {
        mode = "n";
        key = "<leader>fu";
        action = "<Cmd>Telescope undo<CR><C-[>";
        options.desc = "Find undos";
      }
    ];

    extraConfigLua = ''
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
              ["<C-h>"] = actions.which_key,
            },
            n = {
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
              ["<C-h>"] = actions.which_key,
            },
          },
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      })

      require("telescope").load_extension("ui-select")
      -- require("telescope").load_extension("vimwiki")
      require("telescope").load_extension("undo")
    '';
  };
}
