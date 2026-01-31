{ pkgs, ... }:

{
  # Packages
  home.packages = with pkgs; [
    kitty
  ];

  programs.kitty = {
    enable = true;
    settings = {
      font_size = 14;
      # font_family = "CaskaydiaCove Nerd Font Mono";
      bold_font = "auto";
      italic_font = "auto";
      confirm_os_window_close = 0;
      curosr_trail = 1;
    };
  };
}
