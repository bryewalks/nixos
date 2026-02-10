{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cmatrix
    cmus
    codex
    fastfetch
    fd
    lazydocker
    lsd
    ripgrep
    stow
    yazi
  ];

  services.udiskie = {
    enable = true;
    automount = true;
  };

  imports = [
    ./btop.nix
    ./cava.nix
    ./zsh.nix
    ./tmux.nix
    ./git.nix
    ./ssh.nix
  ];
}
