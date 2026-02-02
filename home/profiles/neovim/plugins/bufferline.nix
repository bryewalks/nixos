{ ... }:

{
  programs.nixvim = {
    plugins.bufferline = {
      enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<Tab>";
        action = "<Cmd>BufferLineCycleNext<CR>";
	options.desc = "Next Tab";
      }
      {
        mode = "n";
        key = "<S-Tab>";
        action = "<Cmd>BufferLineCyclePrev<CR>";
	options.desc = "Prev Tab";
      }
    ];
  };
}
