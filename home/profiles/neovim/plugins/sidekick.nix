{ pkgs, ... }:

{
  programs.nixvim = {
    plugins.sidekick = {
      enable = true;
      settings = {
        cli = {
          mux = {
            backend = "tmux";
            enabled = true;
          };
        };
        nes = { enabled = false; };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<tab>";
        action.__raw = ''
          function()
            if not require("sidekick").nes_jump_or_apply() then
              return "<Tab>"
            end
          end
        '';
        options = {
          expr = true;
          desc = "Goto/Apply Next Edit Suggestion";
        };
      }
      {
        mode = [ "n" "t" "i" "x" ];
        key = "<c-.>";
        action.__raw = ''function() require("sidekick.cli").toggle() end'';
        options.desc = "Sidekick Toggle";
      }
      {
        mode = "n";
        key = "<leader>a";
        action = "";
        options.desc = "Sidekick";
      }
      {
        mode = "n";
        key = "<leader>aa";
        action.__raw = ''function() require("sidekick.cli").toggle() end'';
        options.desc = "Sidekick Toggle CLI";
      }
      {
        mode = "n";
        key = "<leader>as";
        action.__raw = ''function() require("sidekick.cli").select() end'';
        options.desc = "Select CLI";
      }
      {
        mode = "n";
        key = "<leader>ad";
        action.__raw = ''function() require("sidekick.cli").close() end'';
        options.desc = "Detach a CLI Session";
      }
      {
        mode = [ "x" "n" ];
        key = "<leader>at";
        action.__raw =
          ''function() require("sidekick.cli").send({ msg = "{this}" }) end'';
        options.desc = "Send This";
      }
      {
        mode = "n";
        key = "<leader>af";
        action.__raw =
          ''function() require("sidekick.cli").send({ msg = "{file}" }) end'';
        options.desc = "Send File";
      }
      {
        mode = "x";
        key = "<leader>av";
        action.__raw = ''
          function() require("sidekick.cli").send({ msg = "{selection}" }) end'';
        options.desc = "Send Visual Selection";
      }
      {
        mode = [ "n" "x" ];
        key = "<leader>ap";
        action.__raw = ''function() require("sidekick.cli").prompt() end'';
        options.desc = "Sidekick Select Prompt";
      }
      {
        mode = "n";
        key = "<leader>ac";
        action.__raw = ''
          function() require("sidekick.cli").toggle({ name = "codex", focus = true }) end'';
        options.desc = "Sidekick Toggle Codex";
      }
    ];
  };
}
