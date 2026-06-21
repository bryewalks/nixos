{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cmatrix
    cmus
    fastfetch
    fd
    lazydocker
    lsd
    ripgrep
    stow
    unzip
    yazi
  ];

  services.udiskie = {
    enable = true;
    automount = true;
  };

  imports = [
    ./btop.nix
    ./cava.nix
    ./fzf.nix
    ./zsh.nix
    ./tmux.nix
    ./git.nix
    ./ssh.nix
  ];
}
