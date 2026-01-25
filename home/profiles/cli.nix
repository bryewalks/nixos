{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "bryewalks";
    userEmail = "bryewalks@gmail.com";
    extraConfig = {
      safe = {
        directory = [ "/etc/nixos" ];
      };
    };
  };

  programs.zsh.enable = true;

  home.packages = with pkgs; [
    ripgrep
    fd
  ];
}
