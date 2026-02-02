{ ... }:

{
  programs.nixvim = {
    plugins.leap = {
      enable = true;
      settings = { case_sensitive = true; };
    };

    keymaps = [
      {
        mode = [ "n" "x" "o" ];
        key = "s";
        action = "<Plug>(leap-forward)";
      }
      {
        mode = [ "n" "x" "o" ];
        key = "S";
        action = "<Plug>(leap-backward)";
      }
      {
        mode = "n";
        key = "gs";
        action = "<Plug>(leap-from-window)";
      }
    ];
  };
}
