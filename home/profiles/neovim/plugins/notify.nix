{ ... }:

{
  programs.nixvim = {
    plugins.notify = {
      enable = true;
      timeout = 1000;
      topDown = false;
      settings = { };
    };

    extraConfigLua = ''
      vim.notify = require("notify")
    '';
  };
}
