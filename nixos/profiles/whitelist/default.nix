{ lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      # Nvim Sidekick
      "copilot-language-server"
      "claude-code"
      "github-copilot-cli"
    ];
}
