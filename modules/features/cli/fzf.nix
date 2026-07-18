{ den, ... }:

{
  den.aspects.cli.provides.to-users.homeManager =
    { pkgs, theme, ... }:
    let
      palette = theme.palette;
      fzfColors = builtins.concatStringsSep " " [
        "--color=fg:${palette.foreground}"
        "--color=bg:${palette.background}"
        "--color=hl:${palette.purple}"
        "--color=fg+:${palette.foreground}"
        "--color=bg+:${palette.selection}"
        "--color=hl+:${palette.purple}"
        "--color=info:${palette.orange}"
        "--color=prompt:${palette.green}"
        "--color=pointer:${palette.magenta}"
        "--color=marker:${palette.magenta}"
        "--color=spinner:${palette.orange}"
        "--color=header:${palette.currentLine}"
      ];
    in
    {
      home.packages = [ pkgs.fzf ];

      home.sessionVariables = {
        FZF_DEFAULT_OPTS = fzfColors;
      };
    };
}
