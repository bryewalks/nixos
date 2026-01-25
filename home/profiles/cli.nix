{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    user.name = "bryewalks";
    user.email = "bryewalks@gmail.com";
    extraConfig.safe.directory = [ "/etc/nixos" ];
  };

  programs.zsh.enable = true;

  home.packages = with pkgs; [
    ripgrep
    fd
  ];
}
