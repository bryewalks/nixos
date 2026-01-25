{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings.user.name = "bryewalks";
    settings.user.email = "bryewalks@gmail.com";
    settings.safe.directory = [ "/etc/nixos" ];
  };

  programs.zsh.enable = true;
  services.udiskie = {
    enable = true;
    automount = true;
  };

  home.packages = with pkgs; [
    ripgrep
    fd
  ];
}
