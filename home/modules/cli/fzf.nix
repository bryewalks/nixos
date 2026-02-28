{ pkgs, ... }:

let
  dracula = import ../themes/dracula.nix;
  fzfColors = builtins.concatStringsSep " " [
    "--color=fg:${dracula.foreground}"
    "--color=bg:${dracula.background}"
    "--color=hl:${dracula.purple}"
    "--color=fg+:${dracula.foreground}"
    "--color=bg+:${dracula.selection}"
    "--color=hl+:${dracula.purple}"
    "--color=info:${dracula.orange}"
    "--color=prompt:${dracula.green}"
    "--color=pointer:${dracula.magenta}"
    "--color=marker:${dracula.magenta}"
    "--color=spinner:${dracula.orange}"
    "--color=header:${dracula.currentLine}"
  ];
in {
  home.packages = [ pkgs.fzf ];

  home.sessionVariables = {
    FZF_DEFAULT_OPTS = fzfColors;
  };
}
