{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cava
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
    ./zsh.nix
    ./tmux.nix
    ./git.nix
    ./ssh.nix
  ];
}
