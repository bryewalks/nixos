{ den, ... }:

{
  den.aspects.features.includes = [ den.aspects.terminals ];

  den.aspects.terminals.provides.to-users.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ kitty ];

      programs.kitty = {
        enable = true;
        settings = {
          font_size = 14;
          bold_font = "auto";
          italic_font = "auto";
          confirm_os_window_close = 0;
          cursor_trail = 1;
        };
      };
    };
}
