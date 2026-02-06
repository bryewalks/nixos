{ ... }:

{
  programs.nixvim = {
    plugins.notify = {
      enable = true;
      settings = {
        timeout = 1000;
        top_down = false;
      };
    };

    extraConfigLua = ''
      vim.notify = require("notify")
    '';
  };
}
