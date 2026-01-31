{ lib, ... }:

{
  programs.nixvim = {
    plugins.alpha = {
      enable = true;
      theme = "dashboard";
    };
    plugins.web-devicons.enable = true;
    # extraPlugins = with pkgs.vimPlugins; [
    #   web-devicons
    # ];
    extraConfigLua = ''
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.startify")
      dashboard.section.header.val = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                             [@bryewalks]                              ]],
        [[                                                                       ]],
      }
      alpha.setup(dashboard.opts)
    '';
  };
}
