{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "bryewalks";
    userEmail = "bryewalks@gmail.com";
  };

  programs.zsh.enable = true;

  home.packages = with pkgs; [
    ripgrep
    fd
  ];
}
